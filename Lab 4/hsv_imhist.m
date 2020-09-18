function [h, s, v] = hsv_imhist(img, m, n, p, fig_title)
    HSV = rgb2hsv(img);
    [h, s, v] = imsplit(HSV);
    subplot(m, n, p);
    imhist (h, 30);
    title (strcat(fig_title, ' (H)'));
    
    subplot(m, n, p+1);
    imhist (s, 15);
    title (strcat(fig_title, ' (S)'));
    
    subplot(m, n, p+2);
    imhist (v, 15);
    title (strcat(fig_title, ' (V)'));
end