//	Draw "YOUR TURN" if it is the player turns
if match.whose_turn == id {
	var _x = display_get_gui_width()/2
	var _y = 30
	
	draw_set_color(c_white)
	
	draw_set_halign(fa_center)
	
	draw_text(_x,_y,"YOUR TURN TO PLACE UNITS")
	
	_y += 30
	draw_text(_x,_y,"POINTS: "+string(points))
	
	
}