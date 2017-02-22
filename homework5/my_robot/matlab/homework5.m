
% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading
log_file = lcm.logging.Log('/home/alexa/work/Robotics-EECE-5698/homework5/my_robot/logFiles/lcm-log-2017-02-19-12:11:42', 'r'); 
magX = [];
magY = [];
accX = [];
accY = [];
accZ = [];
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
      accX(end+1) = ins_package.AccelX;
      accY(end+1) = ins_package.AccelY;
      accZ(end+1) = ins_package.AccelZ;
      counter = counter + 1;
      
    end
  catch err   % exception will be thrown when you hit end of file
     break;
 end
  plot(magX, magY)
  subplot(2, 1, 1)
  plot(accX)
  title('Accel X')
  subplot(2, 1, 2)
  title('Accel Y')
  plot(accY)
end
