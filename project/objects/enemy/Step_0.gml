switch(states)
{
	case states.free:
		
		//	If it just changed to my turn
		if match.whose_turn == id {
			
			time_wait = time.seconds + 1
			states = states.placement
			
		}
	
	
	break
	case states.placement:
		
		//	If its my turn
		if match.whose_turn == id {
			
			if time.seconds_switch and time.seconds == time_wait {
				
				//	I am able to place another ork
				if points >= 10 {
					time_wait = time.seconds + 1
					var _cell_x = irandom_range(grid_width-2,grid_width-1)
					var _cell_y = irandom_range(0,grid_height-1)
					while gridController.grid[# _cell_x, _cell_y] > 0 {
						_cell_x = irandom_range(grid_width-2,grid_width-1)
						_cell_y = irandom_range(0,grid_height-1)	
					}
				
					var _xx = gridController.grid_positions_x[_cell_x]
					var _yy = gridController.grid_positions_y[_cell_y]
					_xx += cell_width/2
					_yy += cell_height/2
					gridController.grid[# _cell_x, _cell_y] = ork
					instance_create_layer(_xx,_yy,"Instances",ork)
					points -= unitController.unit_array[ork,1]
					debug_log("Just placed an ORK at grid cell "+string(_cell_x)+","+string(_cell_y))
				} 
				//	I am NOT able to place another ork; ending turn				
				else {
					time_wait = 0
					states = states.free
					
					match.whose_turn_index++
					if match.whose_turn_index >= ds_list_size(match.player_list) {
						match.whose_turn_index = 0	
					}
					match.whose_turn = match.player_list[| match.whose_turn_index]						
						
				}
				
			}
			
		}	
	
	
	break
}