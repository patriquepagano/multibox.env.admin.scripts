function list_System_app () {

# para gerar a lista na box
export APPs=`pm list packages -f | grep -e '/system/app/' | sort`
APPsList=`echo "$APPs" | cut -d ":" -f 2`
echo "$APPsList"

}


