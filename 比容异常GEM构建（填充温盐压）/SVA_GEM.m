clc;clear;close all
%%
%将所有分辨率下的温度提取到一个矩阵（其中tau是按照递增排列）
load('D:\Program Files (x86)\MATLAB\matlab_study\GEM构建\比容异常GEM构建（填充温盐压）\SVA_total_from_all_resolution.mat');
load('D:\Program Files (x86)\MATLAB\matlab_study\GEM构建\tau_total_sort.mat');

SVA_all_resolution = zeros(125,4000);

for i = 1:125
    SVA_all_resolution(i,:) = SVA_total_from_all_resolution(i).aa;
    pres(i) = SVA_total_from_all_resolution(i).resolution;
end

[X,Y] = meshgrid(tau_total_sort,pres);
%%
% 绘制等高线图
figure('Name','Specific volume abnormality GEM');

% 获取等高线上的值
[C,h] = contourf(X,Y,SVA_all_resolution);
clabel(C,h); % 将等高线的值标记到图形上

% 添加颜色条
colorbar;

%翻转Y轴
set(gca,'Ydir','reverse')
xlabel('Travel Times(s)');
ylabel('Pressure(dbar)');
title('Specific volume abnormality GEM');
