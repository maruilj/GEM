clc;clear;close all
%%
%将所有分辨率下的温度提取到一个矩阵（其中tau是按照递增排列）
load('E:\GEM构建\盐度GEM构建\psal_total_from_all_resolution.mat');
load('E:\GEM构建\tau_total_sort.mat');

psal_all_resolution = zeros(125,4513);

for i = 1:125
    psal_all_resolution(i,:) = psal_total_from_all_resolution(i).ss;
    pres(i) = psal_total_from_all_resolution(i).resolution;
end

[X,Y] = meshgrid(tau_total_sort,pres);
%%
% 绘制等高线图
figure('Name','Salinity GEM');

% 获取等高线上的值
[C,h] = contourf(X,Y,psal_all_resolution);
clabel(C,h); % 将等高线的值标记到图形上

% 添加颜色条
colorbar;

%翻转Y轴
set(gca,'Ydir','reverse')
xlabel('Travel Times(s)');
ylabel('Pressure(dbar)');
title('Salinity GEM');