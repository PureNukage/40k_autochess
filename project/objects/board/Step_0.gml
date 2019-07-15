if point_in_rectangle(mouse_x,mouse_y,x,y,x+grid_countX*32,y+grid_countY*32) {
	for(var _x=0;_x<grid_countX;_x++) {
		for(var _y=0;_y<grid_countY;_y++) {
			if point_in_rectangle(mouse_x,mouse_y,x+(_x*32),y+(_y*32),x+(_x*32)+32,y+(_y*32)+32) {
				if (grid[_x,_y] == 1) {
				
				} else if grid[_x,_y] == 0 {
					grid[_x,_y] = 1
					grid[grid_previousX,grid_previousY] = 0
					grid_previousX = _x
					grid_previousY = _y
				}
			} else {
	
			}
		}
	}
} else {
	if grid[grid_previousX,grid_previousY] == 1 {
		grid[grid_previousX,grid_previousY] = 0
		
	}
}