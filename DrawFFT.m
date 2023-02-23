function [  ] = DrawFFT( x, Fs )
% DrawFFT �������źŽ��п��ٸ���Ҷ�任
% ���������x �������źţ�   Fs������Ƶ��
    L = length(x);
    NFFT = 2^nextpow2(L);          		%ȷ��FFT�任�ĳ���
    y = fft(x, NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);	%Ƶ������
    plot(f, 2*abs(y(1:NFFT/2+1)));		%����Ƶ��ͼ��
    title('������');
    xlabel('Frequency (Hz)');
    ylabel('|y(f)|');
end