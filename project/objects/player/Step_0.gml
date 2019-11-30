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
			
			//	Select a unit to move
			if mouse_in_grid and selected == -1 and match.whose_turn == id and match.states = states.movement {
				var _xx = gridController.grid_positions_x[input.grid_x]
				var _yy = gridController.grid_positions_y[input.grid_y]
					
				var _selectable = false
				var grid_contents = gridController.gridIDs[# input.grid_x, input.grid_y]
				if grid_contents > -1 and grid_contents.owner == id and grid_contents.active == true {
					_selectable = true	
				}
					
				//	Selecting the unit we're hovered over
				if input.mouse_leftpress and _selectable == true {
					selected = gridController.gridIDs[# input.grid_x, input.grid_y]
					selected_grid_x = input.grid_x
					selected_grid_y = input.grid_y
				}			
			}
			
			//	If a unit is currently selected
			if mouse_in_grid and selected > -1 {
				
				//	Right click to deselect unit
				if input.mouse_rightpress {
					selected = -1
					selected_grid_x = -1
					selected_grid_y = -1
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
					
			//	Placing the unit
			if input.mouse_leftpress and unit_placeable == true {
				
				//	Subtract points
				var unit_object_index = unit_placing.object_index
				points -= data.units[unit_object_index,1]
				
				//	Place unit into grid
				gridController.grid[# input.grid_x, input.grid_y] = unit_placing.object_index
				gridController.gridIDs[# input.grid_x, input.grid_y] = unit_placing
				
				//	Make unit mine
				unit_placing.owner = id
				unit_placing.active = true
				unit_placing.cell_x = input.grid_x
				unit_placing.cell_y = input.grid_y
				ds_list_add(units,unit_placing)
				
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
			
			// Unit selected
			if mouse_in_grid and selected > -1 {
					
				//	Calculate the goal cell
				if input.grid_moved {
					
					var _xx = gridController.grid_positions_x[input.grid_x]
					var _yy = gridController.grid_positions_y[input.grid_y]
					var goal_x = _xx + cell_width/2
					var goal_y = _yy + cell_height/2 - 15
					if mp_grid_define_path(selected.x,selected.y,goal_x,goal_y,path,gridController.mp_grid,false) {
						cell_goal_x = input.grid_x
						cell_goal_y = input.grid_y
						if gridController.grid[# cell_goal_x, cell_goal_y] == -1 {
							cell_goal_possible = true
						} else {
							cell_goal_possible = false	
						}
						
						//	Check distance between selected.cells and cell_goal
						if point_distance(selected_grid_x,selected_grid_y,cell_goal_x,cell_goal_y) < selected.move_distance {
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
					selected.active = false
					selected.pos = 0
					selected.path = path_duplicate(path)					
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
					cell_goal_possible = false
					cell_goal_x = -1
					cell_goal_y = -1
					path_clear_points(path)
						
					states = states.free
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
						
					states = states.free
				}
					
			}
				
		break
	#endregion
	
	#region Attack
		case states.attack:
			
			
			
			
			
		break
	#endregion
	
}	