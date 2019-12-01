switch(states)
{
	#region Free
		case states.free:
			
			//	Draw cell outline around mouse
			if mouse_in_grid and selected == -1 {
				var _xx = gridController.grid_positions_x[input.grid_x]
				var _yy = gridController.grid_positions_y[input.grid_y]
				
				var _selectable = false
				var grid_contents = gridController.gridIDs[# input.grid_x, input.grid_y]
				if grid_contents > -1 and grid_contents.owner == id and grid_contents.active == true {
					draw_set_color(c_yellow)
					_selectable = true
				} else {
					if grid_contents == -1 {
						draw_set_color(c_black)
					} else {
						draw_set_color(c_red)
					}
				}
					
				//	Draw cell outline for the cell we're hovered over
				draw_set_alpha(.33)
				draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)
				draw_rectangle(_xx+1,_yy+1,_xx+cell_width-1,_yy+cell_height-1,true)
				draw_set_alpha(1)
				
			} 
			//	Draw cell outline around selected unit
			else if mouse_in_grid and selected > -1 {
				var _xx = gridController.grid_positions_x[selected_grid_x]
				var _yy = gridController.grid_positions_y[selected_grid_y]	
	
				draw_set_color(c_yellow)

				draw_set_alpha(.33)	
				draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)
				draw_rectangle(_xx+1,_yy+1,_xx+cell_width-1,_yy+cell_height-1,true)
				draw_set_alpha(1)	

			}
			
			
			
		break
	#endregion
	
	#region Placement
		case states.placement:
		
		if mouse_in_grid {
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
			
				//	Unit selected
				if mouse_in_grid and selected > -1 {
				
					var _xx = gridController.grid_positions_x[selected_grid_x]
					var _yy = gridController.grid_positions_y[selected_grid_y]
				
					//	Draw the outline around the selected units cell
					draw_set_color(c_yellow)
					draw_set_alpha(.33)
					draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)
					draw_rectangle(_xx+1,_yy+1,_xx+cell_width-1,_yy+cell_height-1,true)
					draw_set_alpha(1)
				
					//	Draw the cell goal
					if cell_goal_x > -1 and cell_goal_y > -1 {
						var _xx = gridController.grid_positions_x[cell_goal_x]
						var _yy = gridController.grid_positions_y[cell_goal_y]
						
						if cell_goal_possible == true {
						
							//	Draw path
							draw_set_color(c_white)
							draw_path(path,selected.x,selected.y,true)
						
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
	
	#region Shooting
		case states.atk_shooting:
			
			//	Unit selected
			if mouse_in_grid and selected > -1 {
				
				var _xx = gridController.grid_positions_x[selected_grid_x]
				var _yy = gridController.grid_positions_y[selected_grid_y]
				
				//	Draw the outline around the selected units cell
				draw_set_color(c_yellow)
				draw_set_alpha(.33)
				draw_rectangle(_xx,_yy,_xx+cell_width,_yy+cell_height,true)
				draw_rectangle(_xx+1,_yy+1,_xx+cell_width-1,_yy+cell_height-1,true)
				draw_set_alpha(1)
			}
			
			
			
			
		break
	#endregion
}