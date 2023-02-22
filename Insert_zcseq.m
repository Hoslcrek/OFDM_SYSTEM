function [out,sk] = Insert_zcseq(data)
%INSERT_ZCSEQ 此处显示有关此函数的摘要
%   此处显示详细说明
length = 32;
zc_seq = Gen_zc_sequence(length);
zc_seq_conj = conj(zc_seq);
zc_seq_conj_reverse = fliplr(zc_seq_conj);
sk = randi([0,1],1,length*2);
for i=1:1:length*2
    if(sk(i)==0)
        sk(i) = -1;
    end
end
seq = [zc_seq_conj_reverse,sk(1:64).*[zc_seq zc_seq_conj_reverse],zc_seq,zc_seq_conj_reverse];
out = [seq data];
end

