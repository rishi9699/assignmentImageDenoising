curimg = imnoi;
alpha=0.5;

for passes = 1:3
    disp("pass number"+passes);
    for i=2:255
        for j=2:255
            xi = curimg(i,j);


            %minimizing for each pixel..
            %quadratic prior and should use circshift
            %disp("current posterior "+ (alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * huberpriorsum(xi,curimg(i-1,j),curimg(i+1,j),curimg(i,j-1),curimg(i,j+1))));
            objective_pixel = @(xi) (alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * huberpriorsum(xi,curimg(i-1,j),curimg(i+1,j),curimg(i,j-1),curimg(i,j+1))) ;
            curimg(i,j) = fminbnd(objective_pixel,0,1);
            %disp("optimizied posterior "+ (alpha * (abs(imnoi(i,j) - curimg(i,j)))^2 + (1-alpha) * huberpriorsum(curimg(i,j),curimg(i-1,j),curimg(i+1,j),curimg(i,j-1),curimg(i,j+1))));

        end
    end
end
disp(myfun())
