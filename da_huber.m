curimg = imnoi;
alpha=0.2;

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
            %quadratic prior and should use circshift
            %disp("current posterior "+ (alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * huberpriorsum(xi,curimg(i-1,j),curimg(i+1,j),curimg(i,j-1),curimg(i,j+1))));
            %%%objective_pixel = @(xi) (alpha * (abs(y - xi))^2 + (1-alpha) * huberpriorsum(xi,top,bottom,left,right)) ;
            %%%curimg(i,j) = fminbnd(objective_pixel,0,1);
            
            %Using gradient descent
            
%             for iter=1:1000
%                 gradient_sum=0;
%                 if abs(xi-top)<=gamma
%                     gradient_sum = gradient_sum+xi-top;
%                 else
%                     gradient_sum = gradient_sum+gamma*sign(xi-top);
%                 end
% 
%                 if abs(xi-bottom)<=gamma
%                     gradient_sum = gradient_sum+xi-bottom;
%                 else
%                     gradient_sum = gradient_sum+gamma*sign(xi-bottom);
%                 end
% 
%                 if abs(xi-left)<=gamma
%                     gradient_sum = gradient_sum+xi-left;
%                 else
%                     gradient_sum = gradient_sum+gamma*sign(xi-left);
%                 end
% 
%                 if abs(xi-right)<=gamma
%                     gradient_sum = gradient_sum+xi-right;
%                 else
%                     gradient_sum = gradient_sum+gamma*sign(xi-right);
%                 end
% 
%                 xi = xi - st * (alpha*2*(xi-y) + (1-alpha)*gradient_sum);
%             end

%             
            %disp("optimizied posterior "+ (alpha * (abs(imnoi(i,j) - curimg(i,j)))^2 + (1-alpha) * huberpriorsum(curimg(i,j),curimg(i-1,j),curimg(i+1,j),curimg(i,j-1),curimg(i,j+1))));
            
            st=0.5;
            while st>=0.001                
                
                gradient_sum=0;
                if abs(xi-top)<=gamma
                    gradient_sum = gradient_sum+xi-top;
                else
                    gradient_sum = gradient_sum+gamma*sign(xi-top);
                end

                if abs(xi-bottom)<=gamma
                    gradient_sum = gradient_sum+xi-bottom;
                else
                    gradient_sum = gradient_sum+gamma*sign(xi-bottom);
                end

                if abs(xi-left)<=gamma
                    gradient_sum = gradient_sum+xi-left;
                else
                    gradient_sum = gradient_sum+gamma*sign(xi-left);
                end

                if abs(xi-right)<=gamma
                    gradient_sum = gradient_sum+xi-right;
                else
                    gradient_sum = gradient_sum+gamma*sign(xi-right);
                end

                xi_new = xi - st * (alpha*2*(xi-y) + (1-alpha)*gradient_sum);
                
                new_obj = (alpha * (abs(y - xi_new))^2 + (1-alpha) * huberpriorsum(xi_new,top,bottom,left,right));
                old_obj = (alpha * (abs(y - xi))^2 + (1-alpha) * huberpriorsum(xi,top,bottom,left,right));
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
