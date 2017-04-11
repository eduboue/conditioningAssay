function runTrainingTrial()

    %%
    %   Setup psychtoolbox and ardunio

    [~,wPtr,wDim] = PsycToolBoxSetUp

    if ispc
        a = arduino('com3', 'uno');
    elseif ismac
        a=arduino();
    end
    %%
    % Clear arduino pins
    %   pins denote the following states
    %   D13 = moving lines
    %   D12 = CS cue
    %   D8  = CS cue with shock
    %   D3  = End of trial
    %   D2  = start/stop experiment
                writeDigitalPin(a,'D13',0);
                writeDigitalPin(a,'D12',0);
                writeDigitalPin(a,'D8',0);
                writeDigitalPin(a,'D3',0);
                writeDigitalPin(a,'D2',0);
    
    pause(2)
    
    %%
    %  Set up GUI
    global KEY_IS_PRESSED;
    KEY_IS_PRESSED = 0;
    hFig = figure
    set(hFig, 'MenuBar','none','Color','white');
    set(gca,'visible','off')
    uicontrol(hFig,'Style','pushbutton',...
        'String','Quit Experiment',...
        'Position',[30,30,100,30],...
        'Callback',@myKeyPressFunction);
    drawnow
    %%
    % Begin - trigger computer 2 (slave) to initiate record
    writeDigitalPin(a,'D2',1);
    %%
    % begin Training trials
    
    while ( KEY_IS_PRESSED  == 0)
        tic
        pick = round(rand(1)*10);
        while (round(toc)<30)
            %{
            if pick > 5
                movingLines(wPtr,8,1,wDim)
            elseif pick <= 5
                movingLines(wPtr,8,-1,wDim)
            end
            %}
            movingLines(wPtr,8,-1,wDim)
            status_update(a,1);
        end

        %{
        pick = round(rand(1)*10);
        if pick > 5
            CS_cue_one(wPtr)
        elseif pick <= 5
            CS_cue_two(wPtr)
        end
        %}
        CS_cue_one(wPtr,wDim)
        status_update(a,2);
        pause(5)
        trigger(a,'D5')
        status_update(a,3);
        pause(0.5)

        Screen('FillRect',wPtr,[0 0 255])
        Screen('Flip',wPtr)
        status_update(a,4);
        pause(10)
        
        drawnow
        
        writeDigitalPin(a,'D8',1);
        pause(1)
        disp(strcat('Digital pin 11=',num2str(readDigitalPin(a,'D11'))))
        while ( readDigitalPin(a,'D11') == 1 )
            holding = 1;
        end
        disp(strcat('Digital pin 11=',num2str(readDigitalPin(a,'D11'))))
        writeDigitalPin(a,'D8',0);
    end
    %%
    % End - trigger computer 2 (slave) to stop record
    writeDigitalPin(a,'D2',0);
    clearConditioningExperiment(a)
    clear all, close all, clc
end

function myKeyPressFunction(hObject,event)
    global KEY_IS_PRESSED;
    KEY_IS_PRESSED = 1;
    disp('Key is pressed')
end