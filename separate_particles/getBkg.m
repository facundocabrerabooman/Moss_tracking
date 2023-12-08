function [bkg_c1, bkg_c2] = getBkg(subfolders,Istart,Iend,increment,demosaicpattern)


fname = [subfolders filesep 'B' num2str(Istart,'%05d') '.tif' ];
Im = imread(fname);%,'ppm','uint16');

Imc1 = Im(1:960,:);
Imc2 = Im(961:end,:);
cc = class(Imc1);

%% Cam 1

if ~isempty(demosaicpattern)
    Imc1 = rgb2gray(demosaic(Imc1,demosaicpattern));
    cc = class(Imc1);
end

Imc1 = double(0*Imc1);
Nim = 0;
for k = Istart : increment : Iend
    Nim=Nim+1;
    fname = [subfolders filesep 'B' num2str(k,'%05d') '.tif' ];
    Im = imread(fname);%,'ppm','uint16');
    Im1_tmp = Im(1:960,:);
    if ~isempty(demosaicpattern)
        Imc1 = Imc1+double(rgb2gray(demosaic(Im1_tmp),demosaicpattern));
    else
        Imc1 = Imc1+double((Im1_tmp));
    end
end
% figure;imagesc(Im/Nim)
bkg_c1 = cast(Imc1/Nim,cc);

%% Cam 2

if ~isempty(demosaicpattern)
    Imc2 = rgb2gray(demosaic(Imc2,demosaicpattern));
    cc = class(Imc2);
end

Imc2 = double(0*Imc2);
Nim = 0;
for k = Istart : increment : Iend
    Nim=Nim+1;
    fname = [subfolders filesep 'B' num2str(k,'%05d') '.tif' ];
    Im = imread(fname);%,'ppm','uint16');
    Im2_tmp = Im(961:end,:);
    if ~isempty(demosaicpattern)
        Imc2 = Imc2+double(rgb2gray(demosaic(Im2_tmp),demosaicpattern));
    else
        Imc2 = Imc2+double((Im2_tmp));
    end
end
% figure;imagesc(Im/Nim)
bkg_c2 = cast(Imc2/Nim,cc);
