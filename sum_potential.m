function val = sum_potential(i,j,xi)
val = (xi-curimg(i-1,j))^2 + (xi-curimg(i+1,j))^2 + (xi-curimg(i,j-1))^2 + (xi-curimg(i,j+1))^2;  %%use circshift
end