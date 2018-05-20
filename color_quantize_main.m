function color_quantize_main
    input = imread('fish.jpg');
    % Quantize RGB
    color_quantize_main_helper(input, 5);
end

function color_quantize_main_helper(im, k)
    subplot(1,2,1);
    % Quantize RGB
    [outputImg, meanColors] = quantize_RGB(im, k);
    % Display the image
    imshow(outputImg);
    title(sprintf("Quantized rgb with %d clusters\n", k)); 
    % Calculate the SSD
    rgbError = compute_quantization_error(im, outputImg); 
    fprintf("rgb SSD error: %f with %d clusters", rgbError, k);
    % Quantize HSV
    [outputImg, meanHue] = quantize_HSV(im, k);
    % Display the image
    subplot(1,2,2);
    imshow(outputImg);
    title(sprintf("Quantized hsv with %d clusters", k));
    % Calculate the SSD
    hsvError = compute_quantization_error(im, outputImg); 
    fprintf("hsv SSD error: %f with %d clusters\n", hsvError, k);
end