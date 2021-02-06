% 0.1, 0.02
function [curimg, obj_values] = denoiseDAdapMRF(alpha, gamma, imnoi)
    
    curimg = imnoi;
    oldimg = curimg;
    
    iter=1;
    rrmse_cur=0;
    
    obj_values=zeros(1,100);
    
    while true
        %disp("pass number"+iter);
        total_obj_value = 0;
        for i=0:255
            for j=0:255
                
                xi = curimg(i+1,j+1);
                top = curimg(mod(i-1,256)+1, j+1);
                bottom = curimg(mod(i+1,256)+1, j+1);
                left = curimg(i+1,mod(j-1,256)+1);
                right = curimg(i+1,mod(j+1,256)+1);
                y=imnoi(i+1,j+1);

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
                
                total_obj_value = total_obj_value + alpha * (abs(y - xi))^2 + (1-alpha) * (gamma * (abs(top-xi) + abs(bottom-xi) +abs(left-xi) + abs(right-xi)) - gamma^2 * log( (1+abs(top-xi)/gamma) * (1+abs(bottom-xi)/gamma) * (1+abs(left-xi)/gamma) * (1+abs(right-xi)/gamma) ));
                curimg(i+1,j+1) = xi;

            end
        end
        
        rrmse_new = sqrt(sum((curimg - oldimg).^2))/sqrt(sum(curimg.^2));
        %disp(iter)
        %disp(rrmse_new)
        if (abs(rrmse_cur - rrmse_new) < 0.0001 || iter>100)
            %disp(iter)
            %disp(rrmse_cur)
            break
        else
            rrmse_cur = rrmse_new;
        end
        
        obj_values(iter) = total_obj_value;
        iter=iter+1;
        
    end
end
