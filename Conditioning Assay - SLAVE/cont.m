function cont()
    

    global KEY_IS_PRESSED
    
    KEY_IS_PRESSED = 0;

    itr       =    0;
    
    figHandle = figure; 
    set(figHandle, 'MenuBar', 'none', 'Color', 'white'); 
    set(gca, 'visible', 'off');
    uicontrol(figHandle, 'Style', 'pushbutton',...
        'String', 'Quit Experiment',...
        'Position',[30 30 100 30],...
        'Callback', @myKeyPressFcn);
   
    while( KEY_IS_PRESSED == 0)
        itr = itr + 1
        drawnow
    end
end

function myKeyPressFcn(hObject, event)
    global KEY_IS_PRESSED
    KEY_IS_PRESSED  = 1;
    disp('key is pressed') 
end
