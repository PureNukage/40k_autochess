button_endturn_width = 128
button_endturn_height = 64
button_endturnX = display_get_gui_width()-button_endturn_width-16
button_endturnY = 64+16
button_endturn_mouseover = false
button_endturn_color_free = c_ltgray
button_endturn_color_mouseover = c_gray
button_endturn_color_pressed = c_dkgray
button_endturn_color = button_endturn_color_free
button_endturn_string = "END TURN"

window_movement_width = 256
window_movement_height = 128
window_movementX = display_get_gui_width()/2-window_movement_width/2
window_movementY = display_get_gui_height()/2

var button_buffer = 6

button_ready_width = 96
button_ready_height = 64
button_readyX = window_movementX+(window_movement_width/2)+button_buffer
button_readyY = window_movementY+(window_movement_height/4)
button_ready_string = "Ready"
button_ready_string_help = "Ready unit this turn \nWill attack first next turn"
button_ready_color_free = c_ltgray
button_ready_color_mouseover = c_gray
button_ready_color_pressed = c_dkgray
button_ready_color = button_ready_color_free
button_ready_mouseover = false

button_movement_width = 96
button_movement_height = 64
button_movementX = window_movementX+(window_movement_width/2)-button_movement_width-button_buffer
button_movementY = window_movementY+(window_movement_height/4)
button_movement_string = "Move"
button_movement_string_help = "Move unit this turn"
button_movement_color = button_ready_color_free
button_movement_mouseover = false
