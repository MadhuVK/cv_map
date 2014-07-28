function [idealPath, realGrid] = adjustIdealPath(idealPath, index, realGrid)
    realGrid(idealPath(index,1), idealPath(index,2)) = 2; 
    part1 = idealPath(1:index, :); 
    part2 = idealPath(index+1:end, :); 
    part1(end,:) = []; 
    subPath = pathFinder(part1(end,:), part2(1,:), realGrid, [2,3]); 
    part1 = [part1; subPath];
    if subPath(end,:) == part2(1,:)
        part2(1,:) = []; 
    end
    idealPath = [part1; part2]; 
    
end

