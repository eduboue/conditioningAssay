function newStatus = modifyStatus(status)
    
    newStatus = zeros(size(status));
    
    itr = 0;
    for i=1:length(status)
        
        if status(i) == 0 & itr == 0
            newStatus(i) = 0;
            itr = 0;
        elseif status(i) == 1 & itr == 0
            newStatus(i) = 1;
            itr = 1;
        elseif status(i) == 1 & itr == 1
            newStatus(i) = 1;
            itr = 1;
        elseif status(i) == 0 & itr == 1
            newStatus(i) = 2;
            itr = 2;
        elseif status(i) == 0 & itr == 2
            newStatus(i) = 2;
            itr = 2;
        elseif status(i) == 4 & itr == 2
            newStatus(i-2) = 3;
            newStatus(i-1) = 3;
            newStatus(i) = 4;
            itr = 4
        elseif status(i) == 4 & itr == 4
            newStatus(i) = 4;
            itr = 4;
        else
            status(i)
            itr
            error(sprintf('Something went wrong at frame %i ... :-/',i));
        end
        
    end

end