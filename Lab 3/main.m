%% Part 1.1, 1.2 DCT Transform of Various Sized Windows
Grey_M = imread ('Lenna.png');

figure (1);

dct_full = dct2(Grey_M);
subplot(2,2,1);
plot(log(abs(dct_full(:))));
title ('Full DCT');

subplot(2,2,2);
four_window = Grey_M(50:53, 50:53);
dct_4 = dct2(four_window);
plot (log(abs(dct_4(:))));
title ('4x4 Window');

subplot(2,2,3);
eight_window = Grey_M(50:57, 50:57);
dct_8 = dct2(eight_window);
plot (log(abs(dct_8(:))));
title ('8x8 Window');

subplot (2,2,4);
sixteen_window = Grey_M(50:81, 50:81);
dct_16 = dct2(sixteen_window);
plot (log(abs(dct_16(:))));
title ('16x16 Window');

%% Part 1.3.1 Zeroing DC Component, Low Freq, High Freq
dct_4_copy = dct_4;
dct_4_copy(1) = 0;
idct_4_zeroed = idct2(dct_4_copy);


dct_4_copy = dct_4;
dct_4_copy(end-4:end) = 0;
idct_4_high = idct2(dct_4_copy);

dct_4_copy = dct_4;
dct_4_copy(1:5) = 0;
idct_4_low = idct2(dct_4_copy);

%% 1.5 Split into 8x8 Blocks

for row = 1:8:256
    for col = 1:8:256
        figure (2);
        dct_8_blocks(row:row+7, col:col+7) = dct2(M(row:row+7, col:col+7));
        if ((((row-1)/8)+1) + ((col-1)/8)*32) <= 16
            subplot (4, 4, ((((row-1)/8)+1) + ((col-1)/8)*32));
            to_plot = dct_8_blocks(row:row+7, col:col+7);
            plot (log(abs(to_plot(:))));
        end
    end
end

%% 1.6 Quantization and Reverse Quantization
figure (3);
quantization_table = double([16 11 10 16 24 40 51 61; 
    12 12 14 19 26 58 60 55; 
    14 13 16 24 40 57 69 56; 
    14 17 22 29 51 57 80 62; 
    18 22 37 56 68 109 103 77; 
    24 35 55 64 81 104 113 92; 
    49 64 78 87 103 121 120 101; 
    72 92 95 98 112 100 103 99]);



for row = 1:8:256
    for col = 1:8:256
        figure (3);
        quantized(row:row+7, col:col+7) = round(dct_8_blocks(row:row+7, col:col+7) ./ quantization_table);
        reverse_quantize(row:row+7, col:col+7) = quantized(row:row+7, col:col+7) .* quantization_table;
    end
end

MSE = immse (uint8(reverse_quantize), M);
SNR = snr (reverse_quantize, double(M));
PSNR = psnr (reverse_quantize, double(M));

%% Part 2.1 - 2.4 Calculating Entropy between Video Frames
video = VideoReader('keypad.avi');
entropy = zeros ([1 9]);
current_frame = rgb2gray(readFrame(video));

for i = 2 : 10
    previous_frame = current_frame;
    current_frame = rgb2gray(readFrame(video));
    entropy(i-1) = myEntropy(uint8(abs(double(current_frame) - double(previous_frame))));
    figure (4);
    if (i < 6)
        subplot (5,3,((i-2)*3 + 1));
        imshow (previous_frame);
        title ('Previous Frame');
        
        subplot (5,3,((i-2)*3) + 2);
        imshow (current_frame);
        title ('Current Frame');
        
        subplot (5,3,((i-2)*3) + 3);
        imshow (abs(double(current_frame) - double(previous_frame)));
        title ('Difference');
    end
    
end


%Bits per pixel initially was 8 bits. Average of entropy of the difference
%between frames is 2.6315 for a resulting compression ratio of 3.0401

mode_1 = horzcat(current_frame(:, 1), current_frame(:, 2:end) - previous_frame(:, 1:end-1));
mode_2 = vertcat(current_frame(1, :), current_frame(2:end, :) - previous_frame(1:end-1, :));

for i = 1: video.Height
    for j = 1: video.Width
        if(i == 1 || j == 1)
            mode_3(i, j) = previous_frame(i, j);
        else
            mode_3(i, j) = current_frame(i, j) - previous_frame(i - 1, j - 1);
        end
    end
end

for i = 1: video.Height
    for j = 1: video.Width
        if(i == 1 || j == 1)
            mode_4(i, j) = previous_frame(i, j);
        else
            mode_4(i, j) = current_frame(i, j) + previous_frame(i, j - 1) + ...
                current_frame(i - 1, j)- previous_frame(i - 1, j - 1);
        end
    end
end

figure (5);
subplot(2,2,1);
histogram(mode_1);
title ('Mode 1');

subplot(2,2,2);
histogram(mode_2);
title ('Mode 2');

subplot (2,2,3);
histogram(mode_3);
title ('Mode 3');

subplot (2,2,4);
histogram(mode_4);
title ('Mode 4');

