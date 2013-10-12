import webiopi
from time import sleep

GPIO = webiopi.GPIO

GPIO.setFunction(18, GPIO.OUT)
server = webiopi.Server(port=8000, login="webiopi", password="raspberry")

framecount = 6
pulse_length = 1000
settling_time = 1000
shutter_length = 2
interval_delay = 0.2

for i in range(0,framecount):
    GPIO.output(18, GPIO.HIGH)
    sleep(pulse_length)
    GPIO.output(18, GPIO.LOW)
    sleep(settling_time)
server.stop()
GPIO.setFunction(18,GPIO.IN)
time
