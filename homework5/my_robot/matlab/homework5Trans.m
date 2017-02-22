clear
% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading
log_file = lcm.logging.Log('/home/alexa/work/Robotics-EECE-5698/homework5/my_robot/logFiles/lcm-log-2017-02-20-18-13-49', 'r'); 
counter = 0;
magXFul = [];
magYFul = [];
magX = [];
magY = [];
gyroZ = [];
yawRate = [];
accX = [];
accY = [];
while true
 try
   ev = log_file.readNext();
   
   % channel name is in ev.channel
   % there may be multiple channels but in this case you are only interested in RDI channel
   if strcmp(ev.channel, 'INS_MODULE')
 
     % build rdi object from data in this record
      ins_package = exlcm.ins(ev.data);

      % read in ins data
      if counter > 1350 && counter < 4020
        magX(end+1) = ins_package.MagX;
        magY(end+1) = ins_package.MagY;
      end
      magXFul(end+1) = ins_package.MagX;
      magYFul(end+1) = ins_package.MagY;
      gyroZ(end+1) = ins_package.GyroZ;
      accX(end+1) = ins_package.AccelX;    
      accY(end+1) = ins_package.AccelY;
      yawRate(end+1) = ins_package.Yaw;
      counter = counter + 1;
      
     
      
    end
  catch err   % exception will be thrown when you hit end of file
     break;
 end
end

 % Hard iron correction
 alpha = (max(magX) + min(magX))/2;
 beta = (max(magY) + min(magY))/2;
 
 
 figure(1) 
 axis([-.2, .5, -.2, .5])
 plot(magX,magY)
 hold on
 plot(alpha,beta, 'r*')
 hold on
 magX2 = magX - alpha; 
 magY2 = magY - beta; 
 plot(magX2, magY2)
 % center of corrected hard iron
 alpha2 = (max(magX2) + min(magX2))/2;
 beta2 = (max(magY2) + min(magY2))/2;
 hold on
 plot(alpha2, beta2, 'r*')
 
 % Soft Iron Correction
 %figure(2)
 hold on
 radius = sqrt(magX2.^2 + magY2.^2);
 maxRadius = max(radius);
 minRadius = min(radius);
 corrMax = find(radius == maxRadius); 
 theta = asin(magY2(corrMax)/maxRadius);
 
 R = [ cos(theta) sin(theta); -sin(theta) cos(theta) ];
 
 
 v1f = [magX2; magY2];
 v1 = R*v1f;

 % Plot rotated graph
 plot(v1(1,:),v1(2,:))
 hold on
 
 sigma = maxRadius/minRadius;
 xCor = v1(1,:)./sigma;
 
 % Plot the scaled magneometer
 plot(xCor, v1(2,:))
 
 % applied on full data
 figure(2)
 plot(magXFul, magYFul)
 hold on % Plot rotated graph
 plot(v1(1,:),v1(2,:))
 hold on
 magX2Ful = magXFul - alpha; 
 magY2Ful = magYFul - beta; 
 plot(magX2Ful, magY2Ful)
 
 v1f2 = [magX2Ful; magY2Ful];
 v12 = R*v1f2;
 
 % Plot rotated graph
 plot(v12(1,:),v12(2,:))
 hold on
 
 xCor2 = v12(1,:)./sigma;
 
 % Plot the scaled magneometer
 plot(xCor2, v12(2,:))
 yaw = atan2(-v12(2,:),xCor2);
 figure(3)
 plot(yaw)
 
 % Butter method (doesn't work)
 figure(4)
 fc = .5;
 fs = 40;
 [b,a] = butter(1, fc/(fs/2));
 dataIn = gyroZ;
 dataOut = filter(b,a,dataIn);
 
 plot(dataOut)
 hold on
 % ode method
 
 tspan = [0:(1/fs): (1/fs)*length(gyroZ)];
 tspan(1) = [];
 [t,y] = ode23(@(t,y) dirYaw(t, gyroZ, fs)*180/pi, tspan, yawRate(1)-180);
 y = mod(y,360) -180;
 figure(5)
 plot(t,y)
 
 
 % complemntary filter
 yaw2 = 0.98.*yaw'+ 0.02.*y;
 figure(6)
 
 plot(yaw2)
 
 
 % Part 2
 vel = [ ];
 %time = 0:1/fs:length(accX)*(1/40);
 %time(1)=[];
 accX = accX - mean(accX);
 for i = 2:length(tspan)
    vel(i) = trapz(tspan(1:i),accX(1:i));
 end
 
 vel = vel - min(vel);
 
figure(7)
subplot(4,1,1)
plot(accX)
subplot(4,1,2)
% plots velocity of X
plot(vel)

subplot(4,1,3)
plot(accY)

subplot(4,1,4)
result = yaw.*vel;
plot(result);


 

 
 
   
 