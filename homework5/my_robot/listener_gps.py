#!/env/usr/python
import lcm

from exlcm import gps

def my_handler(channel, data):
    msg = gps.decode(data)
    if msg.fixQ == 0:
    	print 'GPS INVALID!'
    else:
	print("Received message on channel \"%s\"" % channel)
	print("   Timestamp = %s" % str(msg.timestamp))
	print '   Latitude  = {}'.format(msg.lat)
	print '   Longitude = {}'.format(msg.longi)
	print '   Altitude  = {} M'.format(msg.alt)
	print '   UTM X     = {}'.format(msg.utmX)
	print '   UTM Y     = {}'.format(msg.utmY)
	print("")

lc = lcm.LCM()
subscription = lc.subscribe("GPS_MODULE", my_handler)

try:
    while True:
        lc.handle()
except KeyboardInterrupt:
    pass

lc.unsubscribe(subscription)
