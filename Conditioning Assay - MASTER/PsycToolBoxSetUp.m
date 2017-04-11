function [status,wPtr,wDim] = PsycToolBoxSetUp()

    if Screen('Screens') > 2
        disp('Abort Set-up - not enough screens')
        status = 0;     wPtr = 0;       wDim = 0;
        return
    end
    
    status = 1;
    screenNumber = max(Screen('Screens'));
    %Screen('Preference', 'SkipSyncTests', 1);
    SetResolution(max(Screen('Screens')),800,600,60)
    [wPtr,wDim] = Screen('OpenWindow',screenNumber);
        

end