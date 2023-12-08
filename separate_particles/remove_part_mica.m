function [Imt,Imp] = remove_part_mica(Im,PartRadius,thr_removepart)

stdil = strel('disk',round(0.5*PartRadius));
stdt = strel('disk',round(0.3*PartRadius)); % 
stdt_imt = strel('disk',round(0.2*PartRadius)); % 

%%

% [cnts,x]=imhist(Im);
% figure;loglog(x,cnts);
%% 
Imp=imopen(Im,stdt);
%Imp=imbinarize(Imp,intensity_thr/65536);
Imp=imbinarize(Imp);

%%
Imt = Im.*uint16(1-Imp);

%%
Rmin = max(1,0.1*PartRadius); 
Rmax = 4*PartRadius;
[Ctmp, Rtmp] = imfindcircles(Imp, cast([Rmin Rmax],class(Im)));
hold on
%viscircles(Ctmp,Rtmp);
%%
I = find(abs(PartRadius-Rtmp)./PartRadius<0.5);
%%
C=Ctmp(I,:);
R=Rtmp(I);
if ~isempty(C)
    roi=images.roi.Circle('Center',C(1,:),'Radius',R(1));
    mask = createMask(roi,size(Im,1),size(Im,2));
    for k=2:size(C,1);
        roi=images.roi.Circle('Center',C(k,:),'Radius',R(k));
        mask = mask + createMask(roi,size(Im,1),size(Im,2));
    end
    Imp = immultiply(Im,cast(mask,class(Im)));
    Imp = imopen(Imp,stdil);
else
    Imp=uint16(zeros(size(Im)));
end
%figure;imshow(mask)

%figure;imshowpair(Imp,Im);


%%


%%
Imth=Imt;
Imth(Imth<thr_removepart)=0;
%%
% stdil = strel('disk',round(0.33*PartRadius));
% Imthc = imopen(Imth,stdil);
% 
% Imth=imsubtract(Imth,Imthc);


%Imth=imopen(Imth,std0);
Imth = imdilate(Imth,stdt_imt);
%%
%figure;imshowpair(Imth,Imt);
%%
%Imth = imbinarize(Imth,intensity_thr/65536);
Imth = imbinarize(Imth);
%%
Imth=1-Imth;
%%
Imt=Imt.*uint16(Imth);
%figure;imshow(Imt);













