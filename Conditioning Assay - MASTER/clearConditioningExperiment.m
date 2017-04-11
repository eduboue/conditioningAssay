function clearConditioningExperiment(a)
            
            writeDigitalPin(a,'D13',0);
            writeDigitalPin(a,'D12',0);
            writeDigitalPin(a,'D8',0);
            writeDigitalPin(a,'D7',0);
            writeDigitalPin(a,'D2',0);
            
            Screen('CloseAll')
end