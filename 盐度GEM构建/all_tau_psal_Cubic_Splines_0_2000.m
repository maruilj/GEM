clc;clear;close all
%%
%创建一个结构体保存所需要分辨率下的温度
psal_total_from_all_resolution = struct();
%%
% 循环提取出所有需要的分辨率下具体压力的索引，再用该索引提取温度
%10:10:1000dbar三次样条拟合
k = 1;
for i =10:10:1000
    
    psal_total_from_all_resolution(k).psal_total = get_psal_total_from_pres(i);

%%
    %取出每个剖面上的tau
    %load('D:\Program Files (x86)\MATLAB\matlab_study\GEM_tau\tau_total.mat');
    load('E:\GEM构建\tau_total.mat');
    %排序
    [tau_total_sort,I] = sort(tau_total); 
    psal_total_from_all_resolution(k).psal_total_sort = psal_total_from_all_resolution(k).psal_total(I);
    
    figure('Name','tau_psal_0_1000');
%%
%绘制点 
    plot(tau_total_sort, psal_total_from_all_resolution(k).psal_total_sort, 'o','MarkerSize',4)
    hold on;
%%
%三次样条拟合
%使用 csaps 进行平滑插值拟合
    smoothness = 0.3;% 平滑系数
    xx = tau_total_sort; % 定义拟合曲线的 x 值范围 从0到2pi生成一千个点
    psal_total_from_all_resolution(k).ss = csaps(tau_total_sort,psal_total_from_all_resolution(k).psal_total_sort,smoothness,xx);
    plot(xx,psal_total_from_all_resolution(k).ss)
    hold off;
%存分辨率
    psal_total_from_all_resolution(k).resolution = i;
    k = k+1;
end



%%
%1040:40:2000dbar三次样条拟合
for j =1040:40:2000
    
    psal_total_from_all_resolution(k).psal_total = get_psal_total_from_pres(j);

%%
%取出每个剖面上的tau
    load('E:\GEM构建\tau_total.mat');
    [tau_total_sort,I] = sort(tau_total); 
    psal_total_from_all_resolution(k).psal_total_sort = psal_total_from_all_resolution(k).psal_total(I);
    
%%
%绘制点 
    figure('Name','tau_psal_1040_2000');
    plot(tau_total_sort, psal_total_from_all_resolution(k).psal_total_sort, 'o','MarkerSize',4)
    hold on;
%%
%三次样条拟合
%使用 csaps 进行平滑插值拟合
    smoothness = 0.3;% 平滑系数
    xx = tau_total_sort; % 定义拟合曲线的 x 值范围 从0到2pi生成一千个点
    psal_total_from_all_resolution(k).ss = csaps(tau_total_sort,psal_total_from_all_resolution(k).psal_total_sort,smoothness,xx);
    plot(xx,psal_total_from_all_resolution(k).ss)
    hold off;
%存分辨率
    psal_total_from_all_resolution(k).resolution = j;
    k = k+1;
end