function [histEqual, histCluttered] = get_hue_hists(im, k)
    subplot(1, 2, 1); 
    hsvIm = rgb2hsv(im);
    [r, c, ~] = size(im);
    reshapedImg = reshape(hsvIm, r*c, 3); 
    hueOrig = reshapedImg(:, 1);
    h = histogram(hueOrig, k);
    title(sprintf("Histogram of Original Image with %d clusters\n", k));
    histEqual = h.Values;
    [outputImg, meanHues] = quantize_HSV(im, k);
    % Clustered Image
    hsvClustered = rgb2hsv(outputImg);
    reshapedHsv = reshape(hsvClustered, r*c, 3);
    hueClustered = reshapedHsv(:,1); 
    bins = sort(meanHues);
    subplot(1, 2, 2); 
    h = histogram(hueClustered, bins);
    title(sprintf("Histogram of Quantized Image with %d clusters\n", k));
    histCluttered = h.Values;
end