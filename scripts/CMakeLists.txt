CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

# install script files

IF (TIZEN_MOBILE)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/mobile/bt-stack-up.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/mobile/bt-stack-down.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/mobile/bt-reset-env.sh DESTINATION etc/bluetooth)
ELSE ()
IF (TIZEN_WEARABLE)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/wearable/bt-stack-up.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/wearable/bt-stack-down.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/wearable/bt-reset-env.sh DESTINATION etc/bluetooth)
ELSE ()
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/etc/bt-stack-up.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/etc/bt-stack-down.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/etc/bt-reset-env.sh DESTINATION etc/bluetooth)
# install booting script
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/etc/bluetooth-address DESTINATION /etc/rc.d/init.d)
ENDIF (TIZEN_WEARABLE)
ENDIF (TIZEN_MOBILE)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/bt-edutm-on.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/bt-edutm-dev-up.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/bt-edutm-mode-on.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/bt-edutm-off.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/bt-hci-logdump.sh DESTINATION etc/bluetooth)
INSTALL(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/bt-run-hcidump.sh DESTINATION etc/bluetooth)
