controls()

if room == room1 {
	if point_in_rectangle(mouse_x,mouse_y,board.x,board.y,board.x+board.grid_countX*32,board.y+board.grid_countY*32) {
		for(var _x=0;_x<board.grid_countX;_x++) {
			for(var _y=0;_y<board.grid_countY;_y++) {
				if point_in_rectangle(mouse_x,mouse_y,board.x+(_x*32),board.y+(_y*32),board.x+(_x*32)+32,board.y+(_y*32)+32) {
					if leftclick {
						board.grid[_x,_y] = !board.grid[_x,_y]
						scr_unit_placement(_x,_y,board.grid[_x,_y])
					}
				} else {
	
				}
			}
		}
	} else {
		//if board.grid[board.grid_previousX,board.grid_previousY] == 1 {
		//	board.grid[board.grid_previousX,board.grid_previousY] = 0		
		//}
	}
}