close all
clear
clc

% input
fpath0 = 'C:\Users\meatlab1-admin\Desktop\Ryan_Moss_4';
cd(fpath0)
 
%%%
fpath = [fpath0 filesep 'raw'];
addpath(genpath('C:\Users\meatlab1-admin\Documents\facundo\Moss_tracking'));
dfolders = [];


    image_list = dir([fpath filesep '*.tif']);
    img_num = size(image_list,1);

    Istart = 2;
    Iend = img_num;

    preproc_dirp = [fpath0 filesep 'preproc' filesep];
    mkdir(preproc_dirp)

  
counter = 0;

 for k=4500:1:5000

        counter = counter+1;
        k/Iend
        k
        fname=[fpath filesep 'B' num2str(k,'%05d') '.tif'];
        Im = imread(fname);
        Im1_originalSize = Im(1:960,:);
        Im2_originalSize = Im(961:end,:);
        % 

           %%% get Backgrounds
         %[bkg1_originalSize, ~] = getBkg(fpath,1, 4000, 100,[]);
         [~, bkg2_originalSize] = getBkg(fpath,k-2, k-2, 1,[]);
         bkg1_originalSize = bkg2_originalSize; %dummy bkg, we don't use it for cam1


           % Cam1
         intensity_thr = 100;
         cam ='cam1';
         [~,~,Im1p]=Ryan_preprocessing(Im1_originalSize,intensity_thr,2,1,bkg1_originalSize,cam);
         fnameo = ['cam1_frame_' num2str(counter,'%06d') '.tiff'];
         imwrite(uint16(Im1p),[preproc_dirp filesep fnameo]);
                 %figure(10);
                 %subplot(2,1,1);imagesc(Im1_originalSize);axis equal
                 %imagesc(Im2_originalSize)
                 %title(num2str(k))
                 %subplot(2,1,2);imagesc(Im1p);axis equal
                %pause(0.1)

        % Cam2 -- moss one
         intensity_thr = 100;
         cam = 'cam2';
         [~,~,Im2p]=Ryan_preprocessing(Im2_originalSize,intensity_thr,2,1,bkg2_originalSize,cam);
         fnameo = ['cam2_frame_' num2str(counter,'%06d') '.tiff'];
         imwrite(uint16(Im2p),[preproc_dirp filesep fnameo]);
                 %figure(10);
                 %subplot(2,1,1);imagesc(Im1_originalSize);axis equal
                 %imagesc(Im2_originalSize)
                 %title(num2str(k))
                 %subplot(2,1,2);imagesc(Im1p);axis equal
                %pause(0.1)



 end


