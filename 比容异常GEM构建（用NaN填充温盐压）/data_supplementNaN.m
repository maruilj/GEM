clc;clear;close all
%%
% 首先，指定包含.mat文件的文件夹路径
folder = 'C:\Users\mr\Desktop\无NaN值温盐压插值温盐压数据文件—resolution=10(杭州Argo1997-2022)';

% 获取文件夹中所有.mat文件的列表
file_list = dir(fullfile(folder, '*.mat'));
%%
%把4000个剖面的压力都补齐到2000、将4000个剖面的温度和盐度都按照最后一个数补齐到201个数
for i = 1:length(file_list)
    file_name = fullfile(folder, file_list(i).name);
    splitname = split(file_name,'\');
    load(file_name,'data_GOM');
    
    for j = 1:length(data_GOM)
        if isempty(data_GOM{1, j})
            continue
        end
             
%将4000个剖面的温盐压都用NaN补齐到201个数        
        n_T = length(data_GOM{1, j}.P_adj_sample_noNaN); 
        % 计算需要补齐的元素个数
        m_T = 201 - n_T;
        % 生成需要补齐的元素
        a = repmat(NaN, 1, m_T);
        b = repmat(NaN, 1, m_T);
        c = repmat(NaN, 1, m_T);
        % 将原数组和新生成的元素拼接在一起
        data_GOM{1, j}.P_adj_sample_noNaN_supplementNaN = [data_GOM{1, j}.P_adj_sample_noNaN, a];
        data_GOM{1, j}.T_adj_sample_noNaN_supplementNaN = [data_GOM{1, j}.T_adj_sample_noNaN, b];
        data_GOM{1, j}.S_adj_sample_noNaN_supplementNaN = [data_GOM{1, j}.S_adj_sample_noNaN, c];
        P_adj_sample_noNaN_supplementNaN = [data_GOM{1, j}.P_adj_sample_noNaN, a];
        T_adj_sample_noNaN_supplementNaN = [data_GOM{1, j}.T_adj_sample_noNaN, b];
        S_adj_sample_noNaN_supplementNaN = [data_GOM{1, j}.S_adj_sample_noNaN, c];
        
        % 将修改后的结构体保存回当前文件中
        save(['填充NaN后的温盐压\' file_list(i).name '.mat'], 'data_GOM')
    end  
  
end                      