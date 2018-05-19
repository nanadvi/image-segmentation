function [outputImg, meanHues] = quantize_HSV(origImg, k)
    hsvImg = rgb2hsv(origImg);
    [r, c, ~] = size(origImg);
    reshapedImg = reshape(hsvImg, r*c, 3);
    hue = reshapedImg(:, 1);
    [idx, meanHues] = kmeans(hue, k);
    assert(size(meanHues,1) == k);
    for label = 1:k
        hue(idx == label) = meanHues(label); 
    end
    reshapedImg(:,1,:) = hue;
    outputImg_ = reshape(reshapedImg, r, c, 3);
    outputImg = hsv2rgb(outputImg_); 
end