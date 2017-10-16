function [I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_PaperTissues_3D(alpha, T1_val, T2_val)

%% Create the phantom
% I will make a phantom that is 32 by 128 pixels; the tissues will fill
% the middle 100 by 100 pixels.  I will create 7 real tissues in this
% phantom; each one will be 100 pixels wide and 14 or 15 pixels high.

% Initialize the needed matrices

T1 = zeros(128,32)';
T2 = zeros(128,32)';
offres = zeros(128,32)';



%% Set up SSFP scan

% Scan parameters

TR = 10;
TE = 5;
alpha = alpha * pi / 180;

% Magnetization matrices for the x and y components of each pixel

Mx1 = zeros(128,32)';
My1 = zeros(128,32)';
Mx2 = zeros(128,32)';
My2 = zeros(128,32)';
Mx3 = zeros(128,32)';
My3 = zeros(128,32)';
Mx4 = zeros(128,32)';
My4 = zeros(128,32)';
dphi1 = 0;
dphi2 = pi / 2;
dphi3 = pi;
dphi4 = 3 * pi / 2;

% Simulate SSFP

for row = 4:28
    for col = 15:114
        T1(row,col) = T1_val;
        T2(row,col) = T2_val;
        offres(row,col) = (col - 15) * 2;
        [Mx1(row,col), My1(row,col)] = SSFP(T1(row,col), T2(row,col), TR, TE, alpha, dphi1, offres(row,col));
        [Mx2(row,col), My2(row,col)] = SSFP(T1(row,col), T2(row,col), TR, TE, alpha, dphi2, offres(row,col));
        [Mx3(row,col), My3(row,col)] = SSFP(T1(row,col), T2(row,col), TR, TE, alpha, dphi3, offres(row,col));
        [Mx4(row,col), My4(row,col)] = SSFP(T1(row,col), T2(row,col), TR, TE, alpha, dphi4, offres(row,col));
    end
end

% Create the complex images from Mx and My

I1 = Mx1 + 1i * My1;
I2 = Mx2 + 1i * My2;
I3 = Mx3 + 1i * My3;
I4 = Mx4 + 1i * My4;

end