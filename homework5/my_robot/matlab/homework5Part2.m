clear
% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading
log_file = lcm.logging.Log('/home/alexa/work/Robotics-EECE-5698/homework5/my_robot/logFiles/lcm-log-2017-02-20-18-13-49', 'r'); 
accX = [];
accY = [];
yawRate = [];
while true
 try
   ev = log_file.readNext();
   
   % channel name is in ev.channel
   % there may be multiple channels but in this case you are only interested in RDI channel
   if strcmp(ev.channel, 'INS_MODULE')
 
     % build rdi object from data in this record
      ins_package = exlcm.ins(ev.data);

      % read in ins data    
      accX(end+1) = ins_package.AccelX;    
      accY(end+1) = ins_package.AccelY;
      yawRate(end+1) = ins_package.Yaw;
    end
  catch err   % exception will be thrown when you hit end of file
     break;
 end
end

fs = 40;
tspan = [0:(1/fs): (1/fs)*length(accX)];
tspan(1) = [];

y = cumtrapz(tspan, accX);

figure(5)
subplot(2,1,1)
plot(accX)
subplot(2,1,2)
plot(y)

% Plot y
figure(2)
plot(accY)