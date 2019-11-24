points = 100
states = states.free

match.whose_turn_index = 0
match.player_list[| match.whose_turn_index] = id
match.whose_turn = match.player_list[| match.whose_turn_index]

//	Create an enemy AI
var _enemy = instance_create_layer(0,0,"Instances",enemy)
match.player_list[| 1] = _enemy

button_width = 128
button_height = 64
buttonX = display_get_gui_width()-button_width-16
buttonY = 64+16
button_mouseover = false
button_color_free = c_ltgray
button_color_mouseover = c_gray
button_color_pressed = c_dkgray
button_color = button_color_free

// Inherit the parent event
event_inherited()

