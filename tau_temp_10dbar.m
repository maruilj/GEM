clc;clear;close all
%%
% 首先，指定包含.mat文件的文件夹路径
folder = 'C:\Users\mr\Desktop\无NaN值温盐压插值温盐压数据文件—resolution=10(杭州Argo1997-2022)';

% 获取文件夹中所有.mat文件的列表
file_list = dir(fullfile(folder, '*.mat'));

%%
%温度取每个剖面上0-10dbar的均值，tau取每个剖面计算出来的tau
%取出每个剖面的10dbar的温度均值存进数组

  temp_total = [];

for i = 1:length(file_list)
    file_name = fullfile(folder, file_list(i).name);
    load(file_name,'data_GOM');
    
    for j = 1:length(data_GOM)
        %for k =1:length(data_GOM{1,j}.temp_adj)
        
        %for k =1:30
            if isempty(data_GOM{1,j})
                continue
            end
              % 找出值为 10 的元素索引
              %index = find(data_GOM{1,j}.P_adj_interp == 10);
              
              % 找出最接近 10 的元素索引
              [~,index] = min(abs((data_GOM{1,j}.P_adj_sample)- 10));
    
        %end
              %获取每个剖面压力为10时的温度数据存进temp_total
              temp_total = [temp_total,data_GOM{1,j}.T_adj_sample(index)];
    end
end

%%
%取出每个剖面上的tau
%load('D:\Program Files (x86)\MATLAB\matlab_study\GEM_tau\tau_total2.mat');
load("tau_total.mat");
%%
%绘制点
plot(tau_total, temp_total, 'o','MarkerSize',4)
hold on;
%%
%三次样条拟合
%使用 csaps 进行平滑插值拟合
%平滑系数 p 的取值范围为 [0,1]，其中 0 表示不进行平滑处理 1表示最大平滑程度，即完全平滑处理。
%当p的值接近于1时，样条曲线会尽可能平滑地拟合数据，但可能会导致过度拟合。而当p的值接近于0时，样条曲线会更接近于原始数据，但可能会出现过度噪声。
%一般来说，p 的取值在 0.01 到 0.3 之间时效果较好。具体的取值需要根据数据的实际情况进行调整和选择。

smoothness = 0.3;% 平滑系数
xx = linspace(min(tau_total),max(tau_total),1000); % 定义拟合曲线的 x 值范围 从0到2pi生成一千个点
yy = csaps(tau_total,temp_total,smoothness,xx);

% 绘制原始数据和拟合曲线
%plot(tau_total,temp_total,'o',xx,yy)
plot(xx,yy)
hold off;