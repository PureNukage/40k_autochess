if input.grid_x > -1 and input.grid_y > -1 and states == states.placement {
	var _xx = gridController.grid_positions_x[input.grid_x]
	var _yy = gridController.grid_positions_y[input.grid_y]	
	
	if unit_placeable == true {
		draw_set_color(c_green)
	} else {
		draw_set_color(c_red)	
	}
	draw_set_alpha(.33)	
	draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,false)
	draw_set_alpha(1)	
	
	draw_set_color(c_black)
	draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)	
	

}