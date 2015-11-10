function [ Pcorrected ] = CorrectDistortion(u, c)
% CorrectDistortion uses the passed in Bernstein coefficients to corrected
% the distortion in a set of distorted points.

% Empty matrix for the F matrix
Fmatrix = zeros(0, 216);

% F matrix is calculated from distorted values
h = 1;
for n = 1:length(u)
    for x = 1:length(u{n})
        g = 1;
        for i = 0:5
            for j = 0:5
                for k = 0:5
                   vx = u{1, n}(x, 1);
                   vy = u{1, n}(x, 2);
                   vz = u{1, n}(x, 3);
                   Bx = nchoosek(5,i)*((1-vx)^(5-i))*(vx^i);
                   By = nchoosek(5,j)*((1-vy)^(5-j))*(vy^j);
                   Bz = nchoosek(5,k)*((1-vz)^(5-k))*(vz^k);
                   Fmatrix(h, g) = Bx*By*Bz;
                   g = g + 1;
                end
            end
        end
        h = h + 1;
    end
end

% F matrix is multiplied by the coefficients to get the corrected values
Pcorrected = Fmatrix*c;