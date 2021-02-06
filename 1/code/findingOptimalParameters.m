%Finding the optimal parameters for Quadratic MRF

rrmse=zeros(1,10);
counter=1;
for alpha=0.1:0.1:1
    [quadraticDenoisedImage, ~] = denoiseQuadraticMRF(alpha, imageNoisy);
    rrmse(counter) = sqrt(sum((imageNoiseless - quadraticDenoisedImage).^2))/sqrt(sum(imageNoiseless.^2));
    counter=counter+1;
end
% alpha=0.9 gives lowest RRMSE=0.2154
% Further refining

rrmse=zeros(1,21);
counter=1;
for alpha=0.8:0.01:1
    [quadraticDenoisedImage, ~] = denoiseQuadraticMRF(alpha, imageNoisy);
    rrmse(counter) = sqrt(sum((imageNoiseless - quadraticDenoisedImage).^2))/sqrt(sum(imageNoiseless.^2));
    counter=counter+1;
end
% alpha=0.92 and 0.93 gives lowest RRMSE=0.2151
% Choosing alpha_quadratic=0.92 as optimal

%Finding the optimal parameters for Huber MRF
rrmse=zeros(1,70);
counter=1;
for alpha=0.01:0.01:0.07
    for gamma=0.001:0.001:0.01
        [huberDenoisedImage, ~] = denoiseHuberMRF(alpha, gamma, imageNoisy);
        rrmse(counter) = sqrt(sum((imageNoiseless - huberDenoisedImage).^2))/sqrt(sum(imageNoiseless.^2));
        counter=counter+1;
    end
end
%On further refining and trial-error, we get alpha_huber=0.008 and gamma_huber=0.001

%Finding the optimal parameters for discontinuity adaptive MRF
rrmse=zeros(1,110);
counter=1;
for alpha=0.030:0.001:0.040
    for gamma=0.001:0.001:0.01
        [da_DenoisedImage, ~] = denoiseDAdapMRF(alpha, gamma, imageNoisy);
        rrmse(counter) = sqrt(sum((imageNoiseless - da_DenoisedImage).^2))/sqrt(sum(imageNoiseless.^2));
        counter=counter+1;
    end
end
%On further refining and trial-error, we get alpha_da=0.033 and gamma_da=0.003
