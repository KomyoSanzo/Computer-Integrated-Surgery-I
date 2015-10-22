function [ Pcorrected ] = CorrectDistortion(u, c)

Fmatrix = zeros(0, 216);

h = 1;
for n = 1:size(u, 2)
    for x = 1:size(u{n}, 1)
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

Pcorrected = Fmatrix*c;