timez=tic();


load('15by15.mat');
%{
idealGrid = a; 
MAX_X=size(idealGrid,1);
MAX_Y=size(idealGrid,2);
%Defining Figure
axis([1 MAX_X+1 1 MAX_Y+1])
grid on; 
hold on;
set(gca, 'XTick', 0:1:MAX_X);
set(gca, 'YTick', 0:1:MAX_Y); 
%}
%% BEGIN Interactive Obstacle, Target, Start Location selection
closedValues = [3]; 
objValues = 2; 
%{
pause(3);
for i=1:MAX_X
    for j=1:MAX_Y
        if sum(idealGrid(i,j) == closedValues(:)) > 0
            plot(i+.5,j+.5,'ro');
        end
        if sum(idealGrid(i,j) == objValues(:)) > 0
            plot(i+.5,j+.5,'co');
        end
        
    end
end
pause(3);
 %}
realGrid = zeros(999,999);

realPosition = [500, 500];
fakePosition = [3,2]; 
translate = [realPosition(1) - fakePosition(1), realPosition(2) - fakePosition(2)]; 
%figure(); 
MAX_X=size(realGrid,1);
MAX_Y=size(realGrid,2);
%Defining Figure
axis([495 551 495 551])
grid on; 
hold on;
set(gca, 'XTick', 0:1:MAX_X);
set(gca, 'YTick', 0:1:MAX_Y); 
MAP = idealGrid; 
direction = 1; 
MAP(fakePosition(1), fakePosition(2)) = 4; 
pause(1); 
%The following will mimic the robot in the beginning of the round, the
%robot turning around in a circle and checking if theres a wall on all
%sides. 
values = getSurroundingValues(fakePosition, MAP);
realGrid(realPosition(1), realPosition(2)+1) = values(1); 
if values(1) == 3
    plot(realPosition(1)+.5,realPosition(2)+.5,'ro');
end
    
realGrid(realPosition(1), realPosition(2)-1) = values(2); 
if values(2) == 3
    plot(realPosition(1)+.5,realPosition(2)+.5,'ro');

end
realGrid(realPosition(1)+1, realPosition(2)) = values(3); 
if values(3) == 3
    plot(realPosition(1)+.5,realPosition(2)+.5,'ro');

end
realGrid(realPosition(1)-1, realPosition(2)) = values(4); 
if values(4) == 3
    plot(realPosition(1)+.5,realPosition(2)+.5,'ro');

end
pause(1);
start = realPosition; 
realGrid(realPosition(1), realPosition(2)) = 4; 
p=plot(realPosition(1)+.5,realPosition(2)+.5,'bo'); %visual stuff ignore

pause(1); 
while (size(realGrid,1) == 999)
    set(p,'XData',realPosition(1)+.5,'YData',realPosition(2)+.5); %visual stuff ignore
    plot(start(1)+.5,start(2)+.5,'go')

    for i=1:MAX_X-1
        for j=1:MAX_Y-1
            if realGrid(i,j) == 3
                plot(i+.5,j+.5,'ro');

            end
        
        end
    end


	[realPosition, direction, MAP, realGrid] = realSteps(realPosition, translate, direction, MAP, realGrid);
    fakePosition = [realPosition(1)-translate(1), realPosition(2)-translate(2)]; 
    pause(.01);


end



%% IDEAL PATH
%NOTE: FROM NOW ON, fakeGrid is called MAP se line 72

MAX_X = size(realGrid,1); 
MAX_Y = size(realGrid,2); 

realGrid(MAP==1) = 1; 
realGrid(MAP==4) = 4; 

xStart = fakePosition(1); 
yStart = fakePosition(2); 
path = [xStart,yStart]; %first position 
MAP = realGrid; 
for i=1:MAX_X
    for j=1:MAX_Y
            if realGrid(i,j) == 3
                plot(i+.5,j+.5,'ro');
            end
        
    end
end
%p=plot(path(1,1)+.5,path(1,2)+.5,'bo'); %visual stuff ignore
%direction = direction - 1; 


i=2; % the index of the list path

position = [xStart,yStart]; 
while (presenceOfFives(MAP) == false || presenceOfZeros(MAP) == true) % run the loop if there are no fives in the grid
		[position, direction, MAP] = steps(position, direction, MAP);
        path(i,:) = position; % store the next step in the list path
        %set(p,'XData',path(size(path,1),1)+.5,'YData',path(size(path,1),2)+.5); %visual stuff ignore
        %plot(path(:,1)+.5,path(:,2)+.5); %visual stuff ignore
        if MAP(position(1), position(2)) ~= 4
            MAP(position(1), position(2)) = 1; 
        end
    i = i+1;
    %pause(.001); %pause increment between visual updates. make bigger to slow it down. 
end

%plot(path(:,1) + .5, path(:,2) + .5); 

%figure(); 
MAX_X=size(realGrid,1);
MAX_Y=size(realGrid,2);
%Defining Figure
axis([1 MAX_X+1 1 MAX_Y+1])
grid on; 
hold on;
set(gca, 'XTick', 0:1:MAX_X);
set(gca, 'YTick', 0:1:MAX_Y); 
realGrid(MAP==5) = 3;
for i=1:MAX_X
    for j=1:MAX_Y
        if sum(realGrid(i,j) == closedValues(:)) > 0
            plot(i+.5,j+.5,'ro');
        end
        
    end
end


idealPath = path(1,:);
i = 2; 
while size(path,1) ~= i
        subPath = pathFinder(idealPath(end,:), path(i,:), realGrid, 3); 
        idealPath = [idealPath; subPath];
    i = i+1; 
end
plot(idealPath(:,1) + .5, idealPath(:,2) + .5); 






figure(); 
MAX_X=size(realGrid,1);
MAX_Y=size(realGrid,2);
%Defining Figure
axis([1 MAX_X+1 1 MAX_Y+1])
grid on; 
hold on;
set(gca, 'XTick', 0:1:MAX_X);
set(gca, 'YTick', 0:1:MAX_Y); 
realGrid(MAP==5) = 3;
for i=1:MAX_X
    for j=1:MAX_Y
        if sum(idealGrid(i,j) == closedValues(:)) > 0
            plot(i+.5,j+.5,'ro');
        end
        if sum(idealGrid(i,j) == objValues(:)) > 0
            plot(i+.5,j+.5,'co');
        end
        
    end
end

pause(1); 
realPath(1,:) = idealPath(1,:); 
i = 2; 
while size(idealPath,1) ~= i  
    pos = realPath(end,:); 
    %if pos(1) == 23 && pos(2) == 43 && i > 300
    %    break; 
    %end
    if idealGrid(idealPath(i,1),idealPath(i,2))==objValues %This should mimic object detection
       idealPath = adjustIdealPath(idealPath, i, realGrid); 
    else 
        realPath(i,:) = idealPath(i,:);
        i = i+1; 
        plot(realPath(:,1)+.5,realPath(:,2)+.5); %visual stuff ignore
        pause(.01); 
    end

end


toc(timez)
