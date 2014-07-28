function visualModified(idealGrid)
%% DON"T WORRY ABOUT THIS STUFF SCROLL DOWN UNTIL YOU GET TO THE PART THAT
%% SAYS IDEAL PATH

%% DEFINE THE 2-D MAP ARRAY
MAX_X=size(idealGrid,1);
MAX_Y=size(idealGrid,2);
MAP=2*(zeros(MAX_X,MAX_Y));
%Defining Figure
axis([1 MAX_X+1 1 MAX_Y+1])
grid on; 
hold on;
set(gca, 'XTick', 0:1:MAX_X);
set(gca, 'YTick', 0:1:MAX_Y); 

%% BEGIN Interactive Obstacle, Target, Start Location selection
closedValues = [3]; 
objValues = [2]; 

pause(1);
for i=1:MAX_X
    for j=1:MAX_Y
        if sum(idealGrid(i,j) == closedValues(:)) > 0
            MAP(i,j) = 3;%Put on the closed list as well
            plot(i+.5,j+.5,'ro');
        end
        if sum(idealGrid(i,j) == objValues(:)) > 0
            plot(i+.5,j+.5,'co');
        end
        
    end
end
 for i=1:MAX_X
    for j=1:MAX_Y

    end
 end
 
pause(2);
h=msgbox('Please Select the Vehicle initial position using the Left Mouse button');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('Please Select the Vehicle initial position ','Color','black');
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
    xval=floor(xval);
    yval=floor(yval);
end
xStart=xval;%Starting Position
yStart=yval;%Starting Position
MAP(xval,yval) = 4;
plot(xval+.5,yval+.5,'bo');










%% IDEAL PATH
%NOTE: FROM NOW ON, fakeGrid is called MAP se line 72
path = [xStart,yStart]; %first position 

p=plot(path(1,1)+.5,path(1,2)+.5,'bo'); %visual stuff ignore
direction = 1;
i=2; % the index of the list path
position = [xStart,yStart]; 
while (presenceOfFives(MAP) == false) % run the loop if there are no fives in the grid
		[position, direction, MAP] = steps(position, direction, MAP);
        path(i,:) = position; % store the next step in the list path
        %set(p,'XData',path(size(path,1),1)+.5,'YData',path(size(path,1),2)+.5); %visual stuff ignore
        plot(path(:,1)+.5,path(:,2)+.5); %visual stuff ignore
        if MAP(position(1), position(2)) ~= 4
            MAP(position(1), position(2)) = 1; 
        end
    i = i+1;
    %pause(.001); %pause increment between visual updates. make bigger to slow it down. 
end

idealPath = path; 

%path(2,:) = [40,40]; 
plot(path(:,1) + .5, path(:,2) + .5); 