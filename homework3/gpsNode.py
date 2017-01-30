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
        print "Begin Message"
        print("time stamp = %s" % str(self.gps_package.timestamp))
        print("latitude = %s" % str(self.gps_package.lat))
        print("latitude direction = %s" % self.gps_package.latDir)
        print("longitude = %s" % str(self.gps_package.lon))
        print("longitude direction = %s" % self.gps_package.lonDir)
        print("Altitude = %s" % str(self.gps_package.alt))
        print("UTM_X = %s" % str(self.gps_package.utm_x))
        print("UTM_Y %s" % str(self.gps_package.utm_y))
        print "End message"
        print ""

    def SetUTMData(self):
        utmData = utm.from_latlon(self.gps_package.lat, self.gps_package.lon)
        self.gps_package.utm_x = utmData[0]
        self.gps_package.utm_y = utmData[1]

    def convertDMStoDec(self, latLon, data):
        hr = 0
        mn = 0
        sec = 0
        # Need to test for 2 conditions
        # Aka, 4 digits in front of . if lat, 5 if lon
        if latLon == "lat":
            hr = int(data[0:2])
            mn = float(data[2:])
        elif latLon == "lon":
            hr = int(data[0:3])
            mn = float(data[3:])
        else:
            print("Error, not recognized format")
            return 0

        dec = float(hr) + float(mn)/60
        return dec


    def readloop(self):
        print("got into readloop")
        f = open('gpsData.txt')
        w = open('gpsDataResult.txt', 'w')

        while True:
            line = self.port.readline()
            data = [x for x in line.split(',')]
#            try:
            if data[0] == "$GPGGA":
                if(int(data[6]) != 0):
                    self.gps_package.timestamp = float(data[1])
                    latDec = self.convertDMStoDec("lat",data[2])
                    self.gps_package.lat = latDec if (data[3] == "N") else latDec * -1                    
                    self.gps_package.latDir = data[3]
                    lonDec = self.convertDMStoDec("lon",data[4])
                    self.gps_package.lon = lonDec if (data[5] == "E") else lonDec * -1
                    self.gps_package.lonDir = data[5]
                    fix = data[6]
                    numSat = data[7]
                    HDOP = data[8]
                    self.gps_package.alt = float(data[9])
                    heightGeoid = data[10]
                    lastDGPS = data[11]
                    DGPSref = data[12]
                    self.SetUTMData()
                    self.msg_handler()
                    line = str(self.gps_package.utm_x) + "," + str(self.gps_package.utm_y)
                    w.write(line)
                    self.lcm.publish("GPSdata", self.gps_package.encode())
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

