function [ output_args ] = BashPercentRipple( filename)
%BASHPERCENTRIPPLE This function takes in alpha, T1, and T2 to run the
%simulation from the command line
fid=fopen(filename, 'r');
[params, count]=fscanf(fid, '%f');
fclose(fid);
alpha=params(1);
T1=params(2);
T2=params(3);

trials = 100000;

avgSNR = zeros(3,4);
contrast = zeros(3,6);
ripple = zeros(3,4);
histogram = zeros(3,4,20);
avg = zeros(3,4);

stdev_noise = 0.0232;

[I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_PaperTissues_3D(alpha,T1,T2);
  
%% Simulate complex sum, sum-of-squares, and the elliptical signal model and collect the data

%[avgSNR(1,:), contrast(1,:), ripple(1,:), histogram(1,:,:), avg(1,:)] = CSNoise_AbstractTissues(I1, I2, I3, I4, trials, stdev_noise);

%[avgSNR(2,:), contrast(2,:), ripple(2,:), histogram(2,:,:), avg(2,:)] = SOSNoise_AbstractTissues(I1, I2, I3, I4, trials, stdev_noise);

%[avgSNR(3,:), contrast(3,:), ripple(3,:), histogram(3,:,:), avg(3,:)] = ESMNoise_AbstractTissues(I1, I2, I3, I4, trials, stdev_noise);
[avgSNR2, contrast2, ripple2, histogram2, avg2] = GASNoise_PaperTissues(I1, I2, I3, I4, trials, stdev_noise);
save(['GASNoiseAnalysis_FA' num2str(alpha) num2str(alpha) '_T1' num2str(T1) '_T2' num2str(T2) '.mat'],'avgSNR2','contrast2','ripple2','histogram2','avg2','-v7.3');
%save(['ALLEllipticalNoiseAnalysis_FA' num2str(alpha) '_T1' num2str(T1) '_T2' num2str(T2) '.mat'],'avgSNR','contrast','ripple','histogram','avg','-v7.3');

output_args='DONE!';
end

