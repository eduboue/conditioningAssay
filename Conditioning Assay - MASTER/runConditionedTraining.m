function runConditionedTraining()
    
    hFig = figure('position', [200 300 800 600]);
    hFig.Name = 'Run Fear Conditioning Assay';
    set(hFig, 'MenuBar', 'none');
    set(hFig, 'ToolBar', 'none');
    set(gcf,'color','white')
    
    h.buttonOne = uicontrol('style', 'pushbutton',...
        'position',[10 10 100 40], ...
        'string' , 'End Session', ...
        'callback', {@EndSession});
    
    [~,wPtr,~] = PsycToolBoxSetUp;
    
end


function EndSession()
    
    Screen('CloseAll')

end