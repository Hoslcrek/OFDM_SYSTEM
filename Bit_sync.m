function [position,p1] = Bit_sync(rx_data,N,sk)
%STO 此处显示有关此函数的摘要
%   此处显示详细说明
    rx_data_conj = conj(rx_data);
    p1 = zeros(1,length(rx_data));
    p2 = zeros(1,length(rx_data));
    R_E = zeros(1,length(rx_data));
    M = zeros(1,length(rx_data));
    for i=1:1:length(rx_data)-N
        p1(i) = sum(rx_data_conj(i:N/2+i-1).*sk(1:N/2).*rx_data(i+N/2:i+N-1),"all");
        p2(i) = sum(rx_data(i:N/2+i-1).*rx_data(i+N-1:-1:i+N/2).*sk(1:N/2),"all");
        R_E(i) = sum(1/2*(abs(rx_data(i:i+N-1))).^2);
        M(i) = abs(p1(i))*abs(p2(i))/R_E(i)^2;
    end
    position = M;
    figure(30);
    plot(abs(p1),'bo');
    figure(31);
    plot(abs(p2),'bo');
end

