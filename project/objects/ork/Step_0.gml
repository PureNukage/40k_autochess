switch(states)
{
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
}