function [avgSNR, ripple, hist_SOS, avg] = SOSNoise_Muscle(I1, I2, I3, I4, trials, stdev_noise)

SOS1 = zeros(40,40,trials);

parfor n = 1:trials
    
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I4_noise = I4 + noise;
    
    SOS1(:,:,n) = sqrt(abs(I1_noise(6:45,6:45)).^2 + abs(I2_noise(6:45,6:45)).^2 ...
        + abs(I3_noise(6:45,6:45)).^2 + abs(I4_noise(6:45,6:45)).^2);
    
end

avg1 = zeros(40,1);
stdev1 = zeros(40,1);

for col = 1:40
    
    data_SOS1 = SOS1(:,col,:);
    data_SOS1 = data_SOS1(:);
    avg1(col) = mean(data_SOS1);
    stdev1(col) = std(data_SOS1);
    
end

avgSNR = mean(avg1 ./ stdev1);

ripple = 100 * (max(avg1) - min(avg1)) / mean(avg1);

data_SOS1 = SOS1(:,40,:);
data_SOS1 = data_SOS1(:);
hist_SOS = hist(data_SOS1, 20);

avg = mean(avg1);

end