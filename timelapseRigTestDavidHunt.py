import wiringpi
from time import sleep

motorpin = 18

framecount = 6
pulse_length = 1
settling_time = 0.5
shutter_length = 2
interval_delay = 0.2

gpio = wiringpi.GPIO(wiringpi.GPIO.WPI_MODE_GPIO)
gpio.pinMode(motorpin,gpio.OUTPUT)
wiringpi.pinMode(motorpin,1)

for i in range(0,framecount):
    gpio.digitalWrite(motorpin,gpio.HIGH)
    print "Turning motor on..."
    sleep(pulse_length)
    gpio.digitalWrite(motorpin,gpio.LOW)
    print "Turning motor off..."
    sleep(settling_time)
wiringpi.pinMode(motorpin,0)
