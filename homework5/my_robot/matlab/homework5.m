clear
% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading
log_file = lcm.logging.Log('/home/alexa/work/Robotics-EECE-5698/homework5/my_robot/logFiles/lcm-log-2017-02-19-12:11:42', 'r'); 
magX = [];
magY = [];
magZ = [];
accX = [];
accY = [];
accZ = [];
gyroX = [];
gyroY = [];
gyroZ = [];
yaw = [];
pitch = [];
roll = [];
counter = 0;
% now read the file, plot the points until EOF
while true
 try
   ev = log_file.readNext();
   
   % channel name is in ev.channel
   % there may be multiple channels but in this case you are only interested in RDI channel
   if strcmp(ev.channel, 'INSdata')
 
     % build rdi object from data in this record
      ins_package = exlcm.ins(ev.data);

      % read in utm data
      magX(end+1) = ins_package.MagX;
      magY(end+1) = ins_package.MagY;
      magZ(end+1) = ins_package.MagZ;
      accX(end+1) = ins_package.AccelX;
      accY(end+1) = ins_package.AccelY;
      accZ(end+1) = ins_package.AccelZ;
      gyroX(end+1) = ins_package.GyroX;
      gyroY(end+1) = ins_package.GyroY;
      gyroZ(end+1) = ins_package.GyroZ;
      yaw(end+1) = ins_package.Yaw;
      pitch(end+1) = ins_package.Pitch;
      roll(end+1) = ins_package.Roll;
      counter = counter + 1;
      
    end
  catch err   % exception will be thrown when you hit end of file
     break;
 end
end
  figure(1)
  subplot(3, 2, 1)
  plot(accX)
  title('Accel X')
  subplot(3, 2, 2)
  histogram(accX)  
  subplot(3, 2, 3)  
  plot(accY)
  title('Accel Y')
  subplot(3, 2, 4)
  histogram(accY)
  subplot(3, 2, 5)
  plot(accZ)
  title('Accel Z')
  subplot(3, 2, 6)
  histogram(accZ)
  
  figure(2)
  subplot(3, 2, 1)
  plot(magX)
  title('Mag X')
  subplot(3, 2, 2)
  histogram(magX)
  subplot(3, 2, 3)  
  plot(magY)
  title('Mag Y')
  subplot(3,2,4)
  histogram(magY)
  subplot(3, 2, 5)
  plot(magZ)
  title('Mag Z')
  subplot(3,2,6)
  histogram(magZ)
  
  figure(3)
  subplot(3, 2, 1)
  plot(gyroX)
  title('Gyro X')
  subplot(3, 2, 2)
  histogram(gyroX)
  subplot(3, 2, 3)  
  plot(gyroY)
  title('Gyro Y')
  subplot(3, 2, 4)
  histogram(gyroY)
  subplot(3, 2, 5)
  plot(gyroZ)
  title('Gyro Z')
  subplot(3, 2, 6)
  histogram(gyroZ)
  
  figure(4)
  subplot(3, 2, 1)
  plot(yaw)
  title('Yaw')
  subplot(3, 2, 2)
  histogram(yaw)
  subplot(3, 2, 3)  
  plot(pitch)
  title('Pitch')
  subplot(3, 2, 4)
  histogram(pitch)
  subplot(3, 2, 5)
  plot(roll)
  title('Roll Z')
  subplot(3, 2, 6)
  histogram(roll)
  