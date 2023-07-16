clc;clear;close all
%%
% 首先，指定包含.mat文件的文件夹路径
folder = 'E:\GEM构建\无NaN值温盐压插值温盐压数据文件—resolution=10(杭州Argo1997-2022)_无填充处理_最新';

% 获取文件夹中所有.mat文件的列表
file_list = dir(fullfile(folder, '*.mat'));

%%
% 遍历每个.mat文件
% 创建一个空结构体
eachprofile_tau = struct();
pstart = 0;
pstop = 1000;

for i = 1:length(file_list)
    file_name = fullfile(folder, file_list(i).name);
    splitname = split(file_name,'\');
    eachprofile_tau(i).Name = splitname{end};
    load(file_name,'data_GOM');
     [tau_index,rho,c] = get_tau_from_prs(file_name,pstart,pstop);
    eachprofile_tau(i).tau_index = tau_index;
    eachprofile_tau(i).rho = rho;
    eachprofile_tau(i).c = c;
    
end

%%
%提取tau
tau_total = [];
for x = 1:length(file_list)
    tau_total = [tau_total,eachprofile_tau(x).tau_index];  
end
