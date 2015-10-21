function [ Pcorrected ] = CorrectDistortion(u, c)

Fmatrix = zeros(0, 5);

i = 1;
for n = 1:size(u, 2)
    for x = 1:size(u{n}, 1)
        for k = 1:5
           vx = u{1, n}(x, 1);
           vy = u{1, n}(x, 2);
           vz = u{1, n}(x, 3);
           Bx = nchoosek(5,k)*((1-vx)^(5-k))*(vx^k);
           By = nchoosek(5,k)*((1-vy)^(5-k))*(vy^k);
           Bz = nchoosek(5,k)*((1-vz)^(5-k))*(vz^k);
           Fmatrix(i, k) = Bx*By*Bz;
        end
        i = i + 1;
    end
end

Pcorrected = Fmatrix*c;