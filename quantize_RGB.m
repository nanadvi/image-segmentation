function [outputImg, meanColors] = quantize_RGB(origImg, k)
    inputImg = im2double(origImg);
    [r, c, ~] = size(inputImg); 
    reshapedImg = reshape(inputImg, r*c, 3);
    init = reshapedImg(1:round(size(reshapedImg, 1)/k):end, :, :); 
    [idx, meanColors] = kmeans(reshapedImg, k, 'Start', init);
    disp(meanColors);
    outputImg_ = zeros(size(reshapedImg));
    for labels = 1:k
        outputImg_(idx == labels, 1) = meanColors(labels, 1);
        outputImg_(idx == labels, 2) = meanColors(labels, 2);
        outputImg_(idx == labels, 3) = meanColors(labels, 3);
    end
    outputImg = reshape(outputImg_, r,c,3);
end


