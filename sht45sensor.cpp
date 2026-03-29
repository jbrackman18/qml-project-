#include "sht45sensor.h"
#include <QDebug>
#include <QThread>

Q_LOGGING_CATEGORY(sensorLog, "sht45.sensor")

SHT45Sensor::SHT45Sensor(QObject *parent)
    : QObject(parent)
    , m_port(new QSerialPort(this))
    , m_reconnectTimer(new QTimer(this))
    , m_pollTimer(new QTimer(this))
{
    // Reconnect timer: tries to connect every 2 seconds
    m_reconnectTimer->setInterval(2000);
    connect(m_reconnectTimer, &QTimer::timeout, this, &SHT45Sensor::tryConnect);

    // Serial port signals
    connect(m_port, &QSerialPort::readyRead, this, &SHT45Sensor::onReadyRead);
    connect(m_port, &QSerialPort::errorOccurred, this, &SHT45Sensor::onErrorOccurred);

    // Poll timer: just for heartbeat/status check (not sending commands)
    m_pollTimer->setInterval(1000);
    connect(m_pollTimer, &QTimer::timeout, this, &SHT45Sensor::checkConnection);

    tryConnect();  // attempt initial connection
}

void SHT45Sensor::tryConnect()
{
    if (m_port->isOpen()) {
        m_reconnectTimer->stop();
        return;
    }

    const QString portName = detectPort();
    if (portName.isEmpty()) {
        qCDebug(sensorLog) << "No port found, retrying in 2s...";
        m_reconnectTimer->start();
        return;
    }

    qCInfo(sensorLog) << "Attempting connection on" << portName;

    m_port->setPortName(portName);
    m_port->setBaudRate(QSerialPort::Baud115200);
    m_port->setDataBits(QSerialPort::Data8);
    m_port->setParity(QSerialPort::NoParity);
    m_port->setStopBits(QSerialPort::OneStop);
    m_port->setFlowControl(QSerialPort::NoFlowControl);

    if (m_port->open(QIODevice::ReadWrite)) {

        qCInfo(sensorLog) << "Connected to" << portName;

        m_buffer.clear();
        m_reconnectTimer->stop();
        setConnected(true);

        // 🔥 THIS is what you're missing
        m_port->setDataTerminalReady(false);
        m_port->setRequestToSend(false);
        QThread::msleep(100);
        m_port->setDataTerminalReady(true);
        m_port->setRequestToSend(true);

        // Give CircuitPython time to restart
        QThread::msleep(800);

        // Wake it up (like Arduino Serial Monitor does)
        m_port->write("\r\n");
        m_port->flush();
    } else {
        qCWarning(sensorLog) << "Failed to open" << portName << ":" << m_port->errorString();
        m_reconnectTimer->start();
    }
}

QString SHT45Sensor::detectPort() const
{
    const auto ports = QSerialPortInfo::availablePorts();
    qCInfo(sensorLog) << "Scanning" << ports.size() << "serial port(s)...";

    for (const QSerialPortInfo &info : ports) {
        qCDebug(sensorLog) << "  Port:" << info.portName()
        << "| Description:" << info.description()
        << "| Manufacturer:" << info.manufacturer()
        << "| VID:" << Qt::hex << info.vendorIdentifier()
        << "| PID:" << info.productIdentifier();

#ifdef Q_OS_WIN
        // Look for Adafruit devices or RP2040-based boards
        if (info.portName().startsWith("COM") &&
            (info.manufacturer().contains("Adafruit", Qt::CaseInsensitive) ||
             info.description().contains("USB Serial", Qt::CaseInsensitive) ||
             info.vendorIdentifier() == 0x239A)) {  // Adafruit VID
            qCInfo(sensorLog) << "Auto-detected port:" << info.portName();
            return info.portName();
        }
#else
        // Linux/Mac: Look for USB CDC/ACM devices
        if (info.portName().startsWith("ttyACM") || info.portName().startsWith("ttyUSB")) {
            // Additional check: Adafruit vendor ID
            if (info.vendorIdentifier() == 0x239A ||
                info.manufacturer().contains("Adafruit", Qt::CaseInsensitive)) {
                qCInfo(sensorLog) << "Auto-detected Adafruit port:" << info.portName();
                return info.portName();
            }
            // Fallback: use first ACM/USB port
            qCInfo(sensorLog) << "Auto-detected port:" << info.portName();
            return info.portName();
        }
#endif
    }

    return {};
}

void SHT45Sensor::onReadyRead()
{
    QByteArray data = m_port->readAll();
    qCInfo(sensorLog) << "RAW DATA:" << data;   // <-- ADD THIS
    m_buffer += data;

    while (m_buffer.contains('\n')) {
        int idx = m_buffer.indexOf('\n');

        QByteArray lineBytes = m_buffer.left(idx).trimmed(); // <-- FIX
        m_buffer = m_buffer.mid(idx + 1);

        QString line = QString::fromUtf8(lineBytes);
        if (!line.isEmpty()) {
            qCDebug(sensorLog) << "Received:" << line;
            parseLine(line);
        }
    }

    if (m_buffer.size() > 2048) {
        qCWarning(sensorLog) << "Buffer overflow, clearing";
        m_buffer.clear();
    }
}

void SHT45Sensor::parseLine(const QString &line)
{
    if (line.isEmpty() || line.startsWith('#'))
        return;

    const QStringList parts = line.split(',');

    // Update for 2-field CSV
    if (parts.size() < 2) {
        qCDebug(sensorLog) << "Invalid line format (expected 2 fields):" << line;
        return;
    }

    bool ok;

    // Parse temperature
    const double temp = parts[0].trimmed().toDouble(&ok);
    if (ok && qAbs(temp - m_temperature) > 0.01) {
        m_temperature = temp;
        emit temperatureChanged();
        qCDebug(sensorLog) << "Temperature:" << temp << "°C";
    }

    // Parse humidity
    const double hum = parts[1].trimmed().toDouble(&ok);
    if (ok && qAbs(hum - m_humidity) > 0.01) {
        m_humidity = hum;
        emit humidityChanged();
        qCDebug(sensorLog) << "Humidity:" << hum << "%";
    }

    // Optional: clear touch and serial number, since they're not sent
    m_touch = 0;
    emit touchChanged();
    m_serialNumber.clear();
    emit serialNumberChanged();
}

void SHT45Sensor::onErrorOccurred(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::NoError)
        return;

    qCWarning(sensorLog) << "Serial port error:" << m_port->errorString();
    m_port->close();
    setConnected(false);
    qCInfo(sensorLog) << "Disconnected, will attempt reconnect...";
    m_reconnectTimer->start();
}

void SHT45Sensor::setConnected(bool connected)
{
    if (connected != m_connected) {
        m_connected = connected;
        emit connectedChanged();

        if (m_connected) {
            m_pollTimer->start();
            qCInfo(sensorLog) << "Started connection monitor";
        } else {
            m_pollTimer->stop();
            qCInfo(sensorLog) << "Stopped connection monitor";
        }
    }
}

void SHT45Sensor::checkConnection()
{
    // Just verify the port is still open
    // The Adafruit device should send data automatically
    if (!m_port->isOpen()) {
        qCWarning(sensorLog) << "Port closed unexpectedly";
        setConnected(false);
        m_reconnectTimer->start();
    }
}

void SHT45Sensor::readSensor()
{
    // This method can be called manually from QML
    // Most Adafruit CircuitPython devices send data automatically,
    // but you can implement a command here if your firmware supports it
    if (!m_port->isOpen()) {
        qCWarning(sensorLog) << "Cannot read: port not open";
        return;
    }

    // If your firmware responds to a specific command, send it here:
    // QByteArray cmd = "read\n";
    // m_port->write(cmd);

    qCDebug(sensorLog) << "Manual read requested (device should auto-send data)";
}
