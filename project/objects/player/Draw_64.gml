if match.whose_turn == id {
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
	
		#region Movement
			case states.movement:
				var _x = display_get_gui_width()/2
				var _y = 60
			
				draw_set_color(c_white)
			
				draw_set_halign(fa_center)
				draw_set_valign(fa_top)
			
				draw_text(_x,_y,"YOUR TURN TO MOVE")
			
			break
		#endregion
	
		#region Shooting
			case states.shooting:
				var _x = display_get_gui_width()/2
				var _y = 60
					
				draw_set_color(c_white)
				
				draw_set_halign(fa_center)
				draw_set_valign(fa_top)
				
				if match.ready_check {
					var amount = ds_list_size(units_ready)
					draw_text(_x,_y,"YOU HAVE "+string(amount)+" UNITS LEFT READY")
				} else {
					var amount = ds_list_size(units_can_shoot)
					draw_text(_x,_y,"YOU HAVE "+string(amount)+" UNITS LEFT TO SHOOT")
				}
				
				
			break
		#endregion
	}
}