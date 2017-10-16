function [avgSNR, contrast, ripple, hist_CS, avg] = CSNoise_AbstractTissues(I1, I2, I3, I4, trials, stdev_noise)

CS1 = zeros(39,128,trials);

for n = 1:trials
    
    noise = normrnd(0, stdev_noise, 39, 128) + 1i * normrnd(0, stdev_noise, 39, 128);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 39, 128) + 1i * normrnd(0, stdev_noise, 39, 128);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 39, 128) + 1i * normrnd(0, stdev_noise, 39, 128);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 39, 128) + 1i * normrnd(0, stdev_noise, 39, 128);
    I4_noise = I4 + noise;
    
    CS1(:,:,n) = abs(I1_noise(15:39,15:114) + I2_noise(15:39,15:114) + I3_noise(15:39,15:114) + I4_noise(15:39,15:114));
    
end

avg1 = zeros(100,1);

stdev1 = zeros(100,1);


for col = 1:100
    
    data_CS1 = CS1(:,col,:);
    data_CS1 = data_CS1(:);
    
    avg1(col) = mean(data_CS1);
    
    stdev1(col) = std(data_CS1);
    
    
end

avgSNR = zeros(1,4);
avgSNR(1) = mean(avg1 ./ stdev1);


contrast = zeros(1,6);
% contrast(1) = 2 * (mean(avg1) - mean(avg2)) / (mean(avg1) + mean(avg2));
% contrast(2) = 2 * (mean(avg1) - mean(avg3)) / (mean(avg1) + mean(avg3));
% contrast(3) = 2 * (mean(avg1) - mean(avg4)) / (mean(avg1) + mean(avg4));
% contrast(4) = 2 * (mean(avg2) - mean(avg3)) / (mean(avg2) + mean(avg3));
% contrast(5) = 2 * (mean(avg2) - mean(avg4)) / (mean(avg2) + mean(avg4));
% contrast(6) = 2 * (mean(avg3) - mean(avg4)) / (mean(avg3) + mean(avg4));

ripple = zeros(1,4);
ripple(1) = 100 * (max(avg1) - min(avg1)) / mean(avg1);


data_CS1 = CS1(:,100,:);
data_CS1 = data_CS1(:);

hist_CS1 = hist(data_CS1, 20);


hist_CS = zeros(4,20);
hist_CS(1,:) = hist_CS1;

avg = mean(avg1) ;

end