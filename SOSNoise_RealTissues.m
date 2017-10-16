function [avgSNR, contrast, ripple, hist_SOS, avg] = SOSNoise_RealTissues(I1, I2, I3, I4, trials, stdev_noise)

SOS_Blood = zeros(14,100,trials);
SOS_Cartilage = zeros(14,100,trials);
SOS_Muscle = zeros(14,100,trials);
SOS_Graymatter = zeros(14,100,trials);
SOS_Fat = zeros(14,100,trials);
SOS_Whitematter = zeros(15,100,trials);
SOS_Synovial = zeros(15,100,trials);

for n = 1:trials
    
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 128, 128) + 1i * normrnd(0, stdev_noise, 128, 128);
    I4_noise = I4 + noise;
    
    SOS_Blood(:,:,n) = sqrt(abs(I1_noise(15:28,15:114)).^2 + abs(I2_noise(15:28,15:114)).^2 ...
        + abs(I3_noise(15:28,15:114)).^2 + abs(I4_noise(15:28,15:114)).^2);
    SOS_Cartilage(:,:,n) = sqrt(abs(I1_noise(29:42,15:114)).^2 + abs(I2_noise(29:42,15:114)).^2 ...
        + abs(I3_noise(29:42,15:114)).^2 + abs(I4_noise(29:42,15:114)).^2);
    SOS_Muscle(:,:,n) = sqrt(abs(I1_noise(43:56,15:114)).^2 + abs(I2_noise(43:56,15:114)).^2 ...
        + abs(I3_noise(43:56,15:114)).^2 + abs(I4_noise(43:56,15:114)).^2);
    SOS_Graymatter(:,:,n) = sqrt(abs(I1_noise(57:70,15:114)).^2 + abs(I2_noise(57:70,15:114)).^2 ...
        + abs(I3_noise(57:70,15:114)).^2 + abs(I4_noise(57:70,15:114)).^2);
    SOS_Fat(:,:,n) = sqrt(abs(I1_noise(71:84,15:114)).^2 + abs(I2_noise(71:84,15:114)).^2 ...
        + abs(I3_noise(71:84,15:114)).^2 + abs(I4_noise(71:84,15:114)).^2);
    SOS_Whitematter(:,:,n) = sqrt(abs(I1_noise(85:99,15:114)).^2 + abs(I2_noise(85:99,15:114)).^2 ...
        + abs(I3_noise(85:99,15:114)).^2 + abs(I4_noise(85:99,15:114)).^2);
    SOS_Synovial(:,:,n) = sqrt(abs(I1_noise(100:114,15:114)).^2 + abs(I2_noise(100:114,15:114)).^2 ...
        + abs(I3_noise(100:114,15:114)).^2 + abs(I4_noise(100:114,15:114)).^2);
    
end

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
    
    data_SOS_Blood = SOS_Blood(:,col,:);
    data_SOS_Blood = data_SOS_Blood(:);
    data_SOS_Cartilage = SOS_Cartilage(:,col,:);
    data_SOS_Cartilage = data_SOS_Cartilage(:);
    data_SOS_Muscle = SOS_Muscle(:,col,:);
    data_SOS_Muscle = data_SOS_Muscle(:);
    data_SOS_Graymatter = SOS_Graymatter(:,col,:);
    data_SOS_Graymatter = data_SOS_Graymatter(:);
    data_SOS_Fat = SOS_Fat(:,col,:);
    data_SOS_Fat = data_SOS_Fat(:);
    data_SOS_Whitematter = SOS_Whitematter(:,col,:);
    data_SOS_Whitematter = data_SOS_Whitematter(:);
    data_SOS_Synovial = SOS_Synovial(:,col,:);
    data_SOS_Synovial = data_SOS_Synovial(:);
    
    avg_Blood(col) = mean(data_SOS_Blood);
    avg_Cartilage(col) = mean(data_SOS_Cartilage);
    avg_Muscle(col) = mean(data_SOS_Muscle);
    avg_Graymatter(col) = mean(data_SOS_Graymatter);
    avg_Fat(col) = mean(data_SOS_Fat);
    avg_Whitematter(col) = mean(data_SOS_Whitematter);
    avg_Synovial(col) = mean(data_SOS_Synovial);
    
    stdev_Blood(col) = std(data_SOS_Blood);
    stdev_Cartilage(col) = std(data_SOS_Cartilage);
    stdev_Muscle(col) = std(data_SOS_Muscle);
    stdev_Graymatter(col) = std(data_SOS_Graymatter);
    stdev_Fat(col) = std(data_SOS_Fat);
    stdev_Whitematter(col) = std(data_SOS_Whitematter);
    stdev_Synovial(col) = std(data_SOS_Synovial);
    
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

data_SOS_Blood = SOS_Blood(:,100,:);
data_SOS_Blood = data_SOS_Blood(:);
data_SOS_Cartilage = SOS_Cartilage(:,100,:);
data_SOS_Cartilage = data_SOS_Cartilage(:);
data_SOS_Muscle = SOS_Muscle(:,100,:);
data_SOS_Muscle = data_SOS_Muscle(:);
data_SOS_Graymatter = SOS_Graymatter(:,100,:);
data_SOS_Graymatter = data_SOS_Graymatter(:);
data_SOS_Fat = SOS_Fat(:,100,:);
data_SOS_Fat = data_SOS_Fat(:);
data_SOS_Whitematter = SOS_Whitematter(:,100,:);
data_SOS_Whitematter = data_SOS_Whitematter(:);
data_SOS_Synovial = SOS_Synovial(:,100,:);
data_SOS_Synovial = data_SOS_Synovial(:);

hist_SOS_Blood = hist(data_SOS_Blood, 20);
hist_SOS_Cartilage = hist(data_SOS_Cartilage, 20);
hist_SOS_Muscle = hist(data_SOS_Muscle, 20);
hist_SOS_Graymatter = hist(data_SOS_Graymatter, 20);
hist_SOS_Fat = hist(data_SOS_Fat, 20);
hist_SOS_Whitematter = hist(data_SOS_Whitematter, 20);
hist_SOS_Synovial = hist(data_SOS_Synovial, 20);

hist_SOS = zeros(7,20);
hist_SOS(1,:) = hist_SOS_Blood;
hist_SOS(2,:) = hist_SOS_Cartilage;
hist_SOS(3,:) = hist_SOS_Muscle;
hist_SOS(4,:) = hist_SOS_Graymatter;
hist_SOS(5,:) = hist_SOS_Fat;
hist_SOS(6,:) = hist_SOS_Whitematter;
hist_SOS(7,:) = hist_SOS_Synovial;
avg = [mean(avg_Blood) mean(avg_Cartilage) mean(avg_Muscle) mean(avg_Graymatter) ...
       mean(avg_Fat) mean(avg_Whitematter) mean(avg_Synovial)];

end