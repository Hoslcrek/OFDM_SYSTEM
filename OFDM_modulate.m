function out = OFDM_modulate(data,ifft_num)
%OFDM_MODULATE 此处显示有关此函数的摘要
%   此处显示详细说明
    inserted_sym = data;
    [inserted_bits_col,inserted_bits_row] = size(inserted_sym);
    ifft_map=zeros(ifft_num,inserted_bits_row);

    % 映射到两边，减小峰均比
    ifft_map(1:inserted_bits_col/2,:) = inserted_sym(inserted_bits_col/2 + 1:end,:);
    ifft_map(end - inserted_bits_col/2 + 1:end,:) = inserted_sym(1:inserted_bits_col/2,:);

    ifft_sym=ifft(ifft_map,ifft_num).*sqrt(ifft_num);
    out = ifft_sym;
end

