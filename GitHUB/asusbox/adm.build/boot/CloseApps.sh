#!/system/bin/sh

OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1 | grep -v "^dxidev.toptvlauncher2$"`
# apps abertos! perfeito para rodar no boot quando a box liga
AppListRunning=`dumpsys window windows \
   | busybox grep "Window #" \
   | busybox cut -d "/" -f 1 \
   | busybox sed -e "s/.*u0 //g" -e "s/}://g" -e "s/SurfaceView - //g" \
   | busybox uniq \
   | grep -v "^NavigationBar$" \
   | grep -v "^StatusBar$" \
   | grep -v "^KeyguardScrim$" \
   | grep -v "^AssistPreviewPanel$" \
   | grep -v "^DockedStackDivider$" \
   | grep -v "^android$" \
   | grep -v "^dxidev.toptvlauncher2$"`

echo "$AppListRunning

fechando os apps acima
" 
if [ ! "$OnScreenNow" == "" ]; then
    am force-stop $OnScreenNow
fi
echo "$AppListRunning" | while read app; do    
    if [ ! "$app" == "" ]; then
        echo $app
        am force-stop $app
    fi
done

echo "app que as vezes não fecha"
am force-stop com.not.aa_image_viewer

