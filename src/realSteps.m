function [realPosition, direction, fakeGrid, realGrid] = realSteps(realPosition, translate, direction, fakeGrid, realGrid)

position = [realPosition(1)-translate(1), realPosition(2)-translate(2)];

direction = direction + 1; % turn counterclockwise each step

if direction == 5
	direction = 1;
end

switch direction
case 1
	nextPosition=fakeGrid(position(1), position(2)+1); % move right
case 2
	nextPosition=fakeGrid(position(1)-1, position(2)); % move up
case 3
	nextPosition=fakeGrid(position(1), position(2)-1); % move left
case 4
	nextPosition=fakeGrid(position(1)+1, position(2)); % move down
end

while nextPosition == 3

	switch direction
	case 1
		realGrid(realPosition(1), realPosition(2)+1)=3;
	case 2
		realGrid(realPosition(1)-1, realPosition(2))=3;	
	case 3
		realGrid(realPosition(1), realPosition(2)-1)=3;
	case 4
		realGrid(realPosition(1)+1, realPosition(2))=3;
	end

	direction = direction - 1; % turn clockwise until robot sees an empty spot
    if direction == 0
		direction = 4;
    end

    switch direction
    case 1
        nextPosition=fakeGrid(position(1), position(2)+1); % move right
    case 2
        nextPosition=fakeGrid(position(1)-1, position(2)); % move up
    case 3
        nextPosition=fakeGrid(position(1), position(2)-1); % move left
    case 4
        nextPosition=fakeGrid(position(1)+1, position(2)); % move down
    end
    
end

if nextPosition <= 1 % this is the case in which the robot moves to the next spot
	switch direction
	case 1
		position = [position(1), position(2)+1]; % move right
	case 2
		position = [position(1)-1, position(2)]; % move up
	case 3
		position = [position(1), position(2)-1]; % move left
	case 4
		position = [position(1)+1, position(2)]; % move down
    end
    fakeGrid(position(1), position(2)) = 1; 

elseif nextPosition == 4 % this is the case in which the robot is back to its starting point
	realGrid = resizeGrid(realGrid);
    realGrid(position(1), position(2)) = 4; 
    switch direction
	case 1
        realGrid(position(1), position(2)+1)=1;

	case 2
		realGrid(position(1)-1, position(2))=1;	
	case 3
		realGrid(position(1), position(2)-1)=1;
	case 4
		realGrid(position(1)+1, position(2))=1;
    end
    fakeGrid(position(1), position(2)) = 1; 

end

realPosition = [position(1)+translate(1), position(2)+translate(2)]; 
end