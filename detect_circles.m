function [centers] = detect_circles(im, radius, useGradient)
    %centers = imfindcircles(im, radius);
    %viscircles(centers, im, useGradient,'b');
    [r, c, ~] = size(im);
    %X = reshape(im,[r*c, 3]);
    gimg = rgb2gray(im);
    
    %a = size(im);
    %b = size(X);
    bw = edge(gimg, 'Canny');
    %[numEdge, ~] = size(bw);
    %bw_reshaped = reshape(bw, r, c, 3);
    


    %aggregate all the edges with 0 pixel values
    [x, y] = find(bw);
    [numEdge, ~] = size(find(bw));

    %[szx, ~] = size(x);
    %[szy, ~] = size(y);
    
    Accumulator = zeros(r, c);
 
            %[Gmag,Gdir] = imgradient(x(i),y(j));
            %gradient lines must be changed
            
    if useGradient == 0
        for i=1:numEdge
            for theta = 0:360

                a = x(i) - (radius * cos(deg2rad(theta)));
                b = y(i) + (radius * sin(deg2rad(theta)));
                
                roundA = round(a);
                roundB = round(b);
                
                if roundA > 0 && roundB > 0 && roundA <= r && roundB <= c
                    Accumulator(roundA, roundB) = Accumulator(roundA, roundB) + 1;
                end

            end
        end
    end 
    
    
    if useGradient == 1
        [Gx, Gy] = imgradient(gimg);
        %[Gmag, Gdir] = imgradient(Gx, Gy);
        theta = atan2(Gy, Gx);
        for k=1:numEdge
            
            thetaopp = theta(x(k), y(k));
            
            for l = 1:numEdge
                 
                    %theta = atan(-j/i);
                    %thetaopp = theta + pi/2;
                    
                a = x(l) - (radius * cos(thetaopp));
                b = y(l) + (radius * sin(thetaopp));
                    
%             aopp = x(k) - (radius * cos(thetaopp));
%             bopp = y(k) - (radius * sin(thetaopp));
            
                roundA = round(a);
                roundB = round(b);
                    
%             roundAopp = round(aopp);
%             roundBopp = round(bopp);

                if roundA > 0 && roundB > 0 && roundA <= r && roundB <= c % && roundAopp > 0 && roundBopp > 0 && roundAopp <= r && roundBopp <= c
                    Accumulator(roundA, roundB) = Accumulator(roundA, roundB) + 1;
                % Accumulator(roundAopp, roundBopp) = Accumulator(roundAopp, roundBopp) + 1;
                end
            end
        end
    end
    
    Accumulator = Accumulator / max(Accumulator(:));
    [B, A] = find(Accumulator > 0.95);
    centers = zeros(length(A), 2);

    centers(:,1)=A;
    centers(:,2)=B;
    %thresh = max(max(Accumulator)) - 3;
    %for i=1:r
    %    for j=1:c
    %        if Accumulator(i, j) > thresh
    %            centers(count, 2) = i;
    %            centers(count, 1) = j;
    %            count = count + 1;
    %        end
    %    end
    %end
    %coordinates of the center with highest votes
    %[rowMax, colMax] = find(ismember(Accumulator, max(Accumulator(:))));
    
    %plot(rowMax, colMax, '*');
    
    %localmaxima on entire matrix
    %maxVote = Accumulator(rowMax, colMax);
    
    %AA = reshape(Accumulator, [r, c], 3);
    %ModifiedAccumulator = Accumulator / maxVote;
    

    %imshow(im);
    %centers = find(Accumulator(:) > 0.9 * maxVote);
    %imshow(im);

    [len, ~] = size(centers);
    %imagesc(im);
    imagesc(im);
    title('Radius = 10');
    viscircles(centers,repmat(radius,len,1));
    axis equal;
    
    %imshow(Accumulator, []);
    

    
    %imshow(bw);
end