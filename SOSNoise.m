function [avgSNR, contrast, ripple, hist_SOS, avg] = SOSNoise(I1, I2, I3, I4, trials, stdev_noise)

SOS1 = zeros(33,100,trials);
SOS2 = zeros(33,100,trials);
SOS3 = zeros(33,100,trials);

parfor n = 1:trials
    
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I4_noise = I4 + noise;
    
    SOS1(:,:,n) = sqrt(abs(I1_noise(15:47,15:114)).^2 + abs(I2_noise(15:47,15:114)).^2 ...
        + abs(I3_noise(15:47,15:114)).^2 + abs(I4_noise(15:47,15:114)).^2);
    SOS2(:,:,n) = sqrt(abs(I1_noise(48:80,15:114)).^2 + abs(I2_noise(48:80,15:114)).^2 ...
        + abs(I3_noise(48:80,15:114)).^2 + abs(I4_noise(48:80,15:114)).^2);
    SOS3(:,:,n) = sqrt(abs(I1_noise(81:113,15:114)).^2 + abs(I2_noise(81:113,15:114)).^2 ...
        + abs(I3_noise(81:113,15:114)).^2 + abs(I4_noise(81:113,15:114)).^2);
    
end

avg1 = zeros(100,1);
avg2 = zeros(100,1);
avg3 = zeros(100,1);
stdev1 = zeros(100,1);
stdev2 = zeros(100,1);
stdev3 = zeros(100,1);

parfor col = 1:100
    
    data_SOS1 = SOS1(:,col,:);
    data_SOS1 = data_SOS1(:);
    data_SOS2 = SOS2(:,col,:);
    data_SOS2 = data_SOS2(:);
    data_SOS3 = SOS3(:,col,:);
    data_SOS3 = data_SOS3(:);
    avg1(col) = mean(data_SOS1);
    avg2(col) = mean(data_SOS2);
    avg3(col) = mean(data_SOS3);
    stdev1(col) = std(data_SOS1);
    stdev2(col) = std(data_SOS2);
    stdev3(col) = std(data_SOS3);
    
end

avgSNR = zeros(1,3);
avgSNR(1) = mean(avg1 ./ stdev1);
avgSNR(2) = mean(avg2 ./ stdev2);
avgSNR(3) = mean(avg3 ./ stdev3);

contrast = zeros(1,3);
contrast(1) = 2 * (mean(avg1) - mean(avg2)) / (mean(avg1) + mean(avg2));
contrast(2) = 2 * (mean(avg1) - mean(avg3)) / (mean(avg1) + mean(avg3));
contrast(3) = 2 * (mean(avg2) - mean(avg3)) / (mean(avg2) + mean(avg3));

ripple = zeros(1,3);
ripple(1) = 100 * (max(avg1) - min(avg1)) / mean(avg1);
ripple(2) = 100 * (max(avg2) - min(avg2)) / mean(avg2);
ripple(3) = 100 * (max(avg3) - min(avg3)) / mean(avg3);

data_SOS1 = SOS1(:,100,:);
data_SOS1 = data_SOS1(:);
data_SOS2 = SOS2(:,100,:);
data_SOS2 = data_SOS2(:);
data_SOS3 = SOS3(:,100,:);
data_SOS3 = data_SOS3(:);
hist_SOS1 = hist(data_SOS1, 20);
hist_SOS2 = hist(data_SOS2, 20);
hist_SOS3 = hist(data_SOS3, 20);

hist_SOS = zeros(3,20);
hist_SOS(1,:) = hist_SOS1;
hist_SOS(2,:) = hist_SOS2;
hist_SOS(3,:) = hist_SOS3;
avg = [mean(avg1) mean(avg2) mean(avg3)];

end