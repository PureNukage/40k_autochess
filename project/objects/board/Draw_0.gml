for(var _x=0;_x<grid_countX;_x++) {
	for(var _y=0;_y<grid_countY;_y++) {
		var pixelsX = _x * 32
		var pixelsY = _y * 32
		if grid[_x,_y] == 1 {
			draw_set_color(c_white)		
		} else {
			draw_set_color(c_ltgray)
		}
		draw_rectangle(x+pixelsX,y+pixelsY,x+pixelsX+32,y+pixelsY+32,false)
	}
}