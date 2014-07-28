function [endPos, direction, fakeGrid] = steps(startPos, direction, fakeGrid, zeroOnly)

if nargin < 4
    zeroOnly = false; 
end
position = startPos;

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

while nextPosition == 2 || nextPosition == 3 
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
    
elseif nextPosition == 4 % this is the case in which the robot is back to its starting point
	fakeGrid(fakeGrid==4)=3; % replace the starting point with a wall
	if (trapped(position, fakeGrid) == true)
		closestZeroPosition=closestZero(position,fakeGrid);
		if dist(position(1),position(2),closestZeroPosition(1),closestZeroPosition(2))>=(max(size(fakeGrid,1), size(fakeGrid,2))/3)
			fakeGrid(fakeGrid==0)=5;
		else
       		%disp('hello');
			position=closestZeroPosition; 
        	%disp(position);
			direction=4;
		end
	else
		[position, direction, fakeGrid] = steps(position, direction, fakeGrid);  % go to next point and start a new round
    end
    fakeGrid(fakeGrid==1)=3; % replace all visited places with walls
	fakeGrid(position(1), position(2)) = 4; % change the starting position of the new round to 4
end

endPos = position;

end