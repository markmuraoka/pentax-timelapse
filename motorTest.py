import wiringpi
from time import sleep

motorpin = 18

framecount = 1000000000
pulse_length = 0.1
settling_time = 0.5

gpio = wiringpi.GPIO(wiringpi.GPIO.WPI_MODE_GPIO)
gpio.pinMode(motorpin,gpio.OUTPUT)
wiringpi.pinMode(motorpin,1)

for i in range(0,framecount):
    gpio.digitalWrite(motorpin,gpio.HIGH)
    sleep(pulse_length)
    gpio.digitalWrite(motorpin,gpio.LOW)
    sleep(settling_time)
