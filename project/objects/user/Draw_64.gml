switch(match.states)
{
	#region Placement
		case states.placement:
				var _x = display_get_gui_width()/2
			var _y = 60
	
			draw_set_color(c_white)
	
			draw_set_halign(fa_center)
			draw_set_valign(fa_top)
	
			draw_text(_x,_y,"YOUR TURN TO PLACE UNITS (spacebar)")
	
			_y += 30
			draw_text(_x,_y,"POINTS: "+string(points))
		break
	#endregion
}
//	Draw "YOUR TURN" if it is the player turns
if match.whose_turn == id {

	
	//	Draw END TURN button
	if point_in_rectangle(gui_mouse_x,gui_mouse_y,buttonX,buttonY,buttonX+button_width,buttonY+button_height) and unit_placing == -1 {
		button_mouseover = true
		button_color = button_color_mouseover
		
		//	If pressing END TURN
		if input.mouse_leftpress or input.mouse_left {
			button_color = button_color_pressed		
		}
		
		if input.mouse_leftrelease {
			button_color = button_color_pressed
			match.whose_turn_index++
			if match.whose_turn_index >= ds_list_size(match.player_list) {
				match.whose_turn_index = 0	
			}
			match.whose_turn = match.player_list[| match.whose_turn_index]
			
		}	
		
		
	} else {
		button_mouseover = false	
		button_color = button_color_free
	}
	
	draw_set_color(button_color)
	draw_roundrect(buttonX,buttonY,buttonX+button_width,buttonY+button_height,false)
	
	draw_set_color(c_black)
	draw_roundrect(buttonX,buttonY,buttonX+button_width,buttonY+button_height,true)
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(buttonX+button_width/2,buttonY+button_height/2,"END TURN")
	
	
}