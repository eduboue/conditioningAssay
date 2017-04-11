function centroids = trackConditionedTrial(img,background,threshold)

    centroids = [];
    [height , width , frames] = size(img);
    
    for i = 1:frames
        frame = im2bw(imabsdiff(background,img(:,:,i)),threshold);
        rp=regionprops(frame);
        LargestArea = getMaxArea(rp);
        centroids = [centroids ; rp(LargestArea).Centroid(1) , rp(LargestArea).Centroid(2)];
    end

end


function LargestArea = getMaxArea(rp)
    s=[]; 

    for i=1:length(rp) 
        s = [s , rp(i).Area];
    end

    LargestArea = find(s==max(s));

end