function [out] = Insert_cp(data,cp_length)
%INSERT_CP �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    ifftnum = size(data,1);
    inserted_sym = zeros(ifftnum + cp_length,size(data,2));
    inserted_sym(1:cp_length,:) = data(end - cp_length + 1:end,:);
    inserted_sym(cp_length + 1:end,:) = data;
    out = inserted_sym;

end

