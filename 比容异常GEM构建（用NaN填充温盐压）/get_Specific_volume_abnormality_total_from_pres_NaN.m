function [SVA_total] = get_Specific_volume_abnormality_total_from_pres_NaN(pres_concrete)
%%
% 首先，指定包含.mat文件的文件夹路径
folder = 'C:\Users\mr\Desktop\无NaN值温盐压插值温盐压数据文件—resolution=10(杭州Argo1997-2022)\填充NaN后的温盐压';

% 获取文件夹中所有.mat文件的列表
file_list = dir(fullfile(folder, '*.mat'));

%%
%温度取每个剖面上0-10dbar的均值，tau取每个剖面计算出来的tau
%取出每个剖面的10dbar的温度均值存进数组

load('D:\Program Files (x86)\MATLAB\matlab_study\GEM构建\比容异常GEM构建（用NaN填充温盐压）\eachprofile_tau_2000_NaN.mat');

% if ismember((pres_concrete+10)./10, eachprofile_tau(i).rho{1, j})
   
%wuwuwuwuwu
SVA_from_pres_concrete = [];
for i = 1:length(file_list)
    for j = 1:length(eachprofile_tau_2000_NaN(i).rho)
        SVA_from_pres_concrete = [SVA_from_pres_concrete,1./(eachprofile_tau_2000_NaN(i).rho{1, j}((pres_concrete+10)./10))]; 
    end
end

%没温度、盐度数据也不用改，不影响
    SVA_refer(pres_concrete) = 1./(gsw_rho(35, 0, pres_concrete));%参考比容异常


SVA_total = [];
for k = 1:length(SVA_from_pres_concrete)
    SVA_total(k) = abs(SVA_from_pres_concrete(k)-SVA_refer(pres_concrete));
end
                     
         
end