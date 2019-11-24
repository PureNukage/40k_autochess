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
				draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)	
				_yy += cell_height
			}
			_xx += cell_width
		}
		

	
	
	break
}