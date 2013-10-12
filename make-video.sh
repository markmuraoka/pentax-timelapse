# make new directory to store new timelapse photos
echo "Creating new directory..."
#mkdir $(date +%Y%m%d_%H%M%S) && cd $_
mkdir /home/mark/Melfina/timelapse && cd $_

# take timelapse with pi (3 hours, 1 shot every 10 sec)
echo "Taking pictures with camera module..."
sudo raspistill -vf -t 300000 -tl 2000 -o /home/mark/Melfina/timelapse/timelapse-%04d.jpg -w 1925 -h 1080

echo "Uploading to Dropbox..."
tar -zcf /home/mark/Melfina/timelapse_pi.tar.gz /home/mark/Melfina/timelapse
cd /home/mark/Melfina/
sudo ./dropbox_uploader.sh upload timelapse_pi.tar.gz

echo "Deleting files to make room for future timelapses..."
sudo rm -r /home/mark/Melfina/timelapse
sudo rm -r /home/mark/Melfina/timelapse_pi.tar.gz

echo "Done!"

