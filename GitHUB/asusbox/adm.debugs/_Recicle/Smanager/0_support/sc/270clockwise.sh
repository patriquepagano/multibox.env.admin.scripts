#!/system/bin/sh

settings put system accelerometer_rotation 0 > /dev/null 2>&1
settings put system user_rotation 3 > /dev/null 2>&1

exit

adb shell settings put system accelerometer_rotation 0  #disable auto-rotate
adb shell settings put system user_rotation 3  #270° clockwise
accelerometer_rotation: auto-rotation, 0 disable, 1 enable
user_rotation: actual rotation, clockwise, 0 0°, 1 90°, 2 180°, 3 270°