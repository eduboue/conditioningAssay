function CS_cue_two(wPtr,wDim)
    Screen('FillRect',wPtr,[255 255 255],[wDim(3)/2,0,wDim(3), wDim(4)]) % Left side black
    Screen('FillRect',wPtr,[0 0 0],[0,0,wDim(3)/2 wDim(4)]) % Right side white
    Screen('Flip',wPtr)
end