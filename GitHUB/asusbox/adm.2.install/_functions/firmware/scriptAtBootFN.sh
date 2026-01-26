function scriptAtBootFN () {
    if [ ! "$scriptAtBoot" == "" ]; then
        echo "runing code"
        eval "$scriptAtBoot"
    fi
}


