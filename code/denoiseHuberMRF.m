% 0.1, 0.01
function curimg = denoiseHuberMRF(alpha, gamma, imnoi)
    curimg = imnoi;
    oldimg = curimg;
    
    passes=1;
    rrmse_cur=0;
    
    while true
        disp("pass number"+passes);
        for i=2:255
            for j=2:255
                xi = curimg(i,j);
                top = curimg(i-1,j);
                bottom = curimg(i+1,j);
                left = curimg(i,j-1);
                right = curimg(i,j+1);
                y=imnoi(i,j);

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

                    new_obj = (alpha * (abs(y - xi_new))^2 + (1-alpha) * huberpriorsum(xi_new,top,bottom,left,right, gamma));
                    old_obj = (alpha * (abs(y - xi))^2 + (1-alpha) * huberpriorsum(xi,top,bottom,left,right, gamma));
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
        rrmse_new = sqrt(sum((curimg - oldimg).^2))/sqrt(sum(curimg.^2));
        disp(passes)
        disp(rrmse_new)
        if (abs(rrmse_cur - rrmse_new) < 0.0001 || passes>100)
            disp(passes)
            disp(rrmse_cur)
            break
        else
            rrmse_cur = rrmse_new;
        end
            
        passes=passes+1;
        
    end
end

