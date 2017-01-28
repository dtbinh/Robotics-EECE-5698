#!/usr/bin/env python
# -*- coding: utf-8 -*-
# for NBOSI-CT sensor (seabed 125)

import sys
import lcm
import time
import serial
from exlcm import gpsData
import utm


class Ct(object):
    def __init__(self, port_name):
        self.port = serial.Serial(port_name, 4800, timeout=1.)  # 9600-N-8-1
        self.lcm = lcm.LCM("udpm://?ttl=12")
        self.gps_package = gpsData()
    def msg_handler(self):
        print("time stamp = %s" % str(self.gps_package.timestamp))
        print("latitude = %s" % str(self.gps_package.lat))
        print("longitude = %s" % str(self.gps_package.lon))
        print("Altitude = %s" % str(self.gps_package.alt))
        print("UTM_X = %s" % str(self.gps_package.utm_x))
        print("UTM_Y %s" % str(self.gps_package.utm_y))

    def SetUTMData(self):
        utmData = utm.from_latlon(self.gps_package.lat, self.gps_package.lon)
        self.gps_package.utm_x = utmData[0]
        self.gps_package.utm_y = utmData[1]

    def convertDMStoDec(self, data):
        row = data.split(".")
        hr = 0
        mn = 0
        sec = 0
        # Need to test for 2 conditions
        # Aka, 4 digits in front of . if lat, 5 if lon
        if len(row[0]) == 4:
            hr = int(row[0][0:2])
            mn = int(row[0][2:4])
            sec = int(row[1])
        elif len(row[0]) == 5:
            hr = int(row[0][0:3])
            mn = int(row[0][3:5])
            sec = int(row[1])
        else:
            print("Error, not recognized format")
            return 0

        dec = float(hr) + float(mn)/60 + float(sec)/3600
        return dec


    def readloop(self):
        print("got into readloop")
        f = open('gpsData.txt')
        while True:
            line = self.port.readline()
            line = f.readline()
            data = [x for x in line.split(',')]
#            try:
            if data[0] == "$GPGGA":
                if(int(data[6]) != 0):
                    self.gps_package.timestamp = float(data[1])
                    latDec = self.convertDMStoDec(data[2])
                    self.gps_package.lat = latDec
                    lonDec = self.convertDMStoDec(data[4])
                    self.gps_package.lon = lonDec
                    fix = data[6]
                    numSat = data[7]
                    HDOP = data[8]
                    self.gps_package.alt = float(data[9])
                    heightGeoid = data[10]
                    lastDGPS = data[11]
                    DGPSref = data[12]
                    self.SetUTMData()
                    self.msg_handler()
                    self.lcm.publish("Example", self.gps_package.encode())
                    time.sleep(1)
                else:
                    print("No GPS Signal")
#           except:
  #                  print("Formating issues")
                       

       
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print "Usage: %s <serial_port>\n" % sys.argv[0]
        sys.exit(0)
    myct = Ct(sys.argv[1])
    print("Before readloop")
    myct.readloop()

