close all
clear
clc

% input
fpath0 = 'M:\TrCer_1000\TrCer_1000_noturb';
cd(fpath0)
%Istart = 2; % better to ignore the 1st image
 
%%%
fpath = [fpath0 filesep 'raw'];
% get the folder contents
addpath(genpath('C:\Users\meatlab1-admin\Documents\facundo\Particle-laden-turbulence'));
%dfolders = FunSubfolder(fpath);
dfolders = [];

%%% preproc & split

dataset_all = {'fullg', 'ddt', 'dec'};

for jj=1

    dataset = dataset_all{jj}; 

    image_list = dir([fpath filesep 'Camera1' filesep '*.tiff']);
    img_num = size(image_list,1);

    if dataset(1) == 'f'
        Istart = 2;
        Iend = 9584;
    elseif dataset == 'ddt'
        Istart = 9585;
        Iend = 15863;
    else
        Istart = 15864;
        Iend = img_num;
    end


    if numel(dfolders)~=0
        subfolders = [fpath filesep dfolders(i).name];
        preproc_dirt = [fpath0 filesep 'preproc' filesep 'tracer_' dataset filesep dfolders(i).name ];
        preproc_dirp = [fpath0 filesep 'preproc' filesep 'particle_' dataset filesep dfolders(i).name ];
    else
        subfolders = fpath;
        preproc_dirt = [fpath0 filesep 'preproc' filesep 'tracer_' dataset];
        preproc_dirp = [fpath0 filesep 'preproc' filesep 'particle_' dataset];
    end
    mkdir(preproc_dirt)
    mkdir(preproc_dirp)


    %%% get Backgrounds
    Istart = 5500;
    %cam 1
    bkg1_originalSize = getBkg(subfolders,'Camera1',Istart,img_num,100,[]);
    %cam2
    bkg2_originalSize = getBkg(subfolders,'Camera2',Istart,img_num,100,[]);
    %cam3
    bkg3_originalSize = getBkg(subfolders,'Camera3',Istart,img_num,100,[]);
    counter = 0;

    %5339
 %for k=Istart:Iend
   %for k=Istart:Istart+200
   disp('all ims');pause
    for k = 5500:img_num+5500
      
 %for k=1:500
        counter = counter+1;
        k/Iend

        %%% cam1
        fname=[subfolders filesep 'Camera1' filesep 'frame_' num2str(k,'%06d') '.tiff'];
        Im1_originalSize = imread(fname);

        intensity_thr = 3e3;
        thr_removepart = 1900;
       [Im01,Im1t,Im1p]=Facu_preprocessing(Im1_originalSize,intensity_thr,9,1,bkg1_originalSize,thr_removepart);
        fnameo = ['cam1_frame_' num2str(counter,'%06d') '.tiff'];
        %imwrite(uint16(Im1t),[preproc_dirt filesep fnameo])
        imwrite(uint16(Im1p),[preproc_dirp filesep fnameo]);
                % figure(10);
                % subplot(2,1,1);imagesc(Im1p);axis equal
                % title(num2str(k))
                % subplot(2,1,2);imagesc(Im1t);axis equal
                % pause(0.1)


        %%% cam2
        fname=[subfolders filesep 'Camera2' filesep 'frame_'  num2str(k,'%06d') '.tiff'];
        Im2_originalSize = imread(fname);
        intensity_thr = 2e3;
        thr_removepart = 19000;
        [Im02,Im2t,Im2p]=Facu_preprocessing(Im2_originalSize,intensity_thr,9,1.6,bkg2_originalSize,thr_removepart);
        fnameo = ['cam2_frame_' num2str(counter,'%06d') '.tiff'];
      % imwrite(uint16(Im2t),[preproc_dirt filesep fnameo]);
      imwrite(uint16(Im2p),[preproc_dirp filesep fnameo]);
               % figure(10);
               %   subplot(2,1,1);imagesc(Im2p);axis equal
               %   title(num2str(k))
               %   subplot(2,1,2);imagesc(Im2t);axis equal
               %   pause(0.05)

        %%% cam3
        fname=[subfolders filesep 'Camera3' filesep 'frame_' num2str(k,'%06d') '.tiff'];
        Im3_originalSize = imread(fname);
        intensity_thr = 2e3;
        [Im03,Im3t,Im3p] =Facu_preprocessing(Im3_originalSize,intensity_thr,9,1.7,bkg3_originalSize,thr_removepart);
        fnameo = ['cam3_frame_' num2str(counter,'%06d') '.tiff'];
       % imwrite(uint16(Im3t),[preproc_dirt filesep fnameo]);
       imwrite(uint16(Im3p),[preproc_dirp filesep fnameo]);
                 %         figure(10);
                 % subplot(2,1,1);imagesc(Im3p);axis equal
                 % subplot(2,1,2);imagesc(Im3t);axis equal
                 % pause(0.05)
    end
end


