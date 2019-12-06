#macro cell_width 128
#macro cell_height 128
#macro grid_width room_width/cell_width
#macro grid_height room_height/cell_height

#macro gui_mouse_x device_mouse_x_to_gui(0)
#macro gui_mouse_y device_mouse_y_to_gui(0)

#macro mouse_in_grid (input.grid_x > -1 and input.grid_y > -1)

#macro animation_end (image_index > image_number - 1)

enum states {
	free,
	placement,
	movement,
	shooting,
	charge,
	fight,
	morale
}