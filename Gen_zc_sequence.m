function [ zc_seq ] = Gen_zc_sequence(number)
    N = number;
    % 找与N互为质数的r
    temp = 0;
    i = 2;
    while(i<N)
        for j = 2:i
            if(rem(i,j)==0&&rem(N,j)==0)
                break;
            end
            if(j == i)
                temp = 1;
            end
        end
        if(temp == 1)
            r = i;
            break;
        else
           i = i + 1;
        end

    end
    % 产生ZC序列
    k = (0:N-1);
    if(rem(N,2) == 1)
        zc_seq = exp(1i*pi*r.*k.*(k+1)/N);
    else
        zc_seq = exp(1i*pi*r.*k.*k/N);
    end
end

