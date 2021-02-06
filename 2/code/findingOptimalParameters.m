%Finding the optimal parameters for Quadratic MRF

rrmse=zeros(1,10);
counter=1;
for alpha=0.1:0.1:1
    [quadraticDenoisedImage, ~] = denoiseQuadraticMRF(alpha, brainMRIsliceNoisy);
    rrmse(counter) = sqrt(sum((brainMRIsliceOrig - quadraticDenoisedImage).^2))/sqrt(sum(brainMRIsliceOrig.^2));
    counter=counter+1;
end
% alpha=0.9 gives lowest RRMSE=0.1078
% Further refining

rrmse=zeros(1,21);
counter=1;
for alpha=0.8:0.01:1
    [quadraticDenoisedImage, ~] = denoiseQuadraticMRF(alpha, brainMRIsliceNoisy);
    rrmse(counter) = sqrt(sum((brainMRIsliceOrig - quadraticDenoisedImage).^2))/sqrt(sum(brainMRIsliceOrig.^2));
    counter=counter+1;
end
% alpha=0.87 gives lowest RRMSE=0.1071
% Choosing alpha_quadratic=0.88 as optimal

%Finding the optimal parameters for Huber MRF
rrmse=zeros(1,70);
counter=1;
for alpha=0.10:0.01:0.20
    for gamma=0.001:0.001:0.01
        [huberDenoisedImage, ~] = denoiseHuberMRF(alpha, gamma, brainMRIsliceNoisy);
        rrmse(counter) = sqrt(sum((brainMRIsliceOrig - huberDenoisedImage).^2))/sqrt(sum(brainMRIsliceOrig.^2));
        counter=counter+1;
    end
end
%On further refining and trial-error, we get alpha_huber=0.16 and gamma_huber=0.008

%Finding the optimal parameters for discontinuity adaptive MRF
rrmse=zeros(1,121);
counter=1;
for alpha=0.20:0.001:0.30
    for gamma=0.010:0.001:0.02
        [da_DenoisedImage, ~] = denoiseDAdapMRF(alpha, gamma, brainMRIsliceNoisy);
        rrmse(counter) = sqrt(sum((brainMRIsliceOrig - da_DenoisedImage).^2))/sqrt(sum(brainMRIsliceOrig.^2));
        counter=counter+1;
    end
end
%On further refining and trial-error, we get alpha_da=0.25 and gamma_da=0.018
