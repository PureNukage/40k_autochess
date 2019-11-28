var _enemy = argument[0]

var cell_x_list = ds_list_create()
var cell_y_list = ds_list_create()

var enemy_cell_x = -1
var enemy_cell_y = -1

for(var i=0;i<4;i++) {
	switch(i)
	{
		case 0:	//	Right cell
			enemy_cell_x = _enemy.cell_x + 1
			enemy_cell_y = _enemy.cell_y
		break
		case 1:	//	Top cell
			enemy_cell_x = _enemy.cell_x
			enemy_cell_y = _enemy.cell_y - 1						
		break
		case 2:	//	Left cell
			enemy_cell_x = _enemy.cell_x - 1
			enemy_cell_y = _enemy.cell_y			
		break
		case 3:	//	Bottom cell
			enemy_cell_x = _enemy.cell_x
			enemy_cell_y = _enemy.cell_y + 1			
		break
	}
	
	//	Make sure this cell exists first
	if (enemy_cell_x > -1 and enemy_cell_x < grid_width)
	and (enemy_cell_y > -1 and enemy_cell_y < grid_height) {
	
		//	Is this cell free?
		if gridController.grid[# enemy_cell_x, enemy_cell_y] == -1 {
			
			var _xx = gridController.grid_positions_x[enemy_cell_x]
			var _yy = gridController.grid_positions_y[enemy_cell_y]
			_xx += cell_width/2
			_yy += cell_height/2
			
			//	Can we path find to this cell?
			if mp_grid_define_path(selected.x,selected.y,_xx,_yy,path,gridController.mp_grid,false) {
				ds_list_add(cell_x_list,enemy_cell_x)	
				ds_list_add(cell_y_list,enemy_cell_y)
			}
			path_clear_points(path)
		}
		
	}
}

//	There was at least one available cell!
if !ds_list_empty(cell_x_list) {
	var random_index = irandom_range(0,ds_list_size(cell_x_list)-1)
	
	var array = []
	
	array[0] = ds_list_find_value(cell_x_list,random_index)
	array[1] = ds_list_find_value(cell_y_list,random_index)
	
	ds_list_destroy(cell_x_list)
	ds_list_destroy(cell_y_list)
	
	return array
} 
//	No empty cells next to this unit!
else {
	ds_list_destroy(cell_x_list)
	ds_list_destroy(cell_y_list)
	
	return false
}