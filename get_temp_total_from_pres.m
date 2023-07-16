function [temp_total] = get_temp_total_from_pres(pres_concrete)
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
            if isempty(data_GOM{1,j})
                continue
            end
            
            % 判断数组A中是否包含pres_concrete(dbar)
            if ismember(pres_concrete, data_GOM{1,j}.P_adj_sample)
                    % 找出值为 10 的元素索引
                    index = find(data_GOM{1,j}.P_adj_sample == pres_concrete);
              
                    % 找出最接近 10 的元素索引
                    %[~,index] = min(abs((data_GOM{1,j}.P_adj_sample)- pres_concrete));

                    %获取每个剖面压力为10时的温度数据存进temp_total
                    temp_total = [temp_total,data_GOM{1,j}.T_adj_sample(index)];
            else
                    temp_total = [temp_total,NaN];
            end
    end
end

end