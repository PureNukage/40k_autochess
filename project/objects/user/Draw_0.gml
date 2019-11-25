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
		
			//	No unit selected
			if input.grid_x > -1 and input.grid_y > -1 and selected == -1 {
				var _xx = gridController.grid_positions_x[input.grid_x]
				var _yy = gridController.grid_positions_y[input.grid_y]
				
				var _selectable = false
				var grid_contents = gridController.grid[# input.grid_x, input.grid_y]
				if grid_contents > -1 and grid_contents.owner == id {
					draw_set_color(c_yellow)
					_selectable = true
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
				
				if input.mouse_leftpress and _selectable == true {
					
					selected = gridController.gridIDs[# input.grid_x, input.grid_y]
					selected_grid_x = input.grid_x
					selected_grid_y = input.grid_y
				}
				
			} else if input.grid_x > -1 and input.grid_y > -1 and selected > -1 {
				
				var _xx = gridController.grid_positions_x[selected_grid_x]
				var _yy = gridController.grid_positions_y[selected_grid_y]
				
				//	Draw the outline around the selected units cell
				draw_set_color(c_yellow)
				draw_set_alpha(.33)
				draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)
				draw_rectangle(_xx+1,_yy+1,_xx+cell_width-1,_yy+cell_height-1,true)
				draw_set_alpha(1)
				
				//	Calculate the goal cell
				if input.grid_moved {
					
					var _xx = gridController.grid_positions_x[input.grid_x]
					var _yy = gridController.grid_positions_y[input.grid_y]
					var goal_x = _xx + cell_width/2
					var goal_y = _yy + cell_height/2
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
				
				//	Draw the cell goal
				if cell_goal_x > -1 and cell_goal_y > -1 {
					var _xx = gridController.grid_positions_x[cell_goal_x]
					var _yy = gridController.grid_positions_y[cell_goal_y]
						
					if cell_goal_possible == true {
						
						//	Draw path
						draw_set_color(c_white)
						draw_path(selected.path,selected.x,selected.y,true)
						
						draw_set_color(c_green)	
						
					} else {
						draw_set_color(c_red)	
					}
					draw_set_alpha(.33)
					draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)
					draw_rectangle(_xx+1,_yy+1,_xx+cell_width-1,_yy+cell_height-1,true)
					draw_set_alpha(1)
					
				}
				
				
				
			}
			
		break	
	#endregion
}