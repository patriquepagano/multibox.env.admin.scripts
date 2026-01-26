function list_priv_app () {

# para gerar a lista na box
export APPs=`pm list packages -f | grep -e '/system/priv-app/' | sort`
APPsList=`echo "$APPs" | cut -d ":" -f 2`
echo "$APPsList"

}


