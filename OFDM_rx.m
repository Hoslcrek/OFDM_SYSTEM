clc;
clear;
load('OFDM_tx.mat');

rxPluto = sdrrx('Pluto','RadioID','usb:0','CenterFrequency',4e8, ...
    'BasebandSampleRate',fs,'ChannelMapping',1,'OutputDataType','double','Gain',30,'SamplesPerFrame',length(zc_added_sym)*4); 

i = 10000;
count = 1;
MAX_COUNT = 30;
error_rate = zeros(1,MAX_COUNT);
while(i>0)
    % 接收
    [rx_data,datavalid,overflow] = rxPluto();
    rx_data = rx_data.';

%     rx_data = [zc_added_sym zc_added_sym];
    % 同步 
    % 算法采用这个 [1]刘彬,罗志年,彭疆.改进CAZAC序列的OFDM时频同步算法[J].计算机工程与应用,2017,53(14):76-79+98.
    
    % 符号同步
    [M,p1] = Bit_sync(rx_data,N,sk);
    
    start_loc = find(M > 0.25);
    
    % 找到两个以上的同步头
    if(length(start_loc) > 1)
        
        start = start_loc(1);
        
        % 频偏纠正
        CFO_seq = CFO(rx_data,start,N,p1,ifft_num);
        rx_seq = CFO_seq(start+N:start+N+length(tx_data)-1);
        
        % 去掉循环前缀
        del_cp_sym = Del_cp(rx_seq,ifft_num,cp_length);
        
        % OFDM解调
        fft_num = ifft_num;
        carrier_num = size(inserted_sym,1);
        de_OFDM_sym = OFDM_demodulate(del_cp_sym,fft_num,carrier_num);
        
        % 分离块状导频
        block_pilot = de_OFDM_sym(:,block_pilot_loc);
        data_mat = de_OFDM_sym(:,data_row_loc);
        
        % 信道估计与均衡
        pilot1 = (ones(size(block_pilot,1),size(block_pilot,2)) + ones(size(block_pilot,1),size(block_pilot,2)).*1i)./sqrt(2);
        % LS信道估计
        H = LS_estimate(block_pilot,pilot1,block_interval+1);
        data_balanced = data_mat./H;    %均衡
        
        % 相位纠正
        comb_pilot = data_balanced(comb_pilot_loc,:);
        data_mat = data_balanced(data_col_loc,:);
        pilot2 = (ones(size(comb_pilot,1),size(comb_pilot,2)) + ones(size(comb_pilot,1),size(comb_pilot,2)).*1i)./sqrt(2);
        h_fft=comb_pilot.*conj(pilot2);
        h_time=ifft(h_fft);
        h_fft=fft(h_time,size(data_mat,1));
        data_balanced=data_mat./h_fft;
        
        data_sym = data_balanced(:).';
        
        % QPSK解调
        QPSK_dem_data = lteSymbolDemodulate(data_sym,'QPSK','Soft');
        
        % 量化
        % quant_data = int8(quantiz(QPSK_dem_data,0,[0,1]));
        
        % 解turbo码
        data_dem = lteTurboDecode(QPSK_dem_data).';
        
  
        error_rate(count) = sum(abs(data - double(data_dem)))/length(data);
        fprintf('error rate = %f\n',error_rate(count));
        
        count = count + 1;
        if(count == MAX_COUNT + 1)
            fprintf('%d次的平均误码率为: %f\n',MAX_COUNT,mean(error_rate));
            break;
        end
    else
        fprintf('no signal\n');
    end
end

