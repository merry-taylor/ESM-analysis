function [avgSNR, ripple, hist_CS, avg] = CSNoise_Muscle(I1, I2, I3, I4, trials, stdev_noise)

CS1 = zeros(40,40,trials);

parfor n = 1:trials
    
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I4_noise = I4 + noise;
    
    CS1(:,:,n) = abs(I1_noise(6:45,6:45) + I2_noise(6:45,6:45) + I3_noise(6:45,6:45) + I4_noise(6:45,6:45));
    
end

avg1 = zeros(40,1);
stdev1 = zeros(40,1);

for col = 1:40
    
    data_CS1 = CS1(:,col,:);
    data_CS1 = data_CS1(:);
    avg1(col) = mean(data_CS1);
    stdev1(col) = std(data_CS1);
    
end

avgSNR = mean(avg1 ./ stdev1);

ripple = 100 * (max(avg1) - min(avg1)) / mean(avg1);

data_CS1 = CS1(:,40,:);
data_CS1 = data_CS1(:);
hist_CS = hist(data_CS1, 20);

avg = mean(avg1);

end