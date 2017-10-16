function [avgSNR, contrast, ripple, hist_SOS, avg] = SOSNoise_AbstractTissues(I1, I2, I3, I4, trials, stdev_noise)

SOS1 =zeros(39,128,trials);

for n = 1:trials
    
    noise = normrnd(0, stdev_noise, 39, 128) + 1i * normrnd(0, stdev_noise, 39, 128);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 39, 128) + 1i * normrnd(0, stdev_noise, 39, 128);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 39, 128) + 1i * normrnd(0, stdev_noise, 39, 128);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 39, 128) + 1i * normrnd(0, stdev_noise, 39, 128);
    I4_noise = I4 + noise;
    
    SOS1(:,:,n) = sqrt(abs(I1_noise(15:39,15:114)).^2 + abs(I2_noise(15:39,15:114)).^2 ...
        + abs(I3_noise(15:39,15:114)).^2 + abs(I4_noise(15:39,15:114)).^2);

    
end

avg1 = zeros(100,1);

stdev1 = zeros(100,1);


for col = 1:100
    
    data_SOS1 = SOS1(:,col,:);
    data_SOS1 = data_SOS1(:);
    
    avg1(col) = mean(data_SOS1);
    
    stdev1(col) = std(data_SOS1);
    
    
end

avgSNR = mean(avg1 ./ stdev1);


contrast = zeros(1,6);
% contrast(1) = 2 * (mean(avg1) - mean(avg2)) / (mean(avg1) + mean(avg2));
% contrast(2) = 2 * (mean(avg1) - mean(avg3)) / (mean(avg1) + mean(avg3));
% contrast(3) = 2 * (mean(avg1) - mean(avg4)) / (mean(avg1) + mean(avg4));
% contrast(4) = 2 * (mean(avg2) - mean(avg3)) / (mean(avg2) + mean(avg3));
% contrast(5) = 2 * (mean(avg2) - mean(avg4)) / (mean(avg2) + mean(avg4));
% contrast(6) = 2 * (mean(avg3) - mean(avg4)) / (mean(avg3) + mean(avg4));

ripple = 100 * (max(avg1) - min(avg1)) / mean(avg1);

data_SOS1 = SOS1(:,100,:);
data_SOS1 = data_SOS1(:);

hist_SOS1 = hist(data_SOS1, 20);


hist_SOS = zeros(4,20);
hist_SOS(1,:) = hist_SOS1;

avg = mean(avg1);

end