function curimg = denoiseQuadraticMRF(alpha, imnoi)

    curimg = imnoi;
    oldimg = curimg;
    
    passes=1;
    rrmse_cur=0;

    while true
        disp("pass number"+passes);
        
        for i=0:255
            for j=0:255

                xi = curimg(i+1,j+1);
                top = curimg(mod(i-1,256)+1, j+1);
                bottom = curimg(mod(i+1,256)+1, j+1);
                left = curimg(i+1,mod(j-1,256)+1);
                right = curimg(i+1,mod(j+1,256)+1);
                y=imnoi(i+1,j+1);

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
                curimg(i+1,j+1) = xi;

            end
        end
        
        
        
        rrmse_new = sqrt(sum((curimg - oldimg).^2))/sqrt(sum(curimg.^2));
        
        if (abs(rrmse_cur - rrmse_new) < 0.001 || passes>100)
            disp(passes)
            disp(rrmse_cur)
            break
        else
            rrmse_cur = rrmse_new;
        end
            
        passes=passes+1;
    end
end
