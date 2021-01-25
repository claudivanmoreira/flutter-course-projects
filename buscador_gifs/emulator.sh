#!/bin/bash

device=$(avdmanager list avd | awk '/Name/ {print $2}' | grep -x 'MOTOE_NOUGAT')

avd_exists () {
    if [ -n "${device}" ] ; then
        return 200
    else
        echo "Device not found"
        exit 1
    fi
}

avd_create () {
    sdkmanager "platforms;android-25" "system-images;android-25;google_apis;x86_64" "build-tools;25.0.3"
    avdmanager create avd -n MOTOE_NOUGAT -k "system-images;android-25;google_apis;x86_64"
}

avd_start () {
    #Log options are v: detalhado, d: depuração, i: informativo, w: nível de registro de avisos, e: erro, s: silenciado
    #emulator @MOTOE_NOUGAT -logcat *:v > app.log
    emulator @MOTOE_NOUGAT
}

create=false
while getopts "c" flag; do
    case "${flag}" in
        c)
            create=true
            ;;
        ?) 
            echo "Usage: ..."
    esac
done
shift $((OPTIND-1))

avd_exists
result_avd_exists=$?
if [ "$create" == true ];
then
    echo "Creating emulator for API Level 25 - Android Nougat."
    avd_create
    avd_start
elif [ $result_avd_exists -eq 200 ] ; then
    echo "Virtual Device found. Await start."
    avd_start
else
     echo "Virtual Device not found."
fi