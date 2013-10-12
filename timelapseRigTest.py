#include <wiringPi.h>
from time import sleep

motorpin = 18

framecount = 6
pulse_length = 0.1
settling_time = 0.5
shutter_length = 2
interval_delay = 0.2

gpio = wiringPi.GPIO(wiringPi.GPIO.WPI_MODE_GPIO)
gpio.pinMode(motorpin,gpio.OUTPUT)
wiringPi.pinMode(motorpin,1)

for i in range(0,framecount):
    gpio.digitalWrite(motorpin,gpio.HIGH)
    sleep(pulse_length)
    gpio.digitalWrite(motorpin,gpio.LOW)
    sleep(settling_time)
time
