//points = 0						//	Set to the number of points this player has
//states = states.free				//	Set; starting state

unit_placing = -1					//	Active; holds the id of the unit being placed
unit_placeable = true				//	Active; holds the value for if the unit can be placed
units = ds_list_create()			//	Active; list of this players units placed on the battlefield
units_active = ds_list_create()		//	Active; list of this players units still able to do something this phase

selected = -1						//	Active; holds the id of the selected unit
selected_grid_x = -1				//	Active; holds the cell x of the selected unit
selected_grid_y = -1				//	Active; holds the cell y of the selected unit
cell_goal_x = -1					//	Active; holds the cell x of the goal cell
cell_goal_y = -1					//	Active; holds the cell y of the goal cell	
cell_goal_possible = false			//	Active; is going to the desired goal cell possible?

