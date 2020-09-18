I = imread('lena.jpg');

I_gray = rgb2gray(I); %Only shows intensity values, no longer 3 values per pixel (RGB)

I_bw = imbinarize(I_gray, 0.5); %Changes image to binary with threshold parameter

imshow(I_bw);