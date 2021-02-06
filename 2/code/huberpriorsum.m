function huberpr = huberpriorsum(center, top, bottom, left, right, gamma)
huberpr=0;

if abs(center-top)<=gamma
    huberpr=huberpr+0.5*(abs(center-top))^2;
else
    huberpr = huberpr + gamma*abs(center-top) - gamma*gamma/2;
end

if abs(center-bottom)<=gamma
    huberpr=huberpr+0.5*(abs(center-bottom))^2;
else
    huberpr = huberpr + gamma*abs(center-bottom) - gamma*gamma/2;
end

if abs(center-left)<=gamma
    huberpr=huberpr+0.5*(abs(center-left))^2;
else
    huberpr = huberpr + gamma*abs(center-left) - gamma*gamma/2;
end

if abs(center-right)<=gamma
    huberpr=huberpr+0.5*(abs(center-right))^2;
else
    huberpr = huberpr + gamma*abs(center-right) - gamma*gamma/2;
end

end