import lcm

from exlcm import ins

def my_handler(channel, data):
    msg = ins.decode(data)
    print("Received message on channel \"%s\"" % channel)
    print("   Yaw    = %s" % str(msg.Yaw))
    print('   Pitch  = {}'.format(msg.Pitch))
    print('   Roll   = {}'.format(msg.Roll))
    print("")

lc = lcm.LCM()
subscription = lc.subscribe("INS_MODULE", my_handler)

try:
    while True:
        lc.handle()
except KeyboardInterrupt:
    pass

lc.unsubscribe(subscription)
