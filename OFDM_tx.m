% % Turbo编码->QPSK->插导频->OFDM调制->插CP->同步头->发送
% clc;
% clear;
% 
% fs = 20e6;
% 
% % lteTurboEncode特定数量
% data_num = 2016;
% data = randi([0,1],1,data_num);
% 
% % (6060,1)
% turbo_mod = lteTurboEncode(data).';
% 
% symbol = lteSymbolModulate(turbo_mod,'QPSK');
% 
% col = 101;
% row = 30;
% block_sym = reshape(symbol,col,row);
% 
% % 插入导频
% block_interval = 3;
% comb_interval = 10;
% [inserted_sym,data_col_loc,data_row_loc,block_pilot_loc,comb_pilot_loc]= Insert_pilot(block_sym,block_interval,comb_interval);
% 
% % OFDM
% ifft_num = 512;
% OFDM_sym = OFDM_modulate(inserted_sym,ifft_num);
% 
% % 插入循环前缀
% cp_length = 72;
% cp_sym = Insert_cp(OFDM_sym,cp_length);
% 
% tx_data = cp_sym(:).';
% figure(1);
% DrawFFT(tx_data,fs);
% 
% % 插入同步序列
% N=32*4;
% sk_len = 64;
% [zc_added_sym,sk] = Insert_zcseq(tx_data);

load('OFDM_tx.mat');

txPluto = sdrtx('Pluto','RadioID','usb:0','CenterFrequency',4e8, ...
    'BasebandSampleRate',fs,'ChannelMapping',1,'Gain',0);

% 发送
modSignal = zc_added_sym.';
txPluto.transmitRepeat(modSignal);