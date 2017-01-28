#!/usr/bin/env python
# -*- coding: utf-8 -*-
# for NBOSI-CT sensor (seabed 125)

import sys
import lcm
import time
import serial
from exlcm import gpsData
import csv


class Ct(object):
    def __init__(self, port_name):
        self.port = serial.Serial(port_name, 4800, timeout=1.)  # 9600-N-8-1
        self.lcm = lcm.LCM("udpm://?ttl=12")
        self.gps_package = gpsData()
    def msg_handler(self, data):
        print("time stamp = %s" % str(data.timestamp))
        print("latitude = %s" % str(data.lat))
        print("longitude = %s" % str(data.lon))
        print("Altitude = %s" % str(data.alt))

    def readloop(self):
        print("got into readloop")
        f = open('gpsData.txt')
        while True:
            line = self.port.readline()
            line = f.readline()
            data = [x for x in line.split(',')]
            try:
                if data[0] == "$GPGGA":
                    if(int(data[6]) != 0):
                        self.gps_package.timestamp = float(data[1])
                        self.gps_package.lat = float(data[2])
                        self.gps_package.lon = float(data[4])
                        fix = data[6]
                        numSat = data[7]
                        HDOP = data[8]
                        self.gps_package.alt = float(data[9])
                        heightGeoid = data[10]
                        lastDGPS = data[11]
                        DGPSref = data[12]
                        self.msg_handler(self.gps_package)
                        self.lcm.publish("Example", self.gps_package.encode())
                        time.sleep(1)
                    else:
                        print("No GPS Signal")
            except:
                    print("Formating issues")
                       

       
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print "Usage: %s <serial_port>\n" % sys.argv[0]
        sys.exit(0)
    myct = Ct(sys.argv[1])
    print("Before readloop")
    myct.readloop()

