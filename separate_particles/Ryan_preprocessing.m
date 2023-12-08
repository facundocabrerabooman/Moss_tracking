function [Im_sub,Imt,Imp]=Facu_preprocessing(Im,th,part_radius,gain,bkg,cam)

%Im = imcomplement(Im);


%se=strel('disk',strel_size); %opening to remove big elements
%imo=imopen(Im,se);
Im_sub=imsubtract(bkg,Im);
%Im_sub = Im;
%Im = bpass2(Im,lnoise,part_size);
%Im = imgaussfilt(Im,part_radius);
%Im=imnlmfilt(Im);

% Th = th*mean(mean(Im));
Im_sub(Im_sub<th)=0; %thresholding to remove the background
%Im(Im<th)=0; %thresholding to remove the background
%Im_sub=Im;
%Im=medfilt2(Im,[3,3]);
%Im = imadjust(Im,stretchlim(Im),[]);

%Im=imsharpen(Im,'Radius',6);
%Im(Im<th)=0; %thresholding to remove the background

%se=strel('disk',1); %opening to remove little elements
%Im=imerode(Im,se);

%Imbw=imregionalmax(Im,6);
%Im = Im/mean(Im(Imbw))*gain;

if cam(4)=='1'
    Im(Im<th)=0;
    Im_sub=Im;
end

tt = class(Im_sub);
%Im = cast(double(Im)/max(max(double(Im)))*gain,tt);
Im_sub = cast(double(Im_sub)*gain,tt);

[Imt,Imp]= remove_part(Im_sub,part_radius);

