function [ output_args ] = BashSNR(filename)
%BASHPERCENTRIPPLE This function takes in alpha, T1, and T2 to run the
%simulation from the command line

fid=fopen(filename, 'r');
[params, count]=fscanf(fid, '%f');
fclose(fid);
alpha=params(1);
T1=params(2);
T2=params(3);

trials = 100000;

% avgSNR2 = zeros(3,4);
% contrast2 = zeros(3,6);
% ripple2 = zeros(3,4);
% histogram2 = zeros(3,4,20);
% avg2 = zeros(3,4);

stdev_noise = 0.0232;

[I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_PaperTissues_3D(alpha,T1,T2);
  
%% Simulate complex sum, sum-of-squares, and the elliptical signal model and collect the data
[avgSNR2, contrast2, ripple2, histogram2, avg2] = GASNoise_PaperTissues(I1, I2, I3, I4, trials, stdev_noise);
save(['GASNoiseAnalysis_FA' num2str(alpha) 'T1_' num2str(T1) 'T2_' num2str(T2) '.mat'],'avgSNR2','contrast2','ripple2','histogram2','avg2','-v7.3');

output_args='DONE!';


end

