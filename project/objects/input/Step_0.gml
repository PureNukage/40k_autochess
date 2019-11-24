key_w = keyboard_check(ord("W"))
key_a = keyboard_check(ord("A"))
key_s = keyboard_check(ord("S"))
key_d = keyboard_check(ord("D"))

keypress_space = keyboard_check_pressed(vk_space)

keypress_control = keyboard_check_pressed(vk_control)

mouse_leftpress = mouse_check_button_pressed(mb_left)
mouse_rightpress = mouse_check_button_pressed(mb_right)

var _xx = 0
var _yy = 0
for(var _x=0;_x<grid_width;_x++) {
	_yy = 0
	for(var _y=0;_y<grid_height;_y++) {
		if point_in_rectangle(mouse_x,mouse_y,_xx,_yy,_xx+cell_width,_yy+cell_height) {
			grid_x = _x
			grid_y = _y
			exit
		} else {
			grid_x = -1
			grid_y = -1
		}
		_yy += cell_height
	}
	_xx += cell_width
}