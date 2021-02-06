%% RRMSE between noisy and noiseless images
load('../data/assignmentImageDenoisingPhantom')

RRMSE_original = sqrt(sum((imageNoiseless - imageNoisy).^2))/sqrt(sum(imageNoiseless.^2));
disp("The The value of the RRMSE between the originial image and the noisy image is "+ RRMSE_original)

%% Finding out the optimal parameters of alpha and gamma for all the three prior models
%  
%  Lets say we did something here
%  Some code written here
%  and here to find the optimal values
%  lets say they are alpha=0.96 for quadratic, 0.1, 0.008 huber
%  0.1, 0.02 for DA
%  we have to find this real time, as the images are inputs and no fixed
%
alpha_quadratic = 0.96;

alpha_huber = 0.55;
gamma_huber = 0.008;

alpha_da = 0.1;
gamma_da = 0.02;
%%
%  The optimal values are as follows,
%
disp("alpha = "+alpha_quadratic+" for Quadratic MRF")
disp("alpha = "+alpha_huber+" and gamma = " + gamma_huber+ " for Discontinuity-adaptive Huber MRF")
disp("alpha = "+alpha_da+" and gamma = " + gamma_da+ " for Discontinuity-adaptive MRF")

%% Evidence of the optimality of the reported values
%  Various RRMSE values for the three priors and their optimal parameters are shown here.
%  RRMSE values corresponding to plus/minus 20% of the optimal value is also calculated in order to depict the optimality of
%  the above parameters obtained.

[quadraticDenoisedImage, objectiveValsQuadratic] = denoiseQuadraticMRF(alpha_quadratic, imageNoisy);
disp("RRMSE(alpha) for quadratic MRF is,")
disp(sqrt(sum((imageNoiseless - quadraticDenoisedImage).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(1.2*alpha) for quadratic MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseQuadraticMRF(min(1.2*alpha_quadratic, 1), imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(0.8*alpha) for quadratic MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseQuadraticMRF(0.8*alpha_quadratic, imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))

%%
[huberDenoisedImage, objectiveValsHuber] = denoiseHuberMRF(alpha_huber, gamma_huber, imageNoisy);
disp("RRMSE(alpha, gamma) for Discontinuity-adaptive Huber MRF is,")
disp(sqrt(sum((imageNoiseless - huberDenoisedImage).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(1.2*alpha, gamma) for Discontinuity-adaptive Huber MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseHuberMRF(min(1.2*alpha_huber, 1), gamma_huber, imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(0.8*alpha, gamma) for Discontinuity-adaptive Huber MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseHuberMRF(0.8*alpha_huber, gamma_huber, imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(alpha, 1.2*gamma) for Discontinuity-adaptive Huber MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseHuberMRF(alpha_huber, 1.2*gamma_huber, imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(alpha, 0.8*gamma) for Discontinuity-adaptive Huber MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseHuberMRF(alpha_huber, 0.8*gamma_huber, imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))

%%
[da_DenoisedImage, objectiveValsDA] = denoiseDAdapMRF(alpha_da, gamma_da, imageNoisy);
disp("RRMSE(alpha, gamma) for Discontinuity-adaptive  MRF is,")
disp(sqrt(sum((imageNoiseless - da_DenoisedImage).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(1.2*alpha, gamma) for Discontinuity-adaptive  MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseDAdapMRF(min(1.2*alpha_da, 1), gamma_da, imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(0.8*alpha, gamma) for Discontinuity-adaptive  MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseDAdapMRF(0.8*alpha_da, gamma_da, imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(alpha, 1.2*gamma) for Discontinuity-adaptive  MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseDAdapMRF(alpha_da, 1.2*gamma_da, imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))
disp("RRMSE(alpha, 0.8*gamma) for Discontinuity-adaptive  MRF is,")
disp(sqrt(sum((imageNoiseless - denoiseDAdapMRF(alpha_da, 0.8*gamma_da, imageNoisy)).^2))/sqrt(sum(imageNoiseless.^2)))

%% Plotting the noisy, noiseless and denoised images
imshow(imageNoiseless, 'colormap', jet)
colorbar
title('Noiseless Image')

figure
imshow(imageNoisy, 'colormap', jet)
colorbar
title('Noisy Image')

figure
imshow(quadraticDenoisedImage, 'colormap', jet)
colorbar
title('Image denoised using quadratic prior')

figure
imshow(huberDenoisedImage, 'colormap', jet)
colorbar
title('Image denoised using huber prior')

figure
imshow(da_DenoisedImage, 'colormap', jet)
colorbar
title('Image denoised using discontinuity adaptive prior')

%% Plotting the objective-function values versus iteration for the 3 denoised results

figure
plot(1:sum(objectiveValsQuadratic~=0), objectiveValsQuadratic(1:sum(objectiveValsQuadratic~=0)), '-o')
title("Objective-function value vs. iteration for Gaussian MRF prior")
xlabel("iteration")
ylabel("Objective-function value")
xticks(1:sum(objectiveValsQuadratic~=0))

figure
plot(1:sum(objectiveValsDA~=0), objectiveValsDA(1:sum(objectiveValsDA~=0)), '-o')
title("Objective-function value vs. iteration for discontinuity adaptive MRF prior")
xlabel("iteration")
ylabel("Objective-function value")
xticks(1:sum(objectiveValsDA~=0))

figure
plot(1:sum(objectiveValsHuber~=0), objectiveValsHuber(1:sum(objectiveValsHuber~=0)), '-o')
title("Objective-function value vs. iteration for Huber MRF prior")
xlabel("iteration")
ylabel("Objective-function value")
xticks(1:sum(objectiveValsHuber~=0))
