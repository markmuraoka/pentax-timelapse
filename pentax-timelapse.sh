echo "Making new directory..."
mkdir pentax-stationary
cd pentax-stationary

echo "Taking pictures now..."
sudo pktriggercord-cli --frames 125 --delay 8 -o timelapse

# Use imagemagick to crop and resize for 1080p
echo "Cropping and resizing for 1080p..."
for i in `seq -w 0 124`; do convert timelapse-00${i}.jpg -gravity Center -crop 4272x2403+0+0 +repage -resize 1920x1080 -quality 90 timelapse-00${i}_small.jpg; done

# Create the video using ffmpeg
echo "Converting into video..."
ffmpeg -r 25 -i timelapse-%04d_small.jpg -b:v 1800k -aspect 16:9 stationary-pentax-timelapse.mkv

# Upload the video to dropbox
echo "Uploading to Dropbox..."
cd /home/mark/Melfina
./dropbox_uploader.sh upload /home/mark/timelapse/pentax-stationary/stationary-pentax-timelapse.mkv

echo "Done!"
