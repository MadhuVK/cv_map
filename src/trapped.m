function bool = trapped(position, fakeGrid) 

bool = false; 
surroundingValues = getSurroundingValues(position, fakeGrid); 
minMax = [min(surroundingValues),max(surroundingValues)]; 

if minMax(1) >= 1 && minMax(1) <= 4 
    if minMax(2) >= 1 && minMax(2) <= 4
        bool = true; 
    end
end

end