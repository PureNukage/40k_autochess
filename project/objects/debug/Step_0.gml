if input.keypress_control {
	mode++
	if mode >= mode_max mode = 0
}

//	Moving the game vars window
if point_in_rectangle(mouse_x,mouse_y,window_gamevarsX,window_gamevarsY,window_gamevarsX+window_gamevars_width,window_gamevarsY+window_gamevars_height)
and mode == 2 {
	
	if input.mouse_leftpress {
		window_mouseoffsetX = mouse_x - window_gamevarsX
		window_mouseoffsetY = mouse_y - window_gamevarsY
	}
	
	if input.mouse_left {
		window_gamevarsX = mouse_x - window_mouseoffsetX
		window_gamevarsY = mouse_y - window_mouseoffsetY
	}
	
	if input.mouse_leftrelease {
		window_mouseoffsetX = -1
		window_mouseoffsetY = -1
	}
	
}