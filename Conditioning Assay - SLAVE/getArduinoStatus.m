function output = getArduinoStatus(a)
        
     %{
        if readDigitalPin(a,'D13') == 1
            output = 1;
        elseif readDigitalPin(a,'D12') == 1
            output = 2;
        elseif readDigitalPin(a,'D8') == 1
            output = 3;
        elseif readDigitalPin(a,'D3') == 1
            output = 4;
        else
            output = 0;
        end
        %}
        if readDigitalPin(a,'D13') == 1
            output = 1;
        elseif readDigitalPin(a,'D3') == 1
            output = 4;
        else
            output = 0;
        end
    
    %{
        if readDigitalPin(a,'D12') == 1
            output = 2;
        elseif readDigitalPin(a,'D3') == 1
            output = 4;
        else
            output = 0;
        end
     %}
end