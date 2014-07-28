function bool2 = presenceOfFives(fakeGrid)

% this function checks if any 5s are present in the fake grid

bool2 = false;

if (find(fakeGrid==5, 1, 'first')>0)
	bool2 = true;
end


end