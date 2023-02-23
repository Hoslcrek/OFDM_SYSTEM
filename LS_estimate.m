function [H_LS] = LS_estimate(paldata_pilot,pilot,pilot_inv)
    %  ��״��Ƶ�ŵ�����
    [fftlen,pilot_num] = size(paldata_pilot); 
    data_num = (pilot_inv - 1)*pilot_num;
    H_ls = paldata_pilot./pilot;
    H_LS = zeros(fftlen,data_num);
    
    % % �����ڲ�
    % for k = 1:pilot_num
    %     for kk = 1:pilot_inv - 1
    %         if(k == 1)
    %             H_LS(:,(k - 1)*(pilot_inv - 1) + kk) = H_ls(:,1).*(1 - kk/pilot_inv) + H_ls(:,2).*(kk/pilot_inv);
    %         else
    %             H_LS(:,(k - 1)*(pilot_inv - 1) + kk) = H_ls(:,k - 1).*(1 - kk/pilot_inv) + H_ls(:,k).*(kk/pilot_inv);
    %         end
    %     end
    % end
    
    % ��ֵ�ڲ�
    for k = 1:pilot_num
        for kk = 1:pilot_inv - 1
            H_LS(:,(k - 1)*(pilot_inv - 1) + kk) = H_ls(:,k);
        end
    end
    
    % ��ֵ�ڲ�
    % H_LS = repmat(mean(H_ls,2),1,data_num);
end

