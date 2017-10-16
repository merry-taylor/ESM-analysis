function [I1, I2, I3, I4] = SSFP_4PC_NoiseAnalysis_RealTissues(alpha)

%% Create the phantom
% I will make a phantom that is 128 by 128 pixels; the tissues will fill
% the middle 100 by 100 pixels.  I will create 7 real tissues in this
% phantom; each one will be 100 pixels wide and 14 or 15 pixels high.

% Initialize the needed matrices

T1 = zeros(128);
T2 = zeros(128);
offres = zeros(128);

% Blood
for row = 15:28
    for col = 15:114
        T1(row,col) = 1500;
        T2(row,col) = 200;
    end
end

% Cartilage
for row = 29:42
    for col = 15:114
        T1(row,col) = 1200;
        T2(row,col) = 30;
    end
end

% Muscle
for row = 43:56
    for col = 15:114
        T1(row,col) = 1500;
        T2(row,col) = 32;
    end
end

% Graymatter
for row = 57:70
    for col = 15:114
        T1(row,col) = 1800;
        T2(row,col) = 100;
    end
end

% Fat
for row = 71:84
    for col = 15:114
        T1(row,col) = 300;
        T2(row,col) = 85;
    end
end

% Whitematter
for row = 85:99
    for col = 15:114
        T1(row,col) = 1000;
        T2(row,col) = 70;
    end
end

% Synovial Fluid
for row = 100:114
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