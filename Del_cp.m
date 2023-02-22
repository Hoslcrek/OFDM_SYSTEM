function out = Del_cp(rx_seq,ifft_num,cp_num)
%DEL_CP 此处显示有关此函数的摘要
%   此处显示详细说明
    rx_sym = reshape(rx_seq,ifft_num+cp_num,[]);
    del_cp_sym = rx_sym(cp_num+1:end,:);
    out = del_cp_sym;
end

