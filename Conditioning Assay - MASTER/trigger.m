function trigger(a,port)
    writeDigitalPin(a, port, 1); 
    pause(1); 
    writeDigitalPin(a, port, 0);
end