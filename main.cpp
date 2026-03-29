#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "sht45sensor.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Create the sensor object
    SHT45Sensor sensor;

    // Set up the QML engine
    QQmlApplicationEngine engine;

    // Expose the sensor object to QML as "sensor"
    engine.rootContext()->setContextProperty("sensor", &sensor);

    // Load the main QML file
    engine.load(QUrl(QStringLiteral("qrc:/qml/testSensor.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}