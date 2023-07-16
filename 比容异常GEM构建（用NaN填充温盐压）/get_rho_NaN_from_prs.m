function [integral_tau,rho,c] = get_rho_NaN_from_prs(filename,prs_start,prs_stop)
%GET_TAU_FROM_PRS 此处显示有关此函数的摘要
%计算设定区间的tauindex和密度 声速
%   此处显示详细说明
    dp = 10; %压力划分在*左右
    load(filename, 'data_GOM');
%%
%排除无数据文件干扰
    integral_tau = [];
    rho = {};
    c = {};
%%
    pres = {};
    temp = {};
    psal = {};
    k = 1;
    for i = 1:length(data_GOM)
        if isempty(data_GOM{1, i})
            continue
        end
 
        pres{k} = data_GOM{1, i}.P_adj_sample_noNaN_supplementNaN(prs_start/dp + 1 : prs_stop/dp+1);
        temp{k} = data_GOM{1, i}.T_adj_sample_noNaN_supplementNaN(prs_start/dp + 1 : prs_stop/dp+1);
        psal{k} = data_GOM{1, i}.S_adj_sample_noNaN_supplementNaN(prs_start/dp + 1 : prs_stop/dp+1);
   
        k = k+1;
    end
    %%
    %利用GSW工具箱求出202212中所有（63个）经验声速以及密度的向量存到cell中
    for q = 1:length(pres)
        rho{q} = gsw_rho(psal{q}, temp{q}, pres{q});%密度
        c{q} = gsw_sound_speed(psal{q}, temp{q}, pres{q});%经验声速
    end

    %%
    %计算积分求tau
    g = 9.8;
    %integral_tau = 0;
    for m = 1:length(pres)
        dtau(m,:) = 2./(g.*rho{m}.*c{m}).*dp; %dp直接乘了
        integral_tau(m) = sum(dtau(m,:).*1e4);   
    end
end