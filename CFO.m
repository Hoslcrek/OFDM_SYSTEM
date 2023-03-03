function f_fixed_data = CFO(rx_data,start,N,p1)
%CFO 此处显示有关此函数的摘要
%   此处显示详细说明
    % 纠正小数频偏
    fix_f1 = angle(p1(start))/pi;
    coarse_fix_seq = rx_data.*exp(-1i*2*pi*fix_f1*(1:length(rx_data))./(N));
    coarse_fix_seq_conj = conj(coarse_fix_seq);
    
    Fd_est = sum(coarse_fix_seq_conj(start-N/4:start-1).*coarse_fix_seq(start+N-N/4:start+N-1));
    fix_f2 = angle(Fd_est)/(2*pi);
    FFO_seq = coarse_fix_seq.*exp(-1i*2*pi*(fix_f2)*(1:length(coarse_fix_seq))./(N));
    
    FFO_seq_conj = conj(FFO_seq);   
    
    % 有错误，修改中
    % 纠正整数频偏
    Zg_est = zeros(1,N/4);
    zc_seq = Gen_zc_sequence(N/4);
    for i=0:1:N/4-1
        zc_seq_cir = circshift(zc_seq,i);
        Zg_est_temp = sum((FFO_seq_conj(start+N/2:start+N/2+N/4-1)+FFO_seq_conj(start+N-1:-1:start+N-N/4)).*zc_seq_cir(1:N/4));
        Zg_est(i+1) = abs(Zg_est_temp)^2;
    end
    [~,fix_f3] = max(Zg_est);
    fix_f3 = fix_f3 - 1;
    IFO_seq = FFO_seq.*exp(-1i*2*pi*4*(fix_f3)*(1:length(FFO_seq))./(N));

    f_fixed_data = IFO_seq;
    
    fprintf('频偏估计值%f\n',4*fix_f3 + fix_f2 + fix_f1);
end

