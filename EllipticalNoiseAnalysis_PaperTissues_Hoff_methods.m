close all;
clear all;

%--------------------------------------------------------------------------
% In this script I will analyze the noise and banding statistics of the
% elliptical signal model compared to sum-of-squares and complex sum.  I
% will follow the steps that Professor Bangerter followed in his thesis.
%--------------------------------------------------------------------------

trials = 1000;

avgSNR = zeros(3,4);
contrast = zeros(3,6);
ripple = zeros(3,4);
histogram = zeros(3,4,20);
avg = zeros(3,4);

%parpool('local', 2)

%% Center Pass Band SNR 15

disp('Starting SNR 15');
disp('----------------------------------------------------');

stdev_noise = 0.0232;

for alpha = 10:10:90
  
  disp(['Starting Alpha = ' num2str(alpha)]);
  disp('---------------------');
  %for T1= 300:200:2300
  %    for T2= 30:20:230
        %[I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_PaperTissues_3D(alpha,T1,T2);
         [I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_AbstractTissues(alpha);

  
         %% Simulate GS, algebraic solution, and the GAS hybrid and collect the data
  
        disp('Starting Noise Analysis');
        [avgSNR, contrast, ripple, histogram, avg] = GASNoise_PaperTissues(I1, I2, I3, I4, trials, stdev_noise);
        %(1,:)-GS (2,:)-AS (3,:)-GAS
        disp('Done!');
        disp(' ');
  
    save(['GASNoiseAnalysis_FA' num2str(alpha)  '.mat'],'avgSNR','contrast','ripple','histogram','avg','-v7.3');

  
  %save(['GASNoiseAnalysis_FA' num2str(alpha) '_T1' num2str(T1) '_T2' num2str(T2) '.mat'],'avgSNR','contrast','ripple','histogram','avg','-v7.3');
 %     end 
 % end
end

delete(gcp('nocreate'));


