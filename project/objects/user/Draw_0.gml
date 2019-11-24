if input.grid_x > -1 and input.grid_y > -1 {
	var _xx = gridController.grid_positions_x[input.grid_x]
	var _yy = gridController.grid_positions_y[input.grid_y]
	
	draw_set_color(c_black)
	draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)	
}