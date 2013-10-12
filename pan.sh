# take timelapse with pi (3 hours, 1 shot every 10 sec)
echo "Taking pictures with camera module..."
sudo raspistill -vf -t 10800000 -tl 10000 -o image_num_%d_today.jpg -w 1925 -h 1275

echo "Copying files into generator-friendly filenames..."
mkdir -p originals_in_order
x=1;for i in *.jpg; do counter=$(printf %04d $x); ln "$i" originals_in_order/img"$counter".jpg; x=$(($x+1)); done

echo "Blending images..."
mkdir -p blend
cd originals_in_order
x=1;for i in *.jpg; do counter=$(printf %04d $x);counter2=$(printf %04d $(($x+1))); convert "$i" img"$counter2".jpg -average ../blend/img"$counter".jpg; x=$(($x+1)); done
cd ..

echo "WARNING: Assuming files are already resized into 1920x1275!"
echo "Cropping files into 1080p..."
mkdir -p crop

x=1;for i in blend/*.jpg; do counter=$(printf %04d $x); convert -crop 1920x1080+"$x" "$i" crop/img"$counter".jpg; x=$(($x+1)); done

echo "Delete all old files and compress pictures for dropbox"
sudo rm -r /home/mark/timelapse/blend
sudo rm -r /home/mark/timelapse/originals_in_order 
tar -zcvf timelapse_pi.tar.gz /home/mark/timelapse/crop
mv timelapse_pi.tar.gz /home/mark/Melfina
cd /home/mark/Melfina
./dropbox_uploader.sh upload timelapse_pi.tar.gz

