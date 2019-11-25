switch(states)
{
	#region Placement
		case states.placement:
		
		if input.grid_x > -1 and input.grid_y > -1 {
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
		
		break
	#endregion
	
	#region Movement
		case states.movement:
		
			if input.grid_x > -1 and input.grid_y > -1 {
				var _xx = gridController.grid_positions_x[input.grid_x]
				var _yy = gridController.grid_positions_y[input.grid_y]
				
				var grid_contents = gridController.grid[# input.grid_x, input.grid_y]
				if grid_contents > -1 and grid_contents.owner == id {
					draw_set_color(c_yellow)
				} else {
					if grid_contents == -1 {
						draw_set_color(c_black)
					} else {
						draw_set_color(c_red)
					}
				}
				draw_set_alpha(.33)
				draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)
				draw_rectangle(_xx+1,_yy+1,_xx+cell_width-1,_yy+cell_height-1,true)
				draw_set_alpha(1)
				
			}	
			
		break	
	#endregion
}