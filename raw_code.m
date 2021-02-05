curimg = imnoi;
alpha=0.5;

for passes = 1:3
    disp("pass number"+passes);
    for i=2:255
        for j=2:255
            xi = curimg(i,j);


            %minimizing for each pixel..
            %quadratic prior and should use circshift
            %((xi-curimg(i-1,j))^2 + (xi-curimg(i+1,j))^2 + (xi-curimg(i,j-1))^2 + (xi-curimg(i,j+1))^2)
            %disp("current posterior "+ (alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * ((xi-curimg(i-1,j))^2 + (xi-curimg(i+1,j))^2 + (xi-curimg(i,j-1))^2 + (xi-curimg(i,j+1))^2)));
            objective_pixel = @(xi) (alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * ((xi-curimg(i-1,j))^2 + (xi-curimg(i+1,j))^2 + (xi-curimg(i,j-1))^2 + (xi-curimg(i,j+1))^2)) ;
            curimg(i,j) = fminbnd(objective_pixel,0,1);
            %disp("optimizied posterior "+ (alpha * (abs(imnoi(i,j) - curimg(i,j)))^2 + (1-alpha) * ((curimg(i,j)-curimg(i-1,j))^2 + (curimg(i,j)-curimg(i+1,j))^2 + (curimg(i,j)-curimg(i,j-1))^2 + (curimg(i,j)-curimg(i,j+1))^2)));

        end
    end
end
disp(myfun())
