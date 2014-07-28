function output = closestZero(position, grid)

x = position(1); 
y = position(2); 
output = position; 
fakeGrid=zeros(size(grid,1),size(grid,2));
for i=1:size(fakeGrid,1)
    for j=1:size(fakeGrid,2)
        fakeGrid(i,j) = NaN; 
    end
end

for i=1:size(grid,1)
    for j=1:size(grid,2)
        if grid(i,j)==0
            fakeGrid(i,j)=((x-i)^2+(y-j)^2)^(1/2);
        end
    end
end
a=min(min(fakeGrid));

%{
for i=1:size(fakeGrid,1)
    for j=1:size(fakeGrid,2)
        if fakeGrid(i,j)==a
            output=[i,j];
            break;
        end
    end
end
%}
[blah, blah1] = find(fakeGrid==a, 1, 'first'); 
output = [blah, blah1];
%maybe 2 closest zeros???????
end