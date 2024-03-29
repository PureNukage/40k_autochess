key_w = keyboard_check(ord("W"))
key_a = keyboard_check(ord("A"))
key_s = keyboard_check(ord("S"))
key_d = keyboard_check(ord("D"))

keypress_space = keyboard_check_pressed(vk_space)

keypress_control = keyboard_check_pressed(vk_control)

mouse_left = mouse_check_button(mb_left)
mouse_leftpress = mouse_check_button_pressed(mb_left)
mouse_leftrelease = mouse_check_button_released(mb_left)
mouse_rightpress = mouse_check_button_pressed(mb_right)

#region Calculate grid_x, grid_y and grid_moved
	var _xx = 0
	var _yy = 0
	for(var _x=0;_x<grid_width;_x++) {
		_yy = 0
		for(var _y=0;_y<grid_height;_y++) {
			if point_in_rectangle(mouse_x,mouse_y,_xx,_yy,_xx+cell_width,_yy+cell_height) {
				grid_xprevious = grid_x
				grid_yprevious = grid_y
				grid_x = _x
				grid_y = _y
				if grid_xprevious != grid_x or grid_yprevious != grid_y {
					grid_moved = true	
				} else {
					grid_moved = false
				}	
				exit
			} else {
				if _x == grid_width and _y == grid_height {
					grid_xprevious = grid_x
					grid_yprevious = grid_y
					grid_x = -1
					grid_y = -1
					if grid_xprevious != grid_x or grid_yprevious != grid_y {
						grid_moved = true	
					} else {
						grid_moved = false
					}
				}
			}
			_yy += cell_height
		}
		_xx += cell_width
	}
#endregion