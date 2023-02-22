function out = QPSK_demodulate(data_sym)
%QPSK_DEMODULATE 此处显示有关此函数的摘要
%   此处显示详细说明
    len=length(data_sym);
    out(1:2:2*len)=real(data_sym);
    out(2:2:2*len)=imag(data_sym);
end

