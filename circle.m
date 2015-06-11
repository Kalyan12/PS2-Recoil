function [xUnit, yUnit] = circle(x,y,r)
    % plot(x,y,'x')
    hold on
    th = 0:pi/50:2*pi;
    xUnit = r * cos(th) + x;
    yUnit = r * sin(th) + y;
   % plot(xUnit, yUnit, 'k');
