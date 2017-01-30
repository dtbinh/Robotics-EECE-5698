
% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading
log_file = lcm.logging.Log('/home/alexa/work/lcm-1.2.1/examples/python/data/lcm-log-2017-01-29-23:07:31', 'r'); 
x = []
y = []
% now read the file, plot the points until EOF
while true
 try
   ev = log_file.readNext();
   
   % channel name is in ev.channel
   % there may be multiple channels but in this case you are only interested in RDI channel
   if strcmp(ev.channel, 'GPSdata')
 
     % build rdi object from data in this record
      gps_package = exlcm.gpsData(ev.data);

      % read in utm data
      x(end+1) = gps_package.utm_x;
      y(end+1) = gps_package.utm_y;
    end
  catch err   % exception will be thrown when you hit end of file
     break;
 end
  plot(x,y)
  xlabel('utm_x')
  ylabel('utm_y')
  title('Sitting in place for 10 min')
  
end
