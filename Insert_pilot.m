function [out,data_col_loc,data_row_loc,block_pilot_loc,comb_pilot_loc] = Insert_pilot(data,block_pilot_interval,comb_pilot_interval)
%INSERT_PILOT 此处显示有关此函数的摘要
%   此处显示详细说明
[data_col, data_row] = size(data);
% 块状和梳状导频生成
block_pilot_num = ceil(data_row/block_pilot_interval);
comb_pilot_num = ceil(data_col/comb_pilot_interval);
block_pilot_frame = (ones(data_col+comb_pilot_num,block_pilot_num) + ones(data_col+comb_pilot_num,block_pilot_num).*1i)./sqrt(2); % (101,40)
comb_pilot_frame = (ones(comb_pilot_num,data_row + block_pilot_num) + ones(comb_pilot_num,data_row + block_pilot_num).*1i)./sqrt(2); % (111,40)
% 块状和梳状导频位置
block_pilot_loc = (1:block_pilot_interval+1:data_row+block_pilot_num);
comb_pilot_loc = (1:comb_pilot_interval+1:data_col+comb_pilot_num);

data_col_loc = (1:1:data_col+comb_pilot_num);
data_col_loc(1:comb_pilot_interval+1:data_col+comb_pilot_num) = [];
data_row_loc = (1:1:data_row+block_pilot_num);
data_row_loc(1:block_pilot_interval+1:data_row+block_pilot_num) = [];

inserted_data = zeros(data_col+comb_pilot_num,data_row+block_pilot_num);
inserted_data(data_col_loc,data_row_loc) = data;
inserted_data(:,block_pilot_loc) = block_pilot_frame;
inserted_data(comb_pilot_loc,:) = comb_pilot_frame;
out = inserted_data;

end



