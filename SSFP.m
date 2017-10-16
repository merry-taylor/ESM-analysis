% This function will use the steady state signal given in the paper by
% Xiang, Qing-San and Hoff, Michael N. "Banding Artifact Removal for bSSFP
% Imaging with an Elliptical Signal Model", 2014, to simulate SSFP.

function [Mx, My] = SSFP(T1, T2, TR, TE, alpha, dphi, offres)

M0 = 1;
E1 = exp(-TR/T1);
E2 = exp(-TR/T2);
M = M0 * (1 - E1) * sin(alpha) / (1 - E1 * cos(alpha) - E2^2 * (E1 - cos(alpha))); % Equation (3)
a = E2; % Equation (4)
b = E2 * (1 - E1) * (1 + cos(alpha)) / (1 - E1 * cos(alpha) - E2^2 * (E1 - cos(alpha))); % Equation (5)
theta = 2 * pi * offres * TR / 1000 - dphi;
I = M * (1 - a * exp(j * theta)) / (1 - b * cos(theta)); % Equation (6)
Mx = real(I) * exp(-TE/T2); % T2 decay
My = imag(I) * exp(-TE/T2); % T2 decay
MxTemp = Mx;
theta = theta + dphi;
Mx = Mx * cos(theta*TE/TR) + My * sin(theta*TE/TR); % Off resonance precession
My = MxTemp * -sin(theta*TE/TR) + My * cos(theta*TE/TR); % Off resonance precession

end