cmake_minimum_required(VERSION 3.16)

project(EagleHacks2026 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appEagleHacks2026
    main.cpp
)

qt_add_qml_module(appEagleHacks2026
    URI EagleHacks2026
    QML_FILES
        Main.qml
        QML_FILES Bagle.qml
        QML_FILES Spread.qml
        QML_FILES ToastBagle.qml
        QML_FILES ToastingScreen.qml
        QML_FILES DoneScreen.qml
        QML_FILES maintainanceScreen.qml
        QML_FILES mscreen1.qml
        QML_FILES mscreen2.qml
        QML_FILES mscreen3.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appEagleHacks2026 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appEagleHacks2026
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appEagleHacks2026
    PRIVATE Qt6::Quick
)

install(TARGETS appEagleHacks2026
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
