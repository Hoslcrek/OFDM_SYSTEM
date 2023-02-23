function [  ] = DrawFFT( x, Fs )
% DrawFFT 对输入信号进行快速傅里叶变换
% 输入参数：x ：输入信号；   Fs：采样频率
    L = length(x);
    NFFT = 2^nextpow2(L);          		%确定FFT变换的长度
    y = fft(x, NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);	%频率向量
    plot(f, 2*abs(y(1:NFFT/2+1)));		%绘制频域图像
    title('幅度谱');
    xlabel('Frequency (Hz)');
    ylabel('|y(f)|');
end