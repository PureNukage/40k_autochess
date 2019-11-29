/// @param cell_goal_x
/// @param cell_goal_y

var _cell_goal_x = argument[0]
var _cell_goal_y = argument[1]

//	Pass the grid data
cell_goal_x = _cell_goal_x
cell_goal_y = _cell_goal_y
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
							
//	This unit is not active anymore this phase
ds_list_delete(units_active,ds_list_find_index(units_active,selected))
selected.active = false
							
//	Clear vars
selected = -1
selected_grid_x = -1
selected_grid_y = -1
cell_goal_possible = -1
cell_goal_x = -1
cell_goal_y = -1
							
time_wait = time.seconds + 1