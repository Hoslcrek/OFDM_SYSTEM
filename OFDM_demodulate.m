function [out] = OFDM_demodulate(rx_sym,fft_num,totalcarrier_num)
%OFDM_DEMODULATE 此处显示有关此函数的摘要
%   此处显示详细说明
    fft_sym = fft(rx_sym,fft_num).*sqrt(fft_num);
    demap_sym = zeros(totalcarrier_num,size(fft_sym,2));
    demap_sym(totalcarrier_num/2+1:end,:) = fft_sym(1:totalcarrier_num/2,:);
    demap_sym(1:totalcarrier_num/2,:) = fft_sym(end-totalcarrier_num/2+1:end,:);
    out = demap_sym;
end

