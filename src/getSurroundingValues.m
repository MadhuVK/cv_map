function values = getSurroundingValues(position, grid) 
	values(1) = grid(position(1), position(2) + 1); 
	values(2) = grid(position(1), position(2) - 1); 
	values(3) = grid(position(1) + 1, position(2)); 
	values(4) = grid(position(1) - 1, position(2)); 
end