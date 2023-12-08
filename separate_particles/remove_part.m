function [Imt,Imp] = remove_part(Im,PartRadius)

st = strel('disk',round(PartRadius/2));
stdil = strel('disk',round(PartRadius/5));

Imd = imdilate(imbinarize(imopen(Im,st)),stdil);

%% refine particle image
%Rp=sqrt(numel(find(Imd~=0)))/pi;
Rp = PartRadius;
Rmin = max(0.2*Rp,1);
Rmax = max(3*Rp,14);
[C, R] = imfindcircles(Imd, cast([Rmin Rmax],class(Im)));
if size(C,1) == 1
    roi=images.roi.Circle('Center',C,'Radius',R);
    mask = createMask(roi,size(Imd,1),size(Imd,2));
else
    mask = Imd;
end
Imp = immultiply(Im,cast(mask,class(Im)));
Imt = immultiply(Im,cast(abs(1-mask),class(Im)));

%% make inertial particles smaller
% 
% 
% % Convert the image to grayscale if it's not already
% grayImage = Imp;
% 
% % Define the range of possible radii for circles
% minRadius = 2; % Replace with an appropriate value
% maxRadius = 50; % Replace with an appropriate value
% radiiRange = [minRadius, maxRadius];
% 
% % Perform circle detection using imfindcircles
% [centers, radii, ~] = imfindcircles(grayImage, radiiRange);
% 
% % Visualize the detected circles on the original image
% % figure;
% % subplot(1, 2, 1);
% % imshow(Imd);
% % title('Original Image');
% % 
% % subplot(1, 2, 2);
% % imshow(Imd);
% % viscircles(centers, radii, 'EdgeColor', 'b');
% % title('Detected Circles');
% % Specify the scaling factor for the circles (e.g., 0.8 for 80% reduction)
% scalingFactor = 0.1;
% 
% % Create a new image with the same size as the original image
% newImage = zeros(size(Imd));
% 
% % Iterate through each detected circle
% for i = 1:size(centers, 1)
%     % Get the center and radius of the current circle
%     center = centers(i, :);
%     radius = radii(i);
% 
%     % Calculate the new radius by scaling
%     newRadius = scalingFactor * radius;
% 
%     % Create a binary mask for the current circle
%     [X, Y] = meshgrid(1:size(Imd, 2), 1:size(Imd, 1));
%     mask = ((X - center(1)).^2 + (Y - center(2)).^2) <= newRadius^2;
% 
%     % Update the new image with the smaller circle
%     newImage = newImage + mask;
% end
% Imp=imgaussfilt(newImage.*1e3,2);










