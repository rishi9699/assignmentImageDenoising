function y = obje_pixel(xi, curimg, imnoi)
val = (xi-curimg(i-1,j))^2 + (xi-curimg(i+1,j))^2 + (xi-curimg(i,j-1))^2 + (xi-curimg(i,j+1))^2;  %%use circshift
y = alpha * (abs(imnoi(i,j) - xi))^2 + (1-alpha) * val;
end
