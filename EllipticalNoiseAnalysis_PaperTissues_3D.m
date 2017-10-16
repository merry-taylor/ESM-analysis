close all;
clear all;

%--------------------------------------------------------------------------
% In this script I will analyze the noise and banding statistics of the
% elliptical signal model compared to sum-of-squares and complex sum.  I
% will follow the steps that Professor Bangerter followed in his thesis.
%--------------------------------------------------------------------------

trials = 100000;

avgSNR = zeros(3,4);
contrast = zeros(3,6);
ripple = zeros(3,4);
histogram = zeros(3,4,20);
avg = zeros(3,4);

parpool('local', 4)

%% Center Pass Band SNR 15

disp('Starting SNR 15');
disp('----------------------------------------------------');

stdev_noise = 0.0232;

for alpha = 30:30:60
  
  disp(['Starting Alpha = ' num2str(alpha)]);
  disp('---------------------');
  for T1= 300:200:2300
      for T2= 30:20:230
        [I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_PaperTissues_3D(alpha,T1,T2);
  
         %% Simulate complex sum, sum-of-squares, and the elliptical signal model and collect the data
  
        disp('Starting Complex Sum Noise Analysis');
        [avgSNR(1,:), contrast(1,:), ripple(1,:), histogram(1,:,:), avg(1,:)] = CSNoise_AbstractTissues(I1, I2, I3, I4, trials, stdev_noise);
        disp('Starting Sum-of-Squares Noise Analysis');
        [avgSNR(2,:), contrast(2,:), ripple(2,:), histogram(2,:,:), avg(2,:)] = SOSNoise_AbstractTissues(I1, I2, I3, I4, trials, stdev_noise);
        disp('Starting Elliptical Signal Model Noise Analysis');
        [avgSNR(3,:), contrast(3,:), ripple(3,:), histogram(3,:,:), avg(3,:)] = ESMNoise_AbstractTissues(I1, I2, I3, I4, trials, stdev_noise);
        disp('Done!');
        disp(' ');
  
  
  
  save(['EllipticalNoiseAnalysis_FA' num2str(alpha) '_T1' num2str(T1) '_T2' num2str(T2) '.mat'],'avgSNR','contrast','ripple','histogram','avg','-v7.3');
      end 
  end
end

delete(gcp('nocreate'));


