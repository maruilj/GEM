clc;clear;close all
%%
% 首先，指定包含.mat文件的文件夹路径
folder = 'C:\Users\mr\Desktop\无NaN值温盐压插值温盐压数据文件—resolution=10(杭州Argo1997-2022)\填充NaN后的温盐压';

% 获取文件夹中所有.mat文件的列表
file_list = dir(fullfile(folder, '*.mat'));

%%
% 遍历每个.mat文件
% 创建一个空结构体
eachprofile_tau_2000_NaN = struct();
pstart = 0;
pstop = 2000;

for i = 1:length(file_list)
    file_name = fullfile(folder, file_list(i).name);
    splitname = split(file_name,'\');
    eachprofile_tau_2000_NaN(i).Name = splitname{end};
    load(file_name,'data_GOM');
     [tau_index,rho,c] = get_rho_NaN_from_prs(file_name,pstart,pstop);
    eachprofile_tau_2000_NaN(i).tau_index = tau_index;
    eachprofile_tau_2000_NaN(i).rho = rho;
    eachprofile_tau_2000_NaN(i).c = c;
    
end

