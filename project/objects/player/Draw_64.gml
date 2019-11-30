switch(match.states)
{
	#region Placement
		case states.placement:
			var _x = display_get_gui_width()/2
			var _y = 60
	
			draw_set_color(c_white)
	
			draw_set_halign(fa_center)
			draw_set_valign(fa_top)
	
			if match.whose_turn == id {
				draw_text(_x,_y,"YOUR TURN TO PLACE UNITS (spacebar)")
	
				_y += 30
				draw_text(_x,_y,"POINTS: "+string(points))
			}
		break
	#endregion
	
	#region Movement
		case states.movement:
			var _x = display_get_gui_width()/2
			var _y = 60
			
			draw_set_color(c_white)
			
			draw_set_halign(fa_center)
			
			if match.whose_turn == id {
				draw_text(_x,_y,"YOUR TURN TO MOVE")
			}
			
			
		break
	#endregion
}