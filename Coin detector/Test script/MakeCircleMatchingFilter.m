function filter = MakeCircleMatchingFilter(filtsize, diameter)
    % initialize filter
    filter = zeros(filtsize, filtsize);
    
    % define coordinates for the center of the WxW filter
    xc = (filtsize + 1) / 2;
    yc = xc;
    
    % Use double-for loops to check if each pixel lies in the foreground of the circle
    for r = 1:filtsize
        for c = 1:filtsize
            % compute distance to center
            dist = sqrt((r - yc) ^ 2 + (c - xc) ^ 2);

            if dist <= (diameter / 2) % within
                filter(r, c) = 1;
            end
        end
    end
end