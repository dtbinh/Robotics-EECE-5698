function output = dirYaw( t, gyroZ, fs )

time = 0:1/fs:(1/fs)*length(gyroZ);
time(1) = [];

index = find(t== time);
if (~isempty(index))
    output = gyroZ(index);
else
    output = interp1(time, gyroZ, t);
end

