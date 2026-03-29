#pragma once
#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QTimer>
#include <QString>
#include <QLoggingCategory>

Q_DECLARE_LOGGING_CATEGORY(sensorLog)

class SHT45Sensor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double temperature READ temperature NOTIFY temperatureChanged)
    Q_PROPERTY(double humidity    READ humidity    NOTIFY humidityChanged)
    Q_PROPERTY(int    touch       READ touch       NOTIFY touchChanged)
    Q_PROPERTY(QString serialNumber READ serialNumber NOTIFY serialNumberChanged)
    Q_PROPERTY(bool   connected   READ connected   NOTIFY connectedChanged)

public:
    explicit SHT45Sensor(QObject *parent = nullptr);

    double  temperature()  const { return m_temperature; }
    double  humidity()     const { return m_humidity; }
    int     touch()        const { return m_touch; }
    QString serialNumber() const { return m_serialNumber; }
    bool    connected()    const { return m_connected; }

    // Optional manual read (Trinkey auto-sends data)
    Q_INVOKABLE void readSensor();

signals:
    void temperatureChanged();
    void humidityChanged();
    void touchChanged();
    void serialNumberChanged();
    void connectedChanged();

private slots:
    void onReadyRead();
    void onErrorOccurred(QSerialPort::SerialPortError error);
    void tryConnect();
    void checkConnection();  // optional reconnection monitoring

private:
    QSerialPort *m_port;
    QTimer      *m_reconnectTimer;
    QTimer      *m_pollTimer;   // <-- ADD THIS
    QByteArray   m_buffer;

    double  m_temperature  = 0.0;
    double  m_humidity     = 0.0;
    int     m_touch        = 0;
    QString m_serialNumber;
    bool    m_connected    = false;

    void parseLine(const QString &line);
    void setConnected(bool connected);
    QString detectPort() const;
};