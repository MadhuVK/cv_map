function bool2 = presenceOfZeros(fakeGrid)

% this function checks if any zeros are present in the fake grid

bool2 = false;

if (find(fakeGrid==0, 1, 'first')>0)
	bool2 = true;
end

end