function status_update(a,state)

% D13 = state 1, moving lines
% D11 = state 2, CS without shock
% D8  = state 3, CS with shock
% D7  = state 4, trial over cue

        if state == 1
            writeDigitalPin(a,'D13',1);
            writeDigitalPin(a,'D12',0);
            writeDigitalPin(a,'D8',0);
            writeDigitalPin(a,'D3',0);
        elseif state == 2
            writeDigitalPin(a,'D13',0);
            writeDigitalPin(a,'D12',1);
            writeDigitalPin(a,'D8',0);
            writeDigitalPin(a,'D3',0);
        %elseif state == 3
        %    writeDigitalPin(a,'D13',0);
        %    writeDigitalPin(a,'D12',0);
        %    writeDigitalPin(a,'D8',1);
        %    writeDigitalPin(a,'D3',0);
        elseif state == 4
            writeDigitalPin(a,'D13',0);
            writeDigitalPin(a,'D12',0);
            writeDigitalPin(a,'D8',0);
            writeDigitalPin(a,'D3',1);
        else
            writeDigitalPin(a,'D13',0);
            writeDigitalPin(a,'D12',0);
            writeDigitalPin(a,'D8',0);
            writeDigitalPin(a,'D3',0);
        end

end