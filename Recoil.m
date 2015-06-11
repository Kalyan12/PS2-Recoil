% Number of runs
clf;
Runs = 2;
runCount = 1;

while (runCount <= Runs)
   
    % Input data
    Shots = 30;
    xStart(1) = 0;
    yStart(1) = 0;
    
    vRecoilAmount = .31;
    hRecoilMin = .225;
    hRecoilMax = .3;
    Tol = .625;
    angleMin = -19; 
    angleMax = -17.5;
    FSM = 2;
    CoF(1) = .1;
    Bloom = .05;
    
    averageAngle = (angleMin+angleMax)/2;
    
    Distance = 10;
    smallestX = 0;
    largestX = 0;
    
    Count = 1;

    while (Count-1 < Shots)

        % CoF calculation and plotting
        hold on;
        Radius = Distance*tand(CoF(Count));
        [xCircle, yCircle] = circle(xStart(Count),yStart(Count),Radius);
        theta = rand*(2*pi);
        r = sqrt(rand)*Radius;
        xShot(Count) = xStart(Count) + r.*cos(theta);
        yShot(Count) = yStart(Count) + r.*sin(theta);
        
        % Plots CoF
        plot(xCircle, yCircle, 'k');

        % Plotting actual shot subject to CoF 
        plot(xShot(Count),yShot(Count),'+')

        % Calculating recoil angle
        recoilAngle = (angleMax-angleMin)*rand + angleMin;

        % Calculating vertical recoil amount and FSM
        if (Count == 1)
            xOne = (sind(recoilAngle)*vRecoilAmount*FSM)+xShot(Count);
            yOne = (cosd(recoilAngle)*vRecoilAmount*FSM)+yShot(Count);
        else
            xOne = (sind(recoilAngle)*vRecoilAmount)+xShot(Count);
            yOne = (cosd(recoilAngle)*vRecoilAmount)+yShot(Count);
        end
        
        % Plotting vertical recoil line
        plot([xShot(Count) xOne],[yShot(Count) yOne],'g')

        % Calling horizontal recoil function
        [xTwo,yTwo] = hRecoil(averageAngle, recoilAngle, hRecoilMax, hRecoilMin, xOne, yOne, Tol);

        % Plotting horizontal recoil line
        plot([xOne xTwo],[yOne yTwo],'b')

        % Plotting actual shots
        plot([xStart(Count) xTwo,],[yStart(Count) yTwo],'r')
        
        % Resetting firing location and adding bloom
        Count = Count + 1;
        xStart(Count)=xTwo;
        yStart(Count)=yTwo;
        CoF(Count) = CoF(Count-1) + Bloom;
        
        if (min(xShot) < smallestX)
            smallestX = min(xShot);
        end
        
        if (max(xShot) > largestX)
            largestX = max(xShot);
        end

    end
    
    % Calculats regression line
    mdl = fitlm(xShot,yShot);
    Coeff(1,runCount) = mdl.Coefficients.Estimate(2);
    Coeff(2,runCount) = mdl.Coefficients.Estimate(1);
    r2(runCount) = mdl.Rsquared.Ordinary(1);
    
    % Plots regression line
    plot([min(xShot),max(xShot)], Coeff(1,runCount)*[min(xShot),max(xShot)]+Coeff(2,runCount),'k')
        
    runCount = runCount + 1;
end


axis equal;

% Calculates average regression line
averageCoeff = mean(Coeff,2)
averageR2 = mean(r2)

% Plotting average reression line
plot([smallestX,largestX], averageCoeff(1)*[smallestX,largestX]+averageCoeff(2),'Color',[0, 1, .498039])

% Plotting head size
%[xCircle, yCircle] = circle(0,0,1);
%plot(xCircle, yCircle, 'b');

% Plotting tolerance
ax = get(gca, 'ylim');
plot([0 ax(2)/(tand(90-averageAngle))],[0 ax(2)],':c');
plot([Tol (ax(2)/(tand(90-averageAngle))+(Tol))],[0 ax(2)],':c');
plot([-Tol (ax(2)/(tand(90-averageAngle))-(Tol))],[0 ax(2)],':c');
plot([-Tol Tol],[0 0],':c');
