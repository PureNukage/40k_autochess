switch(states)
{
	#region Free
		case states.free:
		
			//	My turn to place units
			if match.whose_turn == id and match.states == states.placement {
			
				time_wait = time.seconds + 1
				states = states.placement
			
			}
			
			//	My turn to move units
			if match.whose_turn == id and match.states == states.movement {
				
				time_wait = time.seconds + 1
				states = states.movement
			}
	
		break
	#endregion
	
	#region Placement
		case states.placement:
			
			if time.seconds_switch and time.seconds == time_wait {
				
				//	I am able to place another ork
				if points >= unitController.unit_array[ork,1] {
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
					
					//	Spawn ork and place in grid
					var _ork = instance_create_layer(_xx,_yy,"Instances",ork)
					_ork.owner = id
					_ork.cell_x = _cell_x
					_ork.cell_y = _cell_y
					gridController.gridIDs[# _cell_x, _cell_y] = _ork
					gridController.grid[# _cell_x, _cell_y] = ork
					ds_list_add(units,_ork)
					
					//	Subtract points
					points -= unitController.unit_array[ork,1]
					debug_log("Just placed an ORK at grid cell "+string(_cell_x)+","+string(_cell_y))
				} 
				//	I am NOT able to place another ork; ending turn				
				else {
					time_wait = 0
					states = states.free
					
					//	This is the end of the placement round
					if ds_list_find_index(match.player_list,id) == ds_list_size(match.player_list)-1 {
						with match { 
							round_turn(states.movement)
						}
					} 
					//	This is NOT the end of the placement round
					else {
						with match {
							round_turn(match.states)
								
						}
					}					
						
				}
				
			}
	
		break
	#endregion
	
	#region Movement
		case states.movement:
			
			if time.seconds_switch and time.seconds == time_wait {
				
				//	Select a random ork
				if !ds_list_empty(units) {
					selected = ds_list_find_value(units,irandom_range(0,ds_list_size(units)-1))
					selected_grid_x = selected.cell_x
					selected_grid_y = selected.cell_y
					
					//	Find a cell near an enemy unit
					if !ds_list_empty(user.units) {
						var enemy_unit = ds_list_find_value(user.units,irandom_range(0,ds_list_size(user.units)-1))
						
						var check = check_nearby_cells(enemy_unit)
						//	Found an empty cell!
						if is_array(check) {
							
							//	Kick this unit into moving
							cell_goal_x = check[0]
							cell_goal_y = check[1]
							selected.cell_goal_x = cell_goal_x
							selected.cell_goal_y = cell_goal_y
							
							//	Define the path this unit will take
							var _xx = gridController.grid_positions_x[cell_goal_x]
							var _yy = gridController.grid_positions_y[cell_goal_y]
							_xx += cell_width/2
							_yy += cell_height/2
							mp_grid_define_path(selected.x,selected.y,_xx,_yy,selected.path,gridController.mp_grid,false)
							
							selected.pos = 0
							selected.x_goto = path_get_point_x(selected.path,selected.pos)
							selected.y_goto = path_get_point_y(selected.path,selected.pos)
							selected.states = states.movement
							
							//	Clear grid cell where unit was
							gridController.grid[# selected_grid_x, selected_grid_y] = -1
							gridController.gridIDs[# selected_grid_x, selected_grid_y] = -1
							
							//	Put unit into goal grid cell
							gridController.grid[# cell_goal_x, cell_goal_y] = selected.object_index
							gridController.gridIDs[# cell_goal_x, cell_goal_y] = selected
							
							//	Clear vars
							selected = -1
							selected_grid_x = -1
							selected_grid_y = -1
							cell_goal_possible = -1
							cell_goal_x = -1
							cell_goal_y = -1
							
						} 
						//	No empty cells near this unit!
						else {
								
						}
						
					} else {
						debug_log("ERROR There are no enemies of mine on the battlefield!")	
					}
					
				} else {
					debug_log("ERROR I have no units on the battlefield!")	
				}
				
				
			}
			
			
			
		break
	#endregion
}