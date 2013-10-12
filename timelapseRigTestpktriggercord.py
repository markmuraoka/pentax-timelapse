import wiringpi
import subprocess
from time import sleep

motorpin = 18

framecount = 150
pulse_length = 2
settling_time = 0.5
shutter_length = 2
interval_delay = 0.1

gpio = wiringpi.GPIO(wiringpi.GPIO.WPI_MODE_GPIO)
gpio.pinMode(motorpin,gpio.OUTPUT)
wiringpi.pinMode(motorpin,1)

for i in range(0,framecount):
    frame_no = i+1
    camera_call = 'sudo pktriggercord-cli -o raspi0%s' % str(frame_no)
    print "shooting frame %s" % str(frame_no)
    subprocess.call(camera_call,shell=True)
    sleep(interval_delay)
    gpio.digitalWrite(motorpin,gpio.HIGH)
    print "Turning motor on..."
    sleep(pulse_length)
    gpio.digitalWrite(motorpin,gpio.LOW)
    print "Turning motor off..."
    sleep(settling_time)
wiringpi.pinMode(motorpin,0)
