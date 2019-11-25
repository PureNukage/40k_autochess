switch(mode)
{
	case 0:
	
	break
	case 1:
		
		draw_set_color(c_white)
		
		var _xx = 0
		var _yy = 0
		for(var _x=0;_x<grid_width;_x++) {
			_yy = 0
			for(var _y=0;_y<grid_height;_y++) {
				//	Draw grid outline
				draw_set_color(c_white)
				draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)	
				
				//	Draw mp_grid collision
				if mp_grid_get_cell(gridController.mp_grid,_x,_y) == -1 {
					draw_set_color(c_red)	
				} else {
					draw_set_color(c_green)	
				}
				if gridController.grid[# _x, _y] > -1 {
					draw_set_color(c_orange)	
				}
				draw_set_alpha(.33)
				draw_rectangle(_xx+4,_yy+4,_xx+cell_width-4,_yy+cell_height-4,false)
				draw_set_alpha(1)
				_yy += cell_height
			}
			_xx += cell_width
		}
		

	
	
	break
}