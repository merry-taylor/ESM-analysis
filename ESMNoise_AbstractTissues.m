function [avgSNR, contrast, ripple, hist_ESM, avg] = ESMNoise_AbstractTissues(I1, I2, I3, I4, trials, stdev_noise)

ESM = zeros(128,128,trials);

parfor n = 1:trials
    
    if mod(n,1000) == 0
        disp(['      Trial #' num2str(n)]);
    end
    
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I4_noise = I4 + noise;
    
    ESM(:,:,n) = abs(EllipticalModel(I1_noise, I2_noise, I3_noise, I4_noise));
    
end

ESM = ESM(15:114,15:114,:);

avg1 = zeros(100,1);
avg2 = zeros(100,1);
avg3 = zeros(100,1);
avg4 = zeros(100,1);
stdev1 = zeros(100,1);
stdev2 = zeros(100,1);
stdev3 = zeros(100,1);
stdev4 = zeros(100,1);

parfor col = 1:100
    
    data_ESM1 = ESM(1:25,col,:);
    data_ESM1 = data_ESM1(:);
    data_ESM2 = ESM(26:50,col,:);
    data_ESM2 = data_ESM2(:);
    data_ESM3 = ESM(51:75,col,:);
    data_ESM3 = data_ESM3(:);
    data_ESM4 = ESM(76:100,col,:);
    data_ESM4 = data_ESM4(:);
    avg1(col) = mean(data_ESM1);
    avg2(col) = mean(data_ESM2);
    avg3(col) = mean(data_ESM3);
    avg4(col) = mean(data_ESM4);
    stdev1(col) = std(data_ESM1);
    stdev2(col) = std(data_ESM2);
    stdev3(col) = std(data_ESM3);
    stdev4(col) = std(data_ESM4);
    
end

avgSNR = zeros(1,4);
avgSNR(1) = mean(avg1 ./ stdev1);
avgSNR(2) = mean(avg2 ./ stdev2);
avgSNR(3) = mean(avg3 ./ stdev3);
avgSNR(4) = mean(avg4 ./ stdev4);

contrast = zeros(1,6);
contrast(1) = 2 * (mean(avg1) - mean(avg2)) / (mean(avg1) + mean(avg2));
contrast(2) = 2 * (mean(avg1) - mean(avg3)) / (mean(avg1) + mean(avg3));
contrast(3) = 2 * (mean(avg1) - mean(avg4)) / (mean(avg1) + mean(avg4));
contrast(4) = 2 * (mean(avg2) - mean(avg3)) / (mean(avg2) + mean(avg3));
contrast(5) = 2 * (mean(avg2) - mean(avg4)) / (mean(avg2) + mean(avg4));
contrast(6) = 2 * (mean(avg3) - mean(avg4)) / (mean(avg3) + mean(avg4));

ripple = zeros(1,4);
ripple(1) = 100 * (max(avg1) - min(avg1)) / mean(avg1);
ripple(2) = 100 * (max(avg2) - min(avg2)) / mean(avg2);
ripple(3) = 100 * (max(avg3) - min(avg3)) / mean(avg3);
ripple(4) = 100 * (max(avg4) - min(avg4)) / mean(avg4);

data_ESM1 = ESM(1:25,100,:);
data_ESM1 = data_ESM1(:);
data_ESM2 = ESM(26:50,100,:);
data_ESM2 = data_ESM2(:);
data_ESM3 = ESM(51:75,100,:);
data_ESM3 = data_ESM3(:);
data_ESM4 = ESM(76:100,100,:);
data_ESM4 = data_ESM4(:);
hist_ESM1 = hist(data_ESM1, 20);
hist_ESM2 = hist(data_ESM2, 20);
hist_ESM3 = hist(data_ESM3, 20);
hist_ESM4 = hist(data_ESM4, 20);

hist_ESM = zeros(4,20);
hist_ESM(1,:) = hist_ESM1;
hist_ESM(2,:) = hist_ESM2;
hist_ESM(3,:) = hist_ESM3;
hist_ESM(4,:) = hist_ESM4;
avg = [mean(avg1) mean(avg2) mean(avg3) mean(avg4)];

end