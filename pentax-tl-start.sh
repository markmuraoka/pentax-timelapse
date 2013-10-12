# make new directory to store new timelapse photos
sudo python /home/mark/Adafruit-Raspberry-Pi-Python-Code/Adafruit_CharLCD/write-start-tl.py
mkdir /home/mark/photos/$(date +%Y%m%d_%H%M%S) && cd $_

# take timelapse with pi (3 hours, 1 shot every 10 sec)
echo "Taking pictures with pktriggercord..."
sudo python /home/mark/Adafruit-Raspberry-Pi-Python-Code/Adafruit_CharLCD/write-tl-in-progress.py
sudo pktriggercord-cli --frames 3 --delay 8 -o timelapse
sudo python /home/mark/Adafruit-Raspberry-Pi-Python-Code/Adafruit_CharLCD/write-tl-end.py

# prepare pi for shutdown when recieve button press

#echo "Uploading to Dropbox..."
#tar -zcf /home/mark/Melfina/timelapse_pi.tar.gz /home/mark/Melfina/timelapse
#cd /home/mark/Melfina/
#sudo ./dropbox_uploader.sh upload timelapse_pi.tar.gz

#echo "Deleting files to make room for future timelapses..."
#sudo rm -r /home/mark/Melfina/timelapse
#sudo rm -r /home/mark/Melfina/timelapse_pi.tar.gz

