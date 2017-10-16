close all;
clear all;

%--------------------------------------------------------------------------
% In this script I will analyze the noise and banding statistics of the
% elliptical signal model compared to sum-of-squares and complex sum.  I
% will follow the steps that Professor Bangerter followed in his thesis.
%--------------------------------------------------------------------------

trials = 1000000;

avgSNR = zeros(3,1);
ripple = zeros(3,1);
histogram = zeros(3,1,20);
avg = zeros(3,1);

matlabpool local 8

for alpha = [30 60]
    
    disp(['Starting Alpha = ' num2str(alpha)]);
    disp('----------------------------------------------------');
    
    SNR = 0;
    
    for stdev_noise = [0.0715 0.0348 0.0232 0.01734 0.01387 0.01153]
        
        SNR = SNR + 5;
        
        disp(['Starting SNR ' num2str(SNR)]);
        disp('---------------------');
        
        [I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_Muscle(alpha);
        
        %% Simulate complex sum, sum-of-squares, and the elliptical signal model and collect the data
        
        disp('Starting Complex Sum Noise Analysis');
        [avgSNR(1), ripple(1), histogram(1,1,:), avg(1)] = CSNoise_Muscle(I1, I2, I3, I4, trials, stdev_noise);
        disp('Starting Sum-of-Squares Noise Analysis');
        [avgSNR(2), ripple(2), histogram(2,1,:), avg(2)] = SOSNoise_Muscle(I1, I2, I3, I4, trials, stdev_noise);
        disp('Starting Elliptical Signal Model Noise Analysis');
        [avgSNR(3), ripple(3), histogram(3,1,:), avg(3)] = ESMNoise_Muscle(I1, I2, I3, I4, trials, stdev_noise);
        disp('Done!');
        disp(' ');
        
        
        
        save(['EllipticalNoiseAnalysis_Muscle_FA' num2str(alpha) '_Noise' num2str(SNR) '.mat'],'avgSNR','ripple','histogram','avg','-v7.3');
        
    end
    
end

matlabpool close

