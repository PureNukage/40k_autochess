grid = ds_grid_create(grid_width,grid_height)
gridIDs = ds_grid_create(grid_width,grid_height)

ds_grid_set_region(grid,0,0,grid_width,grid_height,-1)
ds_grid_set_region(gridIDs,0,0,grid_width,grid_height,-1)

mp_grid = mp_grid_create(0,0,grid_width,grid_height,cell_width,cell_height)

grid_positions_x = []
grid_positions_y = []

var _xx = 0
var _yy = 0
for(var _x=0;_x<grid_width;_x++) {
	_yy = 0
	for(var _y=0;_y<grid_height;_y++) {
		grid_positions_x[_x] = _xx
		grid_positions_y[_y] = _yy		
		_yy += cell_height
	}	
	_xx += cell_width
}