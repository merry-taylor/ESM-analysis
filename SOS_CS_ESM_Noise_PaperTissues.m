function [avgSNRans, contrastans, rippleans, hist_ans, avgans] = SOS_CS_ESM_Noise_PaperTissues(I1, I2, I3, I4, trials, stdev_noise)

SOS = zeros(32,128,trials);
CS = zeros(32,128,trials);
ESM = zeros(32,128,trials);


for n = 1:trials
    
    if mod(n,1000) == 0
        disp(['      Trial #' num2str(n)]);
    end
    
    noise = normrnd(0, stdev_noise, 32, 128) + 1i * normrnd(0, stdev_noise, 32, 128);
    I1_noise = I1 + noise;
    noise = normrnd(0, stdev_noise, 32, 128) + 1i * normrnd(0, stdev_noise, 32, 128);
    I2_noise = I2 + noise;
    noise = normrnd(0, stdev_noise, 32, 128) + 1i * normrnd(0, stdev_noise, 32, 128);
    I3_noise = I3 + noise;
    noise = normrnd(0, stdev_noise, 32, 128) + 1i * normrnd(0, stdev_noise, 32, 128);
    I4_noise = I4 + noise;
    
    ESM(:,:,n) = abs(EllipticalModel(I1_noise, I2_noise, I3_noise, I4_noise));
    GSmaster=zeros(32,128,1);
    GSmaster(:,:,1)=ESM(:,:,n);
    [GSmaster,GSmap]= (geo_MT(compdata));
    [ASmaster,ASmap]=(alg_MT(compdata));
    [GASsoln, varmap,w]=(GAScombo_MT(GSmaster,ASmaster,2,9)); %last two numbers from GAS.m
    
end

ESM = GS(4:28,15:114,:);
AS = AS(4:28,15:114,:);
GAS = GAS(4:28,15:114,:);

avg1 = zeros(100,1);
avg1AS = zeros(100,1);
avg1GAS = zeros(100,1);
stdev1 = zeros(100,1);
stdev1AS = zeros(100,1);
stdev1GAS = zeros(100,1);


for col = 1:100
    
    data_ESM1 = ESM(1:25,col,:);
    data_ESM1 = data_ESM1(:);
    
    avg1(col) = mean(data_ESM1);
    
    stdev1(col) = std(data_ESM1);
    
    data_AS1 = AS(1:25,col,:);
    data_AS1 = data_AS1(:);
    
    avg1AS(col) = mean(data_AS1);
    
    stdev1AS(col) = std(data_AS1);
    
    data_GAS1 = GAS(1:25,col,:);
    data_GAS1 = data_GAS1(:);
    
    avg1GAS(col) = mean(data_GAS1);
    
    stdev1GAS(col) = std(data_GAS1);
    
end

avgSNR = mean(avg1 ./ stdev1);

avgSNRAS = mean(avg1AS ./ stdev1AS);

avgSNRGAS = mean(avg1GAS ./ stdev1GAS);

avgSNRans=zeros(1,3);
avgSNRans(:,1)=avgSNR;
avgSNRans(:,2)=avgSNRAS;
avgSNRans(:,3)=avgSNRGAS;

contrast = zeros(1,6);
% contrast(1) = 2 * (mean(avg1) - mean(avg2)) / (mean(avg1) + mean(avg2));
% contrast(2) = 2 * (mean(avg1) - mean(avg3)) / (mean(avg1) + mean(avg3));
% contrast(3) = 2 * (mean(avg1) - mean(avg4)) / (mean(avg1) + mean(avg4));
% contrast(4) = 2 * (mean(avg2) - mean(avg3)) / (mean(avg2) + mean(avg3));
% contrast(5) = 2 * (mean(avg2) - mean(avg4)) / (mean(avg2) + mean(avg4));
% contrast(6) = 2 * (mean(avg3) - mean(avg4)) / (mean(avg3) + mean(avg4));

contrastAS = zeros(1,6);
% contrastAS(1) = 2 * (mean(avg1AS) - mean(avg2AS)) / (mean(avg1AS) + mean(avg2AS));
% contrastAS(2) = 2 * (mean(avg1AS) - mean(avg3AS)) / (mean(avg1AS) + mean(avg3AS));
% contrastAS(3) = 2 * (mean(avg1AS) - mean(avg4AS)) / (mean(avg1AS) + mean(avg4AS));
% contrastAS(4) = 2 * (mean(avg2AS) - mean(avg3AS)) / (mean(avg2AS) + mean(avg3AS));
% contrastAS(5) = 2 * (mean(avg2AS) - mean(avg4AS)) / (mean(avg2AS) + mean(avg4AS));
% contrastAS(6) = 2 * (mean(avg3AS) - mean(avg4AS)) / (mean(avg3AS) + mean(avg4AS));

contrastGAS = zeros(1,6);
% contrastGAS(1) = 2 * (mean(avg1GAS) - mean(avg2GAS)) / (mean(avg1GAS) + mean(avg2GAS));
% contrastGAS(2) = 2 * (mean(avg1GAS) - mean(avg3GAS)) / (mean(avg1GAS) + mean(avg3GAS));
% contrastGAS(3) = 2 * (mean(avg1GAS) - mean(avg4GAS)) / (mean(avg1GAS) + mean(avg4GAS));
% contrastGAS(4) = 2 * (mean(avg2GAS) - mean(avg3GAS)) / (mean(avg2GAS) + mean(avg3GAS));
% contrastGAS(5) = 2 * (mean(avg2GAS) - mean(avg4GAS)) / (mean(avg2GAS) + mean(avg4GAS));
% contrastGAS(6) = 2 * (mean(avg3GAS) - mean(avg4GAS)) / (mean(avg3GAS) + mean(avg4GAS));

contrastans=zeros(1,6,3);
contrastans(:,:,1)=contrast;
contrastans(:,:,2)=contrastAS;
contrastans(:,:,3)=contrastGAS;

ripple = 100 * (max(avg1) - min(avg1)) / mean(avg1);

rippleAS = 100 * (max(avg1AS) - min(avg1AS)) / mean(avg1AS);

rippleGAS = 100 * (max(avg1GAS) - min(avg1GAS)) / mean(avg1GAS);

rippleans=zeros(1,3);
rippleans(:,1)=ripple;
rippleans(:,2)=rippleAS;
rippleans(:,3)=rippleGAS;

data_ESM1 = ESM(1:25,100,:);
data_ESM1 = data_ESM1(:);
hist_ESM1 = hist(data_ESM1, 20);

data_AS1 = AS(1:25,100,:);
data_AS1 = data_AS1(:);

hist_AS1 = hist(data_AS1, 20);

data_GAS1 = GAS(1:25,100,:);
data_GAS1 = data_GAS1(:);
hist_GAS1 = hist(data_GAS1, 20);

hist_ESM = zeros(1,20);
hist_ESM(1,:) = hist_ESM1;

avg = mean(avg1);

hist_AS = zeros(1,20);
hist_AS(1,:) = hist_AS1;
avgas = mean(avg1AS);

hist_GAS = zeros(1,20);
hist_GAS(1,:) = hist_GAS1;
avggas = mean(avg1GAS);

hist_ans=zeros(20,3);
hist_ans(:,1)=hist_ESM;
hist_ans(:,2)=hist_AS;
hist_ans(:,3)=hist_GAS;

avgans=zeros(1,3);
avgans(:,1)=avg;
avgans(:,2)=avgas;
avgans(:,3)=avggas;



end