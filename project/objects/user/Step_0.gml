switch(states)
{
	#region Free
		case states.free:
	
			//  Go into placement mode with a spacemarine selected
			if input.keypress_space and match.whose_turn == id and match.states = states.placement {
				states = states.placement
	
				var _xx = gridController.grid_positions_x[input.grid_x]
				var _yy = gridController.grid_positions_y[input.grid_y]
				_xx += cell_width/2
				_yy += cell_height/2 - 15	
				var _unit = instance_create_layer(_xx,_yy,"Instances",spacemarine)
				unit_placing = _unit
				
				unit_placeable = true
				//	Check if this unit is placeable
				if points < 10 or gridController.grid[# input.grid_x, input.grid_y] > -1 {
					unit_placeable = false	
				}

			}
	
		break
	#endregion
	
	#region Placement
		case states.placement:
		
			//	Moving the unit to the mouse cell position
			if mouse_in_grid and input.grid_moved {
				
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
				gridController.gridIDs[# input.grid_x, input.grid_y] = unit_placing
				
				//	Make unit mine
				unit_placing.owner = id
				unit_placing.cell_x = input.grid_x
				unit_placing.cell_y = input.grid_y
				
				//	Clean up data and state change
				unit_placing = -1
				unit_placeable = false
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
	
	#region Movement
		case states.movement:
			
			#region No unit selected
				if mouse_in_grid and selected == -1 {
					var _xx = gridController.grid_positions_x[input.grid_x]
					var _yy = gridController.grid_positions_y[input.grid_y]
					
					var _selectable = false
					var grid_contents = gridController.grid[# input.grid_x, input.grid_y]
					if grid_contents > -1 and grid_contents.owner == id {
						_selectable = true	
					}
					
					//	Selecting the unit we're hovered over
					if input.mouse_leftpress and _selectable == true {
						selected = gridController.gridIDs[# input.grid_x, input.grid_y]
						selected_grid_x = input.grid_x
						selected_grid_y = input.grid_y
					}
					
				}
			#endregion
			
			#region Unit selected
				else if mouse_in_grid and selected > -1 {
					
					//	Calculate the goal cell
					if input.grid_moved {
					
						var _xx = gridController.grid_positions_x[input.grid_x]
						var _yy = gridController.grid_positions_y[input.grid_y]
						var goal_x = _xx + cell_width/2
						var goal_y = _yy + cell_height/2 - 15
						if mp_grid_define_path(selected.x,selected.y,goal_x,goal_y,selected.path,gridController.mp_grid,false) {
							cell_goal_x = input.grid_x
							cell_goal_y = input.grid_y
							if gridController.grid[# cell_goal_x, cell_goal_y] == -1 {
								cell_goal_possible = true
							} else {
								cell_goal_possible = false	
							}
						} else {
							cell_goal_possible = false	
						}
					}	
					
					//	Move the unit to our desired cell
					if input.mouse_leftpress and cell_goal_possible == true {
						selected.cell_goal_x = cell_goal_x
						selected.cell_goal_y = cell_goal_y
						selected.pos = 0
						selected.x_goto = path_get_point_x(selected.path,selected.pos)
						selected.y_goto = path_get_point_y(selected.path,selected.pos)
						selected.states = states.movement
						
						//	Clear grid cell where unit was
						gridController.grid[# selected_grid_x, selected_grid_y] = -1
						gridController.gridIDs[# selected_grid_x, selected_grid_y] = -1
						
						//	Clear vars
						selected = -1
						selected_grid_x = -1
						selected_grid_y = -1
						cell_goal_possible = false
						cell_goal_x = -1
						cell_goal_y = -1
					}
					
					//	Right Click to deselect our selected unit
					if input.mouse_rightpress {
						
						//	Clear vars
						selected = -1
						selected_grid_x = -1
						selected_grid_y = -1
						cell_goal_possible = false
						cell_goal_x = -1
						cell_goal_y = -1
					}
					
				}
			#endregion
				
		break
	#endregion
}	

#region End Turn Button
	if match.whose_turn == id {
	
		if point_in_rectangle(gui_mouse_x,gui_mouse_y,buttonX,buttonY,buttonX+button_width,buttonY+button_height) and unit_placing == -1 {
			button_mouseover = true
			button_color = button_color_mouseover
		
			//	If pressing END TURN
			if input.mouse_leftpress or input.mouse_left {
				button_color = button_color_pressed		
			}
		
			if input.mouse_leftrelease {
				button_color = button_color_pressed
				match.whose_turn_index++
				if match.whose_turn_index >= ds_list_size(match.player_list) {
					match.whose_turn_index = 0	
				}
				match.whose_turn = match.player_list[| match.whose_turn_index]
			
			}	
		
		
		} else {
			button_mouseover = false	
			button_color = button_color_free
		}
	}
#endregion