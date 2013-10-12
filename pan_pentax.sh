echo "Make new directory for photos..."
mkdir pentax-pan
cd pentax-pan

echo "Taking pictures now..."
# Assuming 150 frames
sudo pktriggercord-cli --frames 25 --delay 8 -o timelapse

#  Use imagemagick  to resize/crop
echo "Cropping to pan size..."
for i in  seq -w 0 24 ; do convert timelapse-0${i}.png -gravity Center -crop 4272x2403+0+0 +repage -resize 1945x1080 -quality 90 timelapse-0${i}_small.jpg; done 

echo "Copying files into generator-friendly filenames..."
mkdir -p originals_in_order
x=1;for i in *.jpg; do counter=$(printf %04d $x); ln "$i" originals_in_order/img"$counter".jpg; x=$(($x+1)); done

echo "Blending images..."
mkdir -p /pentax-pan/blend
x=1;for i in *.jpg; do counter=$(printf %04d $x);counter2=$(printf %04d $(($x+1))); convert "$i" img"$counter2".jpg -average ../blend/img"$counter".jpg; x=$(($x+1)); done
cd ..

echo "Deleting old directories..."
sudo rm -r originals_in_order

echo "WARNING: Assuming files are already resized into 1920x1275!"
echo "Cropping files into 1080p..."
mkdir -p crop

x=1;for i in blend/*.jpg; do counter=$(printf %04d $x); convert -crop 1920x1080+"$x" "$i" crop/img"$counter".jpg; x=$(($x+1)); done

echo "Deleting old directories..."
sudo rm -r blend

# Create the video using ffmpeg
ffmpeg -r 25 -i img%04d_small.jpg -b 1800k -aspect 16:9 pentax-timelapse.mkv

# Upload video to Dropbox
cd /home/mark/Melfina
./dropbox_uploader.sh upload /home/mark/timelapse/pentax-pan/pentax-timelapse.mkv
