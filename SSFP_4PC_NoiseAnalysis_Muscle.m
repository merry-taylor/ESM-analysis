function [I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_Muscle(alpha)

%% Create the phantom
% I will create a 50 by 50 phantom with just one 40 by 40 block of muscle.

% Initialize the needed matrices

T1 = zeros(50);
T2 = zeros(50);
offres = zeros(50);

% Muscle
for row = 6:45
    for col = 6:45
        T1(row,col) = 1500;
        T2(row,col) = 32;
    end
end

% Off-resonance
for row = 6:45
    for col = 6:45
        offres(row,col) = (col - 6) * 2;
    end
end

%% Set up SSFP scan

% Scan parameters

TR = 10;
TE = 5;
alpha = alpha * pi / 180;

% Magnetization matrices for the x and y components of each pixel

Mx1 = zeros(50);
My1 = zeros(50);
Mx2 = zeros(50);
My2 = zeros(50);
Mx3 = zeros(50);
My3 = zeros(50);
Mx4 = zeros(50);
My4 = zeros(50);
dphi1 = 0;
dphi2 = pi / 2;
dphi3 = pi;
dphi4 = 3 * pi / 2;

% Simulate SSFP

for row = 6:45
    for col = 6:45
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