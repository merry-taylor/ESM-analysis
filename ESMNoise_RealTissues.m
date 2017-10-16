function [avgSNR, contrast, ripple, hist_ESM, avg] = ESMNoise_RealTissues(I1, I2, I3, I4, trials, stdev_noise)

ESM = zeros(128,128,trials);

for n = 1:trials
    
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

avg_Blood = zeros(100,1);
avg_Cartilage = zeros(100,1);
avg_Muscle = zeros(100,1);
avg_Graymatter = zeros(100,1);
avg_Fat = zeros(100,1);
avg_Whitematter = zeros(100,1);
avg_Synovial = zeros(100,1);

stdev_Blood = zeros(100,1);
stdev_Cartilage = zeros(100,1);
stdev_Muscle = zeros(100,1);
stdev_Graymatter = zeros(100,1);
stdev_Fat = zeros(100,1);
stdev_Whitematter = zeros(100,1);
stdev_Synovial = zeros(100,1);

for col = 1:100
    
    data_ESM_Blood = ESM(1:14,col,:);
    data_ESM_Blood = data_ESM_Blood(:);
    data_ESM_Cartilage = ESM(15:28,col,:);
    data_ESM_Cartilage = data_ESM_Cartilage(:);
    data_ESM_Muscle = ESM(29:42,col,:);
    data_ESM_Muscle = data_ESM_Muscle(:);
    data_ESM_Graymatter = ESM(43:56,col,:);
    data_ESM_Graymatter = data_ESM_Graymatter(:);
    data_ESM_Fat = ESM(57:70,col,:);
    data_ESM_Fat = data_ESM_Fat(:);
    data_ESM_Whitematter = ESM(71:85,col,:);
    data_ESM_Whitematter = data_ESM_Whitematter(:);
    data_ESM_Synovial = ESM(86:100,col,:);
    data_ESM_Synovial = data_ESM_Synovial(:);
    
    avg_Blood(col) = mean(data_ESM_Blood);
    avg_Cartilage(col) = mean(data_ESM_Cartilage);
    avg_Muscle(col) = mean(data_ESM_Muscle);
    avg_Graymatter(col) = mean(data_ESM_Graymatter);
    avg_Fat(col) = mean(data_ESM_Fat);
    avg_Whitematter(col) = mean(data_ESM_Whitematter);
    avg_Synovial(col) = mean(data_ESM_Synovial);
    
    stdev_Blood(col) = std(data_ESM_Blood);
    stdev_Cartilage(col) = std(data_ESM_Cartilage);
    stdev_Muscle(col) = std(data_ESM_Muscle);
    stdev_Graymatter(col) = std(data_ESM_Graymatter);
    stdev_Fat(col) = std(data_ESM_Fat);
    stdev_Whitematter(col) = std(data_ESM_Whitematter);
    stdev_Synovial(col) = std(data_ESM_Synovial);
    
end

avgSNR = zeros(1,7);
avgSNR(1) = mean(avg_Blood ./ stdev_Blood);
avgSNR(2) = mean(avg_Cartilage ./ stdev_Cartilage);
avgSNR(3) = mean(avg_Muscle ./ stdev_Muscle);
avgSNR(4) = mean(avg_Graymatter ./ stdev_Graymatter);
avgSNR(5) = mean(avg_Fat ./ stdev_Fat);
avgSNR(6) = mean(avg_Whitematter ./ stdev_Whitematter);
avgSNR(7) = mean(avg_Synovial ./ stdev_Synovial);

contrast = zeros(1,21);
contrast(1) = 2 * (mean(avg_Blood) - mean(avg_Cartilage)) / (mean(avg_Blood) + mean(avg_Cartilage));
contrast(2) = 2 * (mean(avg_Blood) - mean(avg_Muscle)) / (mean(avg_Blood) + mean(avg_Muscle));
contrast(3) = 2 * (mean(avg_Blood) - mean(avg_Graymatter)) / (mean(avg_Blood) + mean(avg_Graymatter));
contrast(4) = 2 * (mean(avg_Blood) - mean(avg_Fat)) / (mean(avg_Blood) + mean(avg_Fat));
contrast(5) = 2 * (mean(avg_Blood) - mean(avg_Whitematter)) / (mean(avg_Blood) + mean(avg_Whitematter));
contrast(6) = 2 * (mean(avg_Blood) - mean(avg_Synovial)) / (mean(avg_Blood) + mean(avg_Synovial));
contrast(7) = 2 * (mean(avg_Cartilage) - mean(avg_Muscle)) / (mean(avg_Cartilage) + mean(avg_Muscle));
contrast(8) = 2 * (mean(avg_Cartilage) - mean(avg_Graymatter)) / (mean(avg_Cartilage) + mean(avg_Graymatter));
contrast(9) = 2 * (mean(avg_Cartilage) - mean(avg_Fat)) / (mean(avg_Cartilage) + mean(avg_Fat));
contrast(10) = 2 * (mean(avg_Cartilage) - mean(avg_Whitematter)) / (mean(avg_Cartilage) + mean(avg_Whitematter));
contrast(11) = 2 * (mean(avg_Cartilage) - mean(avg_Synovial)) / (mean(avg_Cartilage) + mean(avg_Synovial));
contrast(12) = 2 * (mean(avg_Muscle) - mean(avg_Graymatter)) / (mean(avg_Muscle) + mean(avg_Graymatter));
contrast(13) = 2 * (mean(avg_Muscle) - mean(avg_Fat)) / (mean(avg_Muscle) + mean(avg_Fat));
contrast(14) = 2 * (mean(avg_Muscle) - mean(avg_Whitematter)) / (mean(avg_Muscle) + mean(avg_Whitematter));
contrast(15) = 2 * (mean(avg_Muscle) - mean(avg_Synovial)) / (mean(avg_Muscle) + mean(avg_Synovial));
contrast(16) = 2 * (mean(avg_Graymatter) - mean(avg_Fat)) / (mean(avg_Graymatter) + mean(avg_Fat));
contrast(17) = 2 * (mean(avg_Graymatter) - mean(avg_Whitematter)) / (mean(avg_Graymatter) + mean(avg_Whitematter));
contrast(18) = 2 * (mean(avg_Graymatter) - mean(avg_Synovial)) / (mean(avg_Graymatter) + mean(avg_Synovial));
contrast(19) = 2 * (mean(avg_Fat) - mean(avg_Whitematter)) / (mean(avg_Fat) + mean(avg_Whitematter));
contrast(20) = 2 * (mean(avg_Fat) - mean(avg_Synovial)) / (mean(avg_Fat) + mean(avg_Synovial));
contrast(21) = 2 * (mean(avg_Whitematter) - mean(avg_Synovial)) / (mean(avg_Whitematter) + mean(avg_Synovial));

ripple = zeros(1,7);
ripple(1) = 100 * (max(avg_Blood) - min(avg_Blood)) / mean(avg_Blood);
ripple(2) = 100 * (max(avg_Cartilage) - min(avg_Cartilage)) / mean(avg_Cartilage);
ripple(3) = 100 * (max(avg_Muscle) - min(avg_Muscle)) / mean(avg_Muscle);
ripple(4) = 100 * (max(avg_Graymatter) - min(avg_Graymatter)) / mean(avg_Graymatter);
ripple(5) = 100 * (max(avg_Fat) - min(avg_Fat)) / mean(avg_Fat);
ripple(6) = 100 * (max(avg_Whitematter) - min(avg_Whitematter)) / mean(avg_Whitematter);
ripple(7) = 100 * (max(avg_Synovial) - min(avg_Synovial)) / mean(avg_Synovial);

data_ESM_Blood = ESM(1:14,100,:);
data_ESM_Blood = data_ESM_Blood(:);
data_ESM_Cartilage = ESM(15:28,100,:);
data_ESM_Cartilage = data_ESM_Cartilage(:);
data_ESM_Muscle = ESM(29:42,100,:);
data_ESM_Muscle = data_ESM_Muscle(:);
data_ESM_Graymatter = ESM(43:56,100,:);
data_ESM_Graymatter = data_ESM_Graymatter(:);
data_ESM_Fat = ESM(57:70,100,:);
data_ESM_Fat = data_ESM_Fat(:);
data_ESM_Whitematter = ESM(71:85,100,:);
data_ESM_Whitematter = data_ESM_Whitematter(:);
data_ESM_Synovial = ESM(86:100,100,:);
data_ESM_Synovial = data_ESM_Synovial(:);

hist_ESM_Blood = hist(data_ESM_Blood, 20);
hist_ESM_Cartilage = hist(data_ESM_Cartilage, 20);
hist_ESM_Muscle = hist(data_ESM_Muscle, 20);
hist_ESM_Graymatter = hist(data_ESM_Graymatter, 20);
hist_ESM_Fat = hist(data_ESM_Fat, 20);
hist_ESM_Whitematter = hist(data_ESM_Whitematter, 20);
hist_ESM_Synovial = hist(data_ESM_Synovial, 20);

hist_ESM = zeros(7,20);
hist_ESM(1,:) = hist_ESM_Blood;
hist_ESM(2,:) = hist_ESM_Cartilage;
hist_ESM(3,:) = hist_ESM_Muscle;
hist_ESM(4,:) = hist_ESM_Graymatter;
hist_ESM(5,:) = hist_ESM_Fat;
hist_ESM(6,:) = hist_ESM_Whitematter;
hist_ESM(7,:) = hist_ESM_Synovial;
avg = [mean(avg_Blood) mean(avg_Cartilage) mean(avg_Muscle) mean(avg_Graymatter) ...
       mean(avg_Fat) mean(avg_Whitematter) mean(avg_Synovial)];


end