curimg = imnoi;
alpha=0.2;
gamma=0.01;

for passes = 1:10
    disp("pass number"+passes);
    for i=2:255
        for j=2:255
            xi = curimg(i,j);
            top = curimg(i-1,j);
            bottom = curimg(i+1,j);
            left = curimg(i,j-1);
            right = curimg(i,j+1);


            %minimizing for each pixel..
            %discon-adapt prior and should use circshift
            
            objective_pixel = @(xi) (alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * (gamma * (abs(top-xi) + abs(bottom-xi) +abs(left-xi) + abs(right-xi)) - gamma^2 * log( (1+abs(top-xi)/gamma) * (1+abs(bottom-xi)/gamma) * (1+abs(left-xi)/gamma) * (1+abs(right-xi)/gamma) )));
            curimg(i,j) = fminbnd(objective_pixel,0,1);
            

        end
    end
end

st=4;
for iter=1:5000
xi = xi - st * (alpha*2*(xi-imnoi(i,j)) + (1-alpha)*gamma*( (xi-top)/(gamma+abs(xi-top)) + (xi-bottom)/(gamma+abs(xi-bottom)) + (xi-left)/(gamma+abs(xi-left)) + (xi-right)/(gamma+abs(xi-right)) ));
%disp(xi)
end