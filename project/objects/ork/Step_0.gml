switch(states)
{
	#region Movement
		case states.movement:
			
			//	Arrived at the next goal in the path
			if point_distance(x,y,x_goto,y_goto) < 1 {
				//	End of the path
				if ++pos == path_get_number(path) {	
					
					//	We were attack moving, return to charge state
					if charging != -1 {
						states = states.charge	
					} else {
						states = states.free
					}
					pos = -1
					x_goto = -1
					y_goto = -1
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
			} else {
				Direction = Direction	
			}	
			
			mp_potential_step(x_goto,y_goto,movespeed,false)
			
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
								sprite_index = s_ork_attack
								image_speed = .33
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
							
							sprite_index = s_ork_idle
							image_speed = 1
							charging++
							var xx = gridController.grid_positions_x[cell_x]+(cell_width/2)
							var yy = gridController.grid_positions_y[cell_y]+(cell_height/2)
							mp_grid_define_path(x,y,xx,yy,path,gridController.mp_grid,false)
							pos = 0
							x_goto = path_get_point_x(path,pos)
							y_goto = path_get_point_y(path,pos)
							charging = 2
						
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