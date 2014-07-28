function newGrid = resizeGrid(grid) 
[row1,col1] = find(grid,1,'first');
[row2,col2]=find(grid,1,'last');
[row3,col3] = find(transpose(grid),1,'first');
[row4,col4]=find(transpose(grid),1,'last');

newGrid = grid(col3:col4, col1:col2);