///	@param cell_x
/// @param cell_y

var _cell_x = argument[0]
var _cell_y = argument[1]

//	Create a grid that contains the selected unit and the free cell
var _x1 = min(selected.cell_x,_cell_x)
var _y1 = min(selected.cell_y,_cell_y)
var _x2 = max(selected.cell_x,_cell_x)
var _y2 = max(selected.cell_y,_cell_y)
								
var free_cells_x = ds_list_create()
var free_cells_y = ds_list_create()
//	Loop through grid cells and if the cell is empty toss its x,y into a list
for(var _w=_x1;_w<_x2;_w++) {
	for(var _h=_y1;_h<_y2;_h++) {
		if gridController.grid[# _w, _h] == -1 {
			ds_list_add(free_cells_x,_w)
			ds_list_add(free_cells_y,_h)
		}
		
	}
}
									
var distances_not_sorted = ds_list_create()
//	Loop through as many cells we were found empty, measure distance between the cell and the free cell then put into a list
if !ds_list_empty(free_cells_x) {
	for(var i=0;i<ds_list_size(free_cells_x);i++) {
		var _x = free_cells_x[| i]
		var _y = free_cells_y[| i]
		var _goal_x = _cell_x
		var _goal_y = _cell_y
		var _distance = point_distance(_x,_y,_goal_x,_goal_y)
		if _distance <= selected.move_distance {
			ds_list_add(distances_not_sorted,_distance)
		}
	}
									
	//	Sort compared distance list
	var distances_sorted = ds_list_create()
	ds_list_copy(distances_sorted,distances_not_sorted)
	ds_list_sort(distances_sorted,true)
									
	//	Find cell x,y after sorting
	var _closest = distances_sorted[| 0]
	var _index = ds_list_find_index(distances_not_sorted,_closest)
	var cellX = free_cells_x[| _index]
	var cellY = free_cells_y[| _index]
									
	//	Send unit to closest-to-free-cell cell
	move_unit_cellxy(cellX,cellY)									
									
} else {
	debug_log("ERROR No empty cells in between my target and my selected unit")	
}							