function [centers] = detectCircles(im, radius, useGradient)
    [r, c, ~] = size(im);
    % binarize the image
    gim = rgb2gray(im);
    [dx, dy] = imgradient(gim);
    theta = atan2(dy, dx); 
    % Canny edge with automatic threshold
    edg = edge(gim, 'canny');
    [Ex, Ey] = find(edg);
    H = zeros(size(edg));
    if useGradient == 1 
        for i = 1:size(Ex,1)
            t = theta(i); 
            a = round(Ex(i) - radius * cos(t));
            b = round(Ey(i) + radius * cos(t));
            if (a > 0 && a <= size(H, 1) && b > 0 && b <= size(H,2))
                    H(a,b) = H(a,b) + 1;
            end
        end 
    end
end