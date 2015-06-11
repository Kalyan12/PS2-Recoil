function [xFinal, yFinal] = hRecoil(averageAngle, recoilAngle, Max, Min, xOne, yOne, Tolerance)

    % Chooses direction: Left = -1 Right = 1
    if (randi(2) == 1)
        Direction = 1;
    else
        Direction = -1;
    end
    
    % Calculating horizontal shake
    recoilAmount = (Max - Min) * rand + Min;

    % Making sure that recoil goes the correct direction
    if (recoilAngle >= 0 && Direction == 1)
        xFinal = xOne + cosd(recoilAngle) * recoilAmount;
        yFinal = yOne - sind(recoilAngle) * recoilAmount;
    elseif (recoilAngle >= 0 && Direction == -1)
        xFinal = xOne - cosd(recoilAngle) * recoilAmount;
        yFinal = yOne + sind(recoilAngle) * recoilAmount;
    elseif (recoilAngle <0 && Direction == 1)
        xFinal = xOne + cosd(-recoilAngle) * recoilAmount;
        yFinal = yOne + sind(-recoilAngle) * recoilAmount;
    else
        xFinal = xOne - cosd(-recoilAngle) * recoilAmount;
        yFinal = yOne - sind(-recoilAngle) * recoilAmount;
    end
   
    % Changes direction of recoil if larger than tolerance
    xMax = (yFinal/tand(90-averageAngle)) + (Tolerance);
    xMin = (yFinal/tand(90-averageAngle)) - (Tolerance);
    
    
    if (xFinal > xMax)
        if (recoilAngle >= 0)
            xFinal = xOne - cosd(recoilAngle) * recoilAmount;
            yFinal = yOne + sind(recoilAngle) * recoilAmount;
        elseif (recoilAngle <0)
            xFinal = xOne - cosd(-recoilAngle) * recoilAmount;
            yFinal = yOne - sind(-recoilAngle) * recoilAmount;
        end
    end
    if (xFinal < xMin)
        if (recoilAngle >= 0)
            xFinal = xOne + cosd(recoilAngle) * recoilAmount;
            yFinal = yOne - sind(recoilAngle) * recoilAmount;
        elseif (recoilAngle <0)
            xFinal = xOne + cosd(-recoilAngle) * recoilAmount;
            yFinal = yOne + sind(-recoilAngle) * recoilAmount;
        end
    end
    
    % Plots recoiled shot location
     plot(xFinal, yFinal, '*');
