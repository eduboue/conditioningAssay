function [time , status] = captureConditioningAssay2()
    %%
    %   Initiate arduino board
        a=arduino
        disp('Arduino board initialized.')
    %%
    %   There may be a problem with reading all five pins, as it takes too
    %   long to get through each iteration of the loop. 
    %
    %   Here are the stats on five trials run reading all five pins:
    %
    %       1. Trial duration: 46.2488 sec; Number of frames collected:
    %       315 frames; frames per second = 6.8 fps.
    %
    %       2. Trial duration: 46.385 sec; Number of frames collected:
    %       312 frames; frames per second = 6.7 fps.
    %
    %       3. Trial duration: 46.2994 sec; Number of frames collected:
    %       311 frames; frames per second = 6.71 fps.
    %
    %       4. Trial duration: 46.5246 sec; Number of frames collected:
    %       316 frames; frames per second = 6.79 fps.
    %
    %       5. Trial duration: 46.4239 sec; Number of frames collected:
    %       315 frames; frames per second = 6.79 fps.
    %
    %   Here are the stats on five trials run after modifying the
    %   getArduinoStatus.m file to read only the trigger pin (D2), the CS
    %   cue alone pin (D12) and the end of trial pin (D3):
    %
    %
    %       1. Trial duration:  sec; Number of frames collected:
    %        frames; frames per second =  fps.
    %
    %       2. Trial duration:  sec; Number of frames collected:
    %        frames; frames per second =  fps.
    %
    %       3. Trial duration:  sec; Number of frames collected:
    %        frames; frames per second =  fps.
    %
    %       4. Trial duration:  sec; Number of frames collected:
    %        frames; frames per second =  fps.
    %
    %       5. Trial duration:  sec; Number of frames collected:
    %        frames; frames per second =  fps.
    %
    %%
    %   Check for zeroed pins
    %
    %   Pin code is as follows:
    %
    %     D2 = start/stop experiment
    %     D13 = moving lines
    %     D12 = CS cue alone
    %     D8  = CS cue with shock
    %     D3  = end of trial signal
    
        i = 0;
        while (readDigitalPin(a,'D2') ~= 0)
            i= i+1;
            if i == 1
                disp('Pin 2 not zeroed')
            end
        end
        
        i = 0;
        while (readDigitalPin(a,'D3') ~= 0)
            i= i+1;
            if i == 1
                disp('Pin 3 not zeroed')
            end
        end
        
        i = 0;
        while (readDigitalPin(a,'D8') ~= 0)
            i= i+1;
            if i == 1
                disp('Pin 8 not zeroed')
            end
        end
        
        i = 0;
        while (readDigitalPin(a,'D12') ~= 0)
            i= i+1;
            if i == 1
                disp('Pin 12 not zeroed')
            end
        end
        
        i = 0;
        while (readDigitalPin(a,'D13') ~= 0)
            i= i+1;
            if i == 1
                disp('Pin 13 not zeroed')
            end
        end
        disp('All pins on Arduino zeroed')
     
     %%
     % Initialize some variables
       time = [];
       status = [];
     %%
     % Initiate experiment
     disp('Waiting to initialize experiment')
     while (readDigitalPin(a,'D2') == 0)
         i=6;
     end
     
    disp('Experiment running')
    tic
    while (readDigitalPin(a,'D2') == 1)
        status = [status ; getArduinoStatus(a)];
        time = [time;toc];
    end
    
    disp('Experiment complete')
    
    close all, clc
        
end