function [time , status, img] = captureConditioningAssay(gui)
    %%
    %%
    %   There may be a problem with reading all five pins, as it takes too
    %   long to get through each iteration of the loop. 
    %
    %   Below are the stats on five trials run reading all five pins.
    %   This is without the camera running, and with the GUI not activated.
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
    %   getArduinoStatus.m file to read only the trigger pin (D2), the
    %   moving lines pin (D13) and the end of trial pin (D3):
    %
    %
    %       1. Trial duration: 46.4677 sec; Number of frames collected:
    %       343 frames; frames per second = 7.3815 fps.
    %
    %       2. Trial duration: 46.2307 sec; Number of frames collected:
    %       337 frames; frames per second = 7.2895 fps.
    %
    %       3. Trial duration: 46.3013 sec; Number of frames collected:
    %       341 frames; frames per second = 7.3648 fps.
    %
    %       4. Trial duration: 46.4431 sec; Number of frames collected:
    %       334 frames; frames per second = 7.1916 fps.
    %
    %       5. Trial duration: 46.4504 sec; Number of frames collected:
    %       341 frames; frames per second = 7.3412 fps.
    %
    %   So... limiting the number of pins being read makes a small, but
    %   pretty insignificant difference.
    %%
    % Initiate the camera.
    % This is for Mac, and it will change once I begin using windows based
    % PC.
    
        ADAPTOR_NAME = 'macvideo';
        ADAPTOR_FORMAT = 'MONO8_640x480';
        DEVICE_ID = 2;

        vid = videoinput(ADAPTOR_NAME, DEVICE_ID, ADAPTOR_FORMAT);
        
        disp('Point Grey camera initialized.')
        
    %  Set basic features of the camera
    % The basic strategy is to set up a camera that triggers 1 frame, trigger,
    % collect that frame, trigger again, collect that frame ...
        set(vid,'FramesPerTrigger',1)
        set(vid,'TriggerRepeat',Inf)
        triggerconfig(vid,'manual')
        
        disp('Configuration of Point Grey camera complete.')
    
    %   Allocate memory for image data 
    
        disp('Allocating memory for image data.')
    % This is also probably temporary.
    % I get around 330 frames per trial, so I'll allocate 400 frames, and
    % write to disk at each iteration.
        img=zeros(480,640,400,'uint8');
        start(vid)
    %%
    %   Make a directory on the Desktop to save the data to.
        directory = strcat('~/Desktop/','ConditioningExperiment',date);
        mkdir(directory)
    %%
    %   Initiate arduino board
        disp('Locating Arduino board.')
        a=arduino
        writeDigitalPin(a,'D11',0)
        disp('Arduino board initialized.')
    %%
    %   Check for zeroed pins
    %
    %   Pin code for the arduino is as follows:
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
     %  Set up GUI
     if gui == 1
         hFig = figure;
         set(hFig, 'Position', [600, 600, 600, 600]);
         set(hFig,'MenuBar','none','ToolBar','none');
         set(hFig,'color','white');
         movegui(hFig,'center');
         subplot(2,1,1); 
            scatter([1,2,3,4],[0,0,0,0],400,'FillColor','blue'); 
                ylim([-1 1]); 
                xlim([0 5]);
                axis off;
          uicontrol('Style','text',...
              'String','Moving Lines',...
              'FontSize',15,...
              'backgroundcolor','white',...
              'position',[135 380 70 30])
          uicontrol('Style','text',...
              'String','CS',...
              'FontSize',15,...
              'backgroundcolor','white',...
              'position',[225 380 70 30])
          uicontrol('Style','text',...
              'String','Shock',...
              'FontSize',15,...
              'backgroundcolor','white',...
              'position',[323 380 70 30])
          uicontrol('Style','text',...
              'String','Trial End',...
              'FontSize',15,...
              'backgroundcolor','white',...
              'position',[420 380 70 30])

          experimentStatus = uicontrol('Style','text',...
              'String','Waiting for cue to start',...
              'FontSize',25,...
              'backgroundcolor','red',...
              'position',[200 100 200 100])

          drawnow
     end
     %}
        
     %%
     % Initialize some variables
       time = [];
       status = [];
     %%
     % Wait for cue to initiate experiment
     disp('Waiting to initialize experiment')
     while (readDigitalPin(a,'D2') == 0)
         i=6;
     end
    
     %%
     % Excecute experiment
    disp('Experiment running')
    tic
    itr = 0;
    trialNumber = 1;
    disp('Trial 1')
    while (readDigitalPin(a,'D2') == 1)
        
        
        
        itr = itr + 1;
        if gui == 1
            experimentStatus = uicontrol('Style','text',...
              'String','Experiment in progress',...
              'FontSize',25,...
              'backgroundcolor','green',...
              'position',[200 100 200 100])
        end
        
        % Trigger and get image from Camera
        trigger(vid);
        img(:,:,itr) = getdata(vid);
        
        % Get status of virtual environment from the 'master' computer.
        status = [status ; getArduinoStatus(a)];
        time = [time;toc];
        
        if gui == 1
            if getArduinoStatus(a) == 1
                scatter([1,2,3,4],[0,0,0,0],400,'FillColor','blue');
                hold on
                scatter([1],[0],400,'FillColor','green');
                ylim([-1 1]); 
                xlim([0 5]);
                axis off;
                drawnow
            elseif getArduinoStatus(a) == 2
                scatter([1,2,3,4],[0,0,0,0],400,'FillColor','blue');
                hold on
                scatter([2],[0],400,'FillColor','green');
                ylim([-1 1]); 
                xlim([0 5]);
                axis off;
                drawnow
            elseif getArduinoStatus(a) == 3
                scatter([1,2,3,4],[0,0,0,0],400,'FillColor','blue');
                hold on
                scatter([3],[0],400,'FillColor','green');
                ylim([-1 1]); 
                xlim([0 5]);
                axis off;
                drawnow
            elseif getArduinoStatus(a) == 4
                scatter([1,2,3,4],[0,0,0,0],400,'FillColor','blue');
                hold on
                scatter([3],[0],400,'FillColor','green');
                ylim([-1 1]); 
                xlim([0 5]);
                axis off;
                drawnow
            else
                scatter([1,2,3,4],[0,0,0,0],400,'FillColor','blue');
                ylim([-1 1]); 
                xlim([0 5]);
                axis off;
                drawnow
            end
        end
        
        %%
        %   Save image data to disk as .mat file after each experiment.
        
        
        if readDigitalPin(a,'D8') == 1
            disp('Digital Pin 8 active')
            writeDigitalPin(a,'D11',1)
            disp('Hault master')
            save(strcat(directory,'/trial',num2str(trialNumber),'.mat'),'img','time','status');
            itr = 0;
            trialNumber = trialNumber + 1;
            img=zeros(480,640,400,'uint8');
            time = [];
            status = [];
            pause(5)
            writeDigitalPin(a,'D11',0)
            disp('Continue master')
            pause(0.1)
            disp(strcat('Trial',num2str(trialNumber) ))
            tic
        end
        
    end
    
    if gui == 1
        experimentStatus = uicontrol('Style','text',...
              'String','Experiment completed',...
              'FontSize',25,...
              'backgroundcolor','red',...
              'position',[200 100 200 100])
    end
    
    disp('Experiment complete')
    stop(vid)
    %close all, clc
        
end