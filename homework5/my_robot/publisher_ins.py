#!/usr/bin/env python

from exlcm import ins as insData
import serial
import sys
import lcm
import time

class InsOb(object):
    def __init__(self, port_name):
        # 115200-N-8-1
        self.port = serial.Serial(port_name, 115200, timeout = 1)
        self.lcm = lcm.LCM("udpm://?ttl=12")
        self.ins_package = insData()

    def readloop(self):
        
        while True:
            line = self.port.readline()
            data = [x for x in line.split(',')]
            if data[0] == "$VNYMR":
                print(data)
                self.ins_package.Yaw = float(data[1])
                self.ins_package.Pitch = float(data[2])
                self.ins_package.Roll = float(data[3])
                self.ins_package.MagX = float(data[4])
                self.ins_package.MagY = float(data[5])
                self.ins_package.MagZ = float(data[6])
                self.ins_package.AccelX = float(data[7])
                self.ins_package.AccelY = float(data[8])
                self.ins_package.AccelZ = float(data[9])
                self.ins_package.GyroX = float(data[10])
                self.ins_package.GyroY = float(data[11])
                # Splits out the checksum
                data2 = [x for x in data[12].split('*')]
                self.ins_package.GyroZ = float(data2[0])
                self.lcm.publish("INSdata", self.ins_package.encode())



if __name__ == "__main__":
    if len(sys.argv) != 2:
        print "Usage: %s <serial_port>\n" % sys.argv[0]
    myIns = InsOb(sys.argv[1])
    myIns.readloop()

