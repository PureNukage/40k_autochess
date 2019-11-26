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
			if gridController.grid
			
			
		break
		case 2:	//	Left cell
			
		break
		case 3:	//	Bottom cell
			
		break
	}
	
	//	Is this cell free?
	if gridController.grid[# enemy_cell_x, enemy_cell_y] == -1 {
		ds_list_add(cell_x_list,enemy_cell_x)	
		ds_list_add(cell_y_list,enemy_cell_y)
	}
}