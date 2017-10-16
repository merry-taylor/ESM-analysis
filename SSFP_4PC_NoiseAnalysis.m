function [I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis(alpha)

%% Create the phantom
% I will use the same tissue parameters that Professor Bangerter used in
% his thesis.  He did not specify a size for the phantom, so I will make it
% 128 by 128 pixels; each tissue will be 33 pixels tall and 100 pixels
% wide.

% Initialize the needed matrices

T1 = zeros(128);
T2 = zeros(128);
offres = zeros(128);

% Tissue 1
for row = 15:47
    for col = 15:114
        T1(row,col) = 300;
        T2(row,col) = 150;
    end
end

% Tissue 2
for row = 48:80
    for col = 15:114
        T1(row,col) = 600;
        T2(row,col) = 300;
    end
end

% Tissue 3
for row = 81:113
    for col = 15:114
        T1(row,col) = 900;
        T2(row,col) = 450;
    end
end

% Off-resonance
for row = 15:114
    for col = 15:114
        offres(row,col) = (col - 15) * 2;
    end
end

%% Set up SSFP scan

% Scan parameters

TR = 10;
TE = 5;
alpha = alpha * pi / 180;

% Magnetization matrices for the x and y components of each pixel

Mx1 = zeros(128);
My1 = zeros(128);
Mx2 = zeros(128);
My2 = zeros(128);
Mx3 = zeros(128);
My3 = zeros(128);
Mx4 = zeros(128);
My4 = zeros(128);
dphi1 = 0;
dphi2 = pi / 2;
dphi3 = pi;
dphi4 = 3 * pi / 2;

% Simulate SSFP

parfor row = 15:114
    for col = 15:114
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