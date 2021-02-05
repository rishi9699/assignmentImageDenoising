curimg = imnoi;
alpha=0.5;

for passes = 1:5
    disp("pass number"+passes);
    for i=2:255
        for j=2:255
            xi = curimg(i,j);
            top = curimg(i-1,j);
            bottom = curimg(i+1,j);
            left = curimg(i,j-1);
            right = curimg(i,j+1);
            y=imnoi(i,j);


            %minimizing for each pixel..
            %quadratic prior and should use circshift
            %((xi-curimg(i-1,j))^2 + (xi-curimg(i+1,j))^2 + (xi-curimg(i,j-1))^2 + (xi-curimg(i,j+1))^2)
            %disp("current posterior "+ (alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * ((xi-curimg(i-1,j))^2 + (xi-curimg(i+1,j))^2 + (xi-curimg(i,j-1))^2 + (xi-curimg(i,j+1))^2)));
            
            %%objective_pixel = @(xi) (alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * ((xi-curimg(i-1,j))^2 + (xi-curimg(i+1,j))^2 + (xi-curimg(i,j-1))^2 + (xi-curimg(i,j+1))^2)) ;
            %%curimg(i,j) = fminbnd(objective_pixel,0,1);
            
            %disp("optimizied posterior "+ (alpha * (abs(imnoi(i,j) - curimg(i,j)))^2 + (1-alpha) * ((curimg(i,j)-curimg(i-1,j))^2 + (curimg(i,j)-curimg(i+1,j))^2 + (curimg(i,j)-curimg(i,j-1))^2 + (curimg(i,j)-curimg(i,j+1))^2)));
            
            %use very small step size
            %st=0.01
%             for iter=1:400
%             xi = xi - st * (alpha*2*(xi-imnoi(i,j)) + (1-alpha)*2*(4*xi -top-bottom-left-right) );
%             disp(xi)
%             end
            %curimg(i,j) = xi;
            
            st=0.1;
            while st>=0.001                
                xi_new = xi - st * (alpha*2*(xi-y) + (1-alpha)*2*(4*xi -top-bottom-left-right) );
                new_obj = alpha * (abs(y - xi_new))^2 + (1-alpha) * ((xi_new-top)^2 + (xi_new-bottom)^2 + (xi_new-left)^2 + (xi_new-right)^2);
                old_obj = alpha * (abs(y - xi))^2 + (1-alpha) * ((xi-top)^2 + (xi-bottom)^2 + (xi-left)^2 + (xi-right)^2);
                if new_obj<old_obj
                    xi = xi_new;
                    st=1.1*st;
                else
                    st=st*0.5;
                end
            end
            curimg(i,j) = xi;
            
        end
    end
end
