# take timelapse with pi (3 hours, 1 shot every 10 sec)
echo "Taking picture"
sudo raspistill -vf -awb auto -o /home/mark/Melfina/timelapse/image2.jpg -w 1925 -h 1080

echo "Uploading to Dropbox..."
cd /home/mark/Melfina/
./dropbox_uploader.sh upload /home/mark/Melfina/timelapse/image2.jpg

echo "Done!"

