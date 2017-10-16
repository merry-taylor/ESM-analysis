function [I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_AbstractTissues(alpha)

%% Create the phantom
% I will create a 128 by 128 phantom with four tissues: cartilage, muscle,
% fat, and synovial fluid.  Each tissue will be 25 by 100.

% Initialize the needed matrices

T1 = zeros(128);
T2 = zeros(128);
offres = zeros(128);

% Cartilage
for row = 15:39
    for col = 15:114
        T1(row,col) = 1200;
        T2(row,col) = 30;
    end
end

% Muscle
for row = 40:64
    for col = 15:114
        T1(row,col) = 1500;
        T2(row,col) = 32;
    end
end

% Fat
for row = 65:89
    for col = 15:114
        T1(row,col) = 300;
        T2(row,col) = 85;
    end
end

% Synovial Fluid
for row = 90:114
    for col = 15:114
        T1(row,col) = 4800;
        T2(row,col) = 325;
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