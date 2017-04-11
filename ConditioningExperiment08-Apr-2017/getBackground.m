function background = getBackground(img,sampleFrequency,startFrame)
    
    [height , width , frames] = size(img);
    holder = zeros(numel(img(:,:,1)),1,'double');
    
    itr = 1;
    for i = startFrame:sampleFrequency:frames
        holder = holder + double(reshape(img(:,:,i),numel(img(:,:,i)),1));
        itr = itr+1;
    end
    
    background = uint8(reshape(holder,height,width)./itr);
end