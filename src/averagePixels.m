averageValues = zeros(21,1); 
for i=1:size(objects) 
    if floor(objects(i).BoundingDim(1))==0 || floor(objects(i).BoundingDim(2))==0
        a=im1(1:floor(objects(i).BoundingDim(4)),1:floor(objects(i).BoundingDim(3)));
    else
        a=im1(floor(objects(i).BoundingDim(2)):floor(objects(i).BoundingDim(2))+floor(objects(i).BoundingDim(4)),floor(objects(i).BoundingDim(1)):floor(objects(i).BoundingDim(1))+floor(objects(i).BoundingDim(3)));
    end
    b=reshape(a,size(a,1)*size(a,2), 1);
    averageValues(i)=mean(b); 
end