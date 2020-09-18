clear variables
close all
clc
%% Part 1
video = VideoReader('Video.mp4');
first_frame = imresize(rgb2gray(readFrame(video)), 0.25);
second_frame = imresize(rgb2gray(readFrame(video)), 0.25);


MV = [];

for row = 1:16:180-1
    for col = 1:16:320-1
        temp_MV = computeMotionVector(first_frame, second_frame, row + 15, col + 15, 7);
        if temp_MV(1) ~= -1
            MV = [MV;[temp_MV, row, col]];
        end
    end
end

entropy_diff = []; 
entropy_DPCM = [];
DPCM = [];
all_dx_dy = [];

for row = 1:16:180-1
    for col = 1:16:320-1
        try
            diff(row:row+15, col:col+15) = first_frame(row:row+15, col:col+15) - ...
                second_frame(row:row+15, col:col+15);
            entropy_diff = [entropy_diff;myEntropy(diff(row:row+15, col:col+15))];
            dx_dy = MV((MV(:,4) == 1) & (MV(:, 5) == 1), 2:3);
            all_dx_dy = [all_dx_dy;dx_dy];
            DPCM(row:row+15, col:col+15) = first_frame(row:row+15, col:col+15) - ...
                second_frame(row+dx_dy(1):row+15+dx_dy(1), col+dx_dy(2):col+15+dx_dy(2));
            entropy_DPCM = [entropy_DPCM;myEntropy(uint8(DPCM(row:row+15, col:col+15)))];
        catch
            continue;
        end
    end
end

entropy_DPCM = mean(entropy_DPCM, 'all');
entropy_difference = mean(entropy_diff);

%% Part 2
images = dir ('DogImages/*.jpg');
num_files = length(images);
distances_all = [];


figure(1);
set(gcf, 'Position', [100, 100, 1500, 900]);

figure(2);
set(gcf, 'Position', [100, 100, 1500, 900]);


for i = 1:num_files
    file_name = images(i).name;
    img = imread(strcat('DogImages/', file_name));
    if (i == 1)
       query_img =  img;
    else
        figure (1);
        hsv_imhist(img, 10, 3, ((i-2)*3)+1, file_name);
        
        distances_all = [distances_all; [i, computeDistances(query_img, img)]];
    end
    
    figure (2);
    subplot (3, 4, i);
    imshow (img);
    title (i);
end

%Using first distance as query



%Using last img
block_width = floor (size(img, 2) / 4);
block_length = floor (size(img, 1) / 3);
distances_blocks = [];

figure(3);
set(gcf, 'Position', [100, 100, 1200, 900]);

figure(4);
set(gcf, 'Position', [100, 100, 1200, 900]);

counter = 0;
for row = 1:block_width:size(img, 1) - block_width
    for col = 1:block_length: size(img, 2) - block_length
        if (row == 1 && col == 1)
           orig_block = img(row:row+block_width, col:col+block_length, :);
        else
            distances_blocks = [distances_blocks; [row, col, ...
            computeDistances(img(row:row+block_width, col:col+block_length, :), orig_block)]];
            figure (3);
            hsv_imhist(img(row:row+block_width, col:col+block_length, :), 8, 3, (counter*3)+1, '');

            figure (4);
            subplot (3, 3, counter+1);
            imshow (img(row:row+block_width, col:col+block_length, :));
            title (counter + 1)
            counter = counter + 1;
        end
        
    end
end


















