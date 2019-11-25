switch(match.states)
{
	#region Placement
		case states.placement:
			if match.whose_turn == id {
					var _x = display_get_gui_width()/2
				var _y = 60
	
				draw_set_color(c_white)
	
				draw_set_halign(fa_center)
				draw_set_valign(fa_top)
	
				draw_text(_x,_y,"YOUR TURN TO PLACE UNITS (spacebar)")
	
				_y += 30
				draw_text(_x,_y,"POINTS: "+string(points))
			}
		break
	#endregion
}
//	Draw "END TURN" if it is the player turns
if match.whose_turn == id {
	
	draw_set_color(button_color)
	draw_roundrect(buttonX,buttonY,buttonX+button_width,buttonY+button_height,false)
	
	draw_set_color(c_black)
	draw_roundrect(buttonX,buttonY,buttonX+button_width,buttonY+button_height,true)
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(buttonX+button_width/2,buttonY+button_height/2,"END TURN")
	
	
}