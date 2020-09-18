function out = ccomputeDistances(img, img2)
    hsv1 = rgb2hsv(img);
    hsv2 = rgb2hsv(img2);
    
    [h1, s1, v1] = imsplit(hsv1);
    [h2, s2, v2] = imsplit(hsv2);
    
    h1_count = histcounts(h1, 30);
    h2_count = histcounts(h2, 30);
    
    s1_count = histcounts(s1, 15);
    s2_count = histcounts(s2, 15);

    v1_count = histcounts(s1, 15);
    v2_count = histcounts(s2, 15);
    
    
    manhattan = sum(abs(h1_count - h2_count)) + sum(abs(s1_count - s2_count)) + sum(abs(v1_count - v2_count));
    euclidean = sum(abs(h1_count - h2_count).^2) + sum(abs(s1_count - s2_count).^2) + sum(abs(v1_count - v2_count).^2);
    histogram_intersect = sum(min(h1_count, h2_count), 'all') / min(sum(h1_count, 'all'), sum(h2_count, 'all'))/2 + ...
        sum(min(s1_count, s2_count), 'all') / min(sum(s1_count, 'all'), sum(s2_count, 'all'))/4 + ...
        sum(min(v1_count, v2_count), 'all') / min(sum(v1_count, 'all'), sum(v2_count, 'all'))/4;
    
    out = [manhattan, euclidean, histogram_intersect];
end