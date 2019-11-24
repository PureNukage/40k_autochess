switch(states)
{
	#region Free
		case states.free:
	
			//  Go into placement mode with a spacemarine selected
			if input.keypress_space {
				states = states.placement
	
				var _xx = gridController.grid_positions_x[input.grid_x]
				var _yy = gridController.grid_positions_y[input.grid_y]
				_xx += cell_width/2
				_yy += cell_height/2 - 15	
				var _unit = instance_create_layer(_xx,_yy,"Instances",spacemarine)
				unit_placing = _unit		
			}
	
		break
	#endregion
	
	#region Placement
		case states.placement:
		
			//	Moving the unit to the right cell position
			if (unit_placing.x != gridController.grid_positions_x[input.grid_x] and 
			unit_placing.y != gridController.grid_positions_y[input.grid_y]) {
				
				unit_placeable = true
			
				var _xx = gridController.grid_positions_x[input.grid_x]
				var _yy = gridController.grid_positions_y[input.grid_y]
				_xx += cell_width/2
				_yy += cell_height/2 - 15
				unit_placing.x = _xx
				unit_placing.y = _yy
				
				//	Check if this unit is placeable
				if points < 10 or gridController.grid[# input.grid_x, input.grid_y] > -1 {
					unit_placeable = false	
				}
			
			}
			
			
			//	Attempting to place the unit
			if input.mouse_leftpress and unit_placeable == true {
				
				//	Subtract points
				var unit_object_index = unit_placing.object_index
				points -= unitController.unit_array[unit_object_index,1]
				
				//	Place unit into grid
				gridController.grid[# input.grid_x, input.grid_y] = unit_placing.object_index
				
				states = states.free
				
			}
			
			//	Cancel placing the unit
			if input.mouse_rightpress {
				instance_destroy(unit_placing)
				unit_placing = -1
				
				states = states.free
			}
	
		break
	#endregion
}	