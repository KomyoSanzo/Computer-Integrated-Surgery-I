function [ coefficients ] = CalculateCoefficients(u, p)

Fmatrix = zeros(0, 5);
Pcorrected = zeros(0, 3);

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

i = 1;
for n = 1:size(p, 2)
    for x = 1:size(p{n}, 1)
        Pcorrected(i, 1) = p{1, n}(x, 1);
        Pcorrected(i, 2) = p{1, n}(x, 2);
        Pcorrected(i, 3) = p{1, n}(x, 3);
        i = i + 1;
    end
end
coefficients = Fmatrix\Pcorrected;

disp(coefficients);