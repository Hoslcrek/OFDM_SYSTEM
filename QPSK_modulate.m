function out = QPSK_modulate(data)
%QPSK_MODULATE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    data = double(data);
    table=exp(1i*[-3*pi/4 -pi/4 pi/4 3*pi/4]); 
    table=table([0 3 1 2]+1);     %���ױ���
    data_in=reshape(data,2,length(data)/2);
    out=table([2 1]*data_in+1);  
end

