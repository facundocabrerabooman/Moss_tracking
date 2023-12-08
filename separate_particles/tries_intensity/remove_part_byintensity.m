function [Imt,Imp] = remove_part_byintensity(Im,radii_range,intensity_thr)
%FCB

% raddi_range =  range of radius for inertial & tracers particles (i.e. get rid of crap)

Imp = Im; Imt = Im;

Imbw = imbinarize(Im);

PP=regionprops(Imbw,'Centroid','Area','MajorAxisLength','MinorAxisLength','Circularity');

cc=vertcat(PP.Centroid);
Ma = vertcat(PP.MajorAxisLength);
ma = vertcat(PP.MinorAxisLength);
A = vertcat(PP.Area);

if isempty(cc)
    x=[];
    y=[];
else
    x=cc(:,1);
    y=cc(:,2);
end
%
% C = vertcat(PP.Circularity);
% 
% [kkill,~] = find(C<1.3);
% %ikill
% x(kkill)=[];
% y(kkill,:)=[];
% Ma(kkill,:)=[];
% ma(kkill,:)=[];
% cc(kkill,:)=[];
% C(kkill,:)=[];
% 
% [kkill,~] = find(C>5);
% %ikill
% x(kkill)=[];
% y(kkill,:)=[];
% Ma(kkill,:)=[];
% ma(kkill,:)=[];
% cc(kkill,:)=[];
% C(kkill,:)=[];
% 
% [ikill,~] = find((Ma+ma)/2>radii_range(2));
% %ikill
% x(ikill)=[];
% y(ikill,:)=[];
% Ma(ikill,:)=[];
% ma(ikill,:)=[];
% cc(ikill,:)=[];
% C(ikill,:)=[];
% % %
% [jkill,~] = find((Ma+ma)/2<=radii_range(1));
% %ikill
% x(jkill)=[];
% y(jkill,:)=[];
% Ma(jkill,:)=[];
% ma(jkill,:)=[];
% cc(jkill,:)=[];
% C(jkill,:)=[];


for i = 1:numel(x)
    intensity_tmp = Im(min(512,round(x(i))),min(1280,round(y(i))));
    r_tmp = (Ma(i)+ma(i))/2;
    if intensity_tmp > intensity_thr 
        i
        Imt(double(max(1,round(x(i)-r_tmp))):double(min(512,round(x(i)+r_tmp))),double(max(1,round(y(i)-r_tmp))):double(min(1280,round(y(i)+r_tmp)))) = 0;
    else
        Imp(double(max(1,round(x(i)-r_tmp))):double(min(512,round(x(i)+r_tmp))),double(max(1,round(y(i)-r_tmp))):double(min(1280,round(y(i)+r_tmp)))) = 0;
    end
    clear intensity_tmp r_tmp
end

