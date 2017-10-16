close all;
clear all;

%--------------------------------------------------------------------------
% In this script I will analyze the noise and banding statistics of the
% elliptical signal model compared to sum-of-squares and complex sum.  I
% will follow the steps that Professor Bangerter followed in his thesis.
%--------------------------------------------------------------------------

trials = 100000;

avgSNR = zeros(3,7);
contrast = zeros(3,21);
ripple = zeros(3,7);
histogram = zeros(3,7,20);
avg = zeros(3,7);

matlabpool open

%% Center Pass Band SNR 15

disp('Starting SNR 15');
disp('----------------------------------------------------');

stdev_noise = 0.0232;

for alpha = 10:10:90
  
  disp(['Starting Alpha = ' num2str(alpha)]);
  disp('---------------------');
  
  [I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_RealTissues(alpha);
  
  %% Simulate complex sum, sum-of-squares, and the elliptical signal model and collect the data

  disp('Starting Complex Sum Noise Analysis');
  [avgSNR(1,:), contrast(1,:), ripple(1,:), histogram(1,:,:), avg(1,:)] = CSNoise_RealTissues(I1, I2, I3, I4, trials, stdev_noise);
  disp('Starting Sum-of-Squares Noise Analysis');
  [avgSNR(2,:), contrast(2,:), ripple(2,:), histogram(2,:,:), avg(2,:)] = SOSNoise_RealTissues(I1, I2, I3, I4, trials, stdev_noise);
  disp('Starting Elliptical Signal Model Noise Analysis');
  [avgSNR(3,:), contrast(3,:), ripple(3,:), histogram(3,:,:), avg(3,:)] = ESMNoise_RealTissues(I1, I2, I3, I4, trials, stdev_noise);
  disp('Done!');
  disp(' ');
  
  
  
  save(['EllipticalNoiseAnalysis_RealTissues_FA' num2str(alpha) '.mat'],'avgSNR','contrast','ripple','histogram','avg','-v7.3');
  
end

matlabpool close

