arm_aim_xy(x+1,y)

switch(states)
{
	#region Free
		case states.free:
			
			
			
			
			
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
			}
			
			mp_potential_step(x_goto,y_goto,movespeed,false)		
			
		break
	#endregion
}