function f_fixed_data = CFO(rx_data,start,N,p1,fft_num)
%CFO 此处显示有关此函数的摘要
%   此处显示详细说明
    % 纠正小数频偏
    rx_data_conj = conj(rx_data);
    fix_f1 = angle(p1(start))/pi;

    Fd_est = sum(rx_data_conj(start-N/4+1:start).*rx_data(start+N-N/4+1:start+N));
    fix_f2 = angle(Fd_est)/(2*pi);

    FFO_seq = rx_data.*exp(-1i*2*pi*(fix_f2+fix_f1)*(1:length(rx_data))./(fft_num));

    % 纠正整数频偏
    Zg_est = zeros(1,N/4);
    zc_seq = Gen_zc_sequence(N/4);
    for i=0:1:N/4-1
        zc_seq_cir = circshift(zc_seq,-i);
        Zg_est_temp = sum((rx_data_conj(start+N/2:start+N/2+N/4-1)+rx_data_conj(start+N:-1:start+N-N/4+1)).*zc_seq_cir(1:N/4));
        Zg_est(i+1) = abs(Zg_est_temp)^2;
    end
    [~,fix_f3] = max(Zg_est);
    fix_f3 = fix_f3 - 1;
    IFO_seq = rx_data.*exp(-1i*2*pi*4*(fix_f3)*(1:length(FFO_seq))./(fft_num));
    f_fixed_data = IFO_seq;
end

