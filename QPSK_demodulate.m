function out = QPSK_demodulate(data_sym)
%QPSK_DEMODULATE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    len=length(data_sym);
    out(1:2:2*len)=real(data_sym);
    out(2:2:2*len)=imag(data_sym);
end

