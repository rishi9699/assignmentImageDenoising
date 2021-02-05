curimg = imnoi;
alpha=0.2;
gamma=0.01;

for passes = 1:30
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
            %discon-adapt prior and should use circshift
            
%             objective_pixel = @(xi) (alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * (gamma * (abs(top-xi) + abs(bottom-xi) +abs(left-xi) + abs(right-xi)) - gamma^2 * log( (1+abs(top-xi)/gamma) * (1+abs(bottom-xi)/gamma) * (1+abs(left-xi)/gamma) * (1+abs(right-xi)/gamma) )));
%             curimg(i,j) = fminbnd(objective_pixel,0,1);
            
%             for iter=1:5000
%             xi = xi - st * (alpha*2*(xi-y) + (1-alpha)*gamma*( (xi-top)/(gamma+abs(xi-top)) + (xi-bottom)/(gamma+abs(xi-bottom)) + (xi-left)/(gamma+abs(xi-left)) + (xi-right)/(gamma+abs(xi-right)) ));
%             end
%             curimg(i,j) = xi;
            
            st=0.5;
            while st>=0.001                
                xi_new = xi - st * (alpha*2*(xi-y) + (1-alpha)*gamma*( (xi-top)/(gamma+abs(xi-top)) + (xi-bottom)/(gamma+abs(xi-bottom)) + (xi-left)/(gamma+abs(xi-left)) + (xi-right)/(gamma+abs(xi-right)) ));
                new_obj = alpha * (abs(y - xi_new))^2 + (1-alpha) * (gamma * (abs(top-xi_new) + abs(bottom-xi_new) +abs(left-xi_new) + abs(right-xi_new)) - gamma^2 * log( (1+abs(top-xi_new)/gamma) * (1+abs(bottom-xi_new)/gamma) * (1+abs(left-xi_new)/gamma) * (1+abs(right-xi_new)/gamma) ));
                old_obj = alpha * (abs(y - xi))^2 + (1-alpha) * (gamma * (abs(top-xi) + abs(bottom-xi) +abs(left-xi) + abs(right-xi)) - gamma^2 * log( (1+abs(top-xi)/gamma) * (1+abs(bottom-xi)/gamma) * (1+abs(left-xi)/gamma) * (1+abs(right-xi)/gamma) ));
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

