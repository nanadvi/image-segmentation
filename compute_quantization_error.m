function [error] = compute_quantization_error(origImg, quantizedImg)
    orig = im2double(origImg);
    quan = im2double(quantizedImg);
    error = (norm(orig(:)-quan(:),2).^2); 
end