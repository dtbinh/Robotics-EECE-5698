
% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading
log_file = lcm.logging.Log('/home/alexa/work/Robotics-EECE-5698/homework5/my_robot/logFiles/lcm-log-2017-02-20-18-13-49', 'r'); 
magX = [];
magY = [];
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
      counter = counter + 1;
      
    end
  catch err   % exception will be thrown when you hit end of file
     break;
 end
  plot(magX, magY)
  
end
