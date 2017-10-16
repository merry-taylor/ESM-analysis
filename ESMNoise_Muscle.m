function [avgSNR, ripple, hist_ESM, avg] = ESMNoise_Muscle(I1, I2, I3, I4, trials, stdev_noise)

ESM = zeros(50,50,trials);

parfor n = 1:trials
    
    if mod(n,10000) == 0
        disp(['      Trial #' num2str(n)]);
    end
    
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 50, 50) + 1i * normrnd(0, stdev_noise, 50, 50);
    I4_noise = I4 + noise;
    
    ESM(:,:,n) = abs(EllipticalModel(I1_noise, I2_noise, I3_noise, I4_noise));
    
end

ESM = ESM(6:45,6:45,:);

avg1 = zeros(40,1);
stdev1 = zeros(40,1);

for col = 1:40
    
    data_ESM = ESM(:,col,:);
    data_ESM = data_ESM(:);
    avg1(col) = mean(data_ESM);
    stdev1(col) = std(data_ESM);
    
end

avgSNR = mean(avg1 ./ stdev1);

ripple = 100 * (max(avg1) - min(avg1)) / mean(avg1);

data_ESM = ESM(:,40,:);
data_ESM = data_ESM(:);
hist_ESM = hist(data_ESM, 20);

avg = mean(avg1);

end