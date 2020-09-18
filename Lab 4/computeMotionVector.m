function out = computeMotionVector (frame_prev, frame_curr, p, q, k)
    diff = inf;
    flag = 0;
    
    for row = p-k:p+k
        for col = q-k:q+k
            try
                diff_temp = mean(abs(double(frame_curr(p:p+15, q:q+15)) - ...
                    double(frame_prev(row:row+15, col:col+15))), 'all');
            catch 
                continue;
            end
            if (diff_temp < diff)
                flag = 1;
                diff = diff_temp;
                dx = col - q;
                dy = row - p;
            end
            
        end
    end
    if flag == 1
        out = [diff, dx, dy];
    else
        out = [-1, -1, -1];
    end
    

end