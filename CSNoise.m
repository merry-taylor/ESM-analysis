function [avgSNR, contrast, ripple, hist_CS, avg] = CSNoise(I1, I2, I3, I4, trials, stdev_noise)

CS1 = zeros(33,100,trials);
CS2 = zeros(33,100,trials);
CS3 = zeros(33,100,trials);

parfor n = 1:trials
    
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I4_noise = I4 + noise;
    
    CS1(:,:,n) = abs(I1_noise(15:47,15:114) + I2_noise(15:47,15:114) + I3_noise(15:47,15:114) + I4_noise(15:47,15:114));
    CS2(:,:,n) = abs(I1_noise(48:80,15:114) + I2_noise(48:80,15:114) + I3_noise(48:80,15:114) + I4_noise(48:80,15:114));
    CS3(:,:,n) = abs(I1_noise(81:113,15:114) + I2_noise(81:113,15:114) + I3_noise(81:113,15:114) + I4_noise(81:113,15:114));
    
end

avg1 = zeros(100,1);
avg2 = zeros(100,1);
avg3 = zeros(100,1);
stdev1 = zeros(100,1);
stdev2 = zeros(100,1);
stdev3 = zeros(100,1);

parfor col = 1:100
    
    data_CS1 = CS1(:,col,:);
    data_CS1 = data_CS1(:);
    data_CS2 = CS2(:,col,:);
    data_CS2 = data_CS2(:);
    data_CS3 = CS3(:,col,:);
    data_CS3 = data_CS3(:);
    avg1(col) = mean(data_CS1);
    avg2(col) = mean(data_CS2);
    avg3(col) = mean(data_CS3);
    stdev1(col) = std(data_CS1);
    stdev2(col) = std(data_CS2);
    stdev3(col) = std(data_CS3);
    
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

data_CS1 = CS1(:,100,:);
data_CS1 = data_CS1(:);
data_CS2 = CS2(:,100,:);
data_CS2 = data_CS2(:);
data_CS3 = CS3(:,100,:);
data_CS3 = data_CS3(:);
hist_CS1 = hist(data_CS1, 20);
hist_CS2 = hist(data_CS2, 20);
hist_CS3 = hist(data_CS3, 20);

hist_CS = zeros(3,20);
hist_CS(1,:) = hist_CS1;
hist_CS(2,:) = hist_CS2;
hist_CS(3,:) = hist_CS3;
avg = [mean(avg1) mean(avg2) mean(avg3)];

end