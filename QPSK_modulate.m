function out = QPSK_modulate(data)
%QPSK_MODULATE 此处显示有关此函数的摘要
%   此处显示详细说明
    data = double(data);
    table=exp(1i*[-3*pi/4 -pi/4 pi/4 3*pi/4]); 
    table=table([0 3 1 2]+1);     %格雷编码
    data_in=reshape(data,2,length(data)/2);
    out=table([2 1]*data_in+1);  
end

