%%
%   Setup psychtoolbox and ardunio

[~,wPtr,wDim] = PsycToolBoxSetUp

if ispc
    a = arduino('com3', 'uno');
elseif ismac
    a=arduino();
end

while (true)
tic

    while (round(toc) < 30)
            movingLines(wPtr,8,1,wDim)
    end
    Screen('FillRect', wPtr, [255 255 255])
    Screen('Flip',wPtr);
    
    while (round(toc) < 45)
    end
    
    while (round(toc) < 75)
            movingLines(wPtr,8,-1,wDim)
    end
end