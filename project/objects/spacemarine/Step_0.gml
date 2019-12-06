switch(states)
{

	#region Free
		case states.free:
		
			if player.selected == id and can_shoot and match.states == states.shooting and player.cell_goal_possible == true {
				var _xx = gridController.grid_positions_x[input.grid_x]+(cell_width/2)
				var _yy = gridController.grid_positions_y[input.grid_y]+(cell_height/2)
				arm_aim_xy(_xx,_yy)
				
				
			} else {
				arm_aim_xy(x+Direction,y)		
			}
			
			
		break
	#endregion
	
	#region Movement
		case states.movement:
			
			//	Arrived at the next goal in the path
			if point_distance(x,y,x_goto,y_goto) < 1 {
				//	End of the path
				if ++pos == path_get_number(path) {	
					states = states.free
					pos = -1
					x_goto = -1
					y_goto = -1
					Direction = Direction
					gridController.grid[# cell_x, cell_y] = -1
					gridController.gridIDs[# cell_x, cell_y] = -1
					gridController.grid[# cell_goal_x, cell_goal_y] = object_index
					gridController.gridIDs[# cell_goal_x, cell_goal_y] = id
					cell_x = cell_goal_x
					cell_y = cell_goal_y
					cell_goal_x = -1
					cell_goal_y = -1
				} 
				//	Setting goal as next point in path
				else {
					x_goto = path_get_point_x(path,pos)
					y_goto = path_get_point_y(path,pos)	
				}
			} else {
			
				//	Calculate direction
				if cell_goal_x > cell_x {
					Direction = 1
				} else if cell_goal_x < cell_x {
					Direction = -1
				} else if cell_goal_x == cell_x {
					Direction = Direction	
				}
			
				mp_potential_step(x_goto,y_goto,movespeed,false)
				
				arm_aim_xy(x+Direction,y)
			}
			
		break
	#endregion
	
	#region Shooting
		case states.shooting:
		
			//	Still shooting weapon
			if time.stream <= time_wait {
				aim_x = gridController.grid_positions_x[cell_goal_x]+(cell_width/2)
				aim_y = gridController.grid_positions_y[cell_goal_y]+(cell_height/2)
				arm_aim_xy(aim_x,aim_y)
			} 
			//	Done shooting weapon
			else {
				if abs(aim_y - y) > 2 {
					aim_y = lerp(aim_y,y,.3)
					arm_aim_xy(aim_x,aim_y)
				}
				else {
					states = states.free	
					cell_goal_x = -1
					cell_goal_y = -1
					time_wait = -1
					ready = false
					can_shoot = false
					ds_list_delete(owner.units_ready,ds_list_find_index(owner.units_ready,id))
					ds_list_delete(owner.units_can_shoot,ds_list_find_index(owner.units_can_shoot,id))
					owner.states = states.free
					owner.selected = -1
					owner.selected_grid_x = -1
					owner.selected_grid_y = -1
					owner.cell_goal_x = -1
					owner.cell_goal_y = -1
					owner.cell_goal_possible = false	
					round_turn()
				}
			
			
			}		
			
		break
	#endregion
	
	#region Charging
		case states.charge:
				
			switch(charging)
			{
				#region Start the charge
					case -1:
						
						//Calculate if target is horizontal or vertical to us
						var xx , yy 
						if target.cell_x == cell_x and target.cell_y != cell_y {		//	Vertical
							xx = x 
							yy = target.y
						} 
						if target.cell_x != cell_x and target.cell_y == cell_y {		//	Horizontal
							xx = target.x
							yy = y
						}

						mp_grid_define_path(x,y,xx,yy,path,gridController.mp_grid,false)
						pos = 0
						x_goto = path_get_point_x(path,pos)
						y_goto = path_get_point_y(path,pos)
						charging = 0
						
					break
				#endregion
				
				#region	Moving onto my target
					case 0:
						
						//	Arrived at the next goal in the path
						if point_distance(x,y,x_goto,y_goto) < 1 {
							//	End of the path
							if ++pos == path_get_number(path) {	
					
								charging++
								pos = -1
								x_goto = -1
								y_goto = -1
							} 
							//	Setting goal as next point in path
							else {
								x_goto = path_get_point_x(path,pos)
								y_goto = path_get_point_y(path,pos)	
							}
						} else {
				
						//	Calculate direction
						if x_goto > x {
							Direction = 1	
						} else if x_goto < x {
							Direction = -1
						} else {
							Direction = Direction	
						}	
			
						mp_potential_step(x_goto,y_goto,movespeed,false)
			
						}
						
						
						
					break
				#endregion
				
				#region	Doing the attack animation
					case 1:	
					
						if animation_end {
							charging++
							var xx = gridController.grid_positions_x[cell_x]+(cell_width/2)
							var yy = gridController.grid_positions_y[cell_y]+(cell_height/2)
							mp_grid_define_path(x,y,xx,yy,path,gridController.mp_grid,false)
							pos = 0
							x_goto = path_get_point_x(path,pos)
							y_goto = path_get_point_y(path,pos)
						
						}
						
					break
				#endregion
				
				#region	Moving back to my cell
					case 2:
					
						//	Arrived at the next goal in the path
						if point_distance(x,y,x_goto,y_goto) < 1 {
							//	End of the path
							if ++pos == path_get_number(path) {	
					
								charging++
								pos = -1
								x_goto = -1
								y_goto = -1
							} 
							//	Setting goal as next point in path
							else {
								x_goto = path_get_point_x(path,pos)
								y_goto = path_get_point_y(path,pos)	
							}
						} else {
				
						//	Calculate direction
						if x_goto > x {
							Direction = 1	
						} else if x_goto < x {
							Direction = -1
						} else {
							Direction = Direction	
						}	
			
						mp_potential_step(x_goto,y_goto,movespeed,false)
			
						}					
					
					
					break
				#endregion
				
				#region Exit the charge
					case 3:
						
						states = states.free
						charging = -1
						
						//	Calculate direction
						if cell_goal_x > cell_x {
							Direction = 1	
						} else if cell_goal_x < cell_x {
							Direction = -1
						} else {
							Direction = Direction	
						}	
						
					break
				#endregion
				
			}	
			
		break
	#endregion
	
}