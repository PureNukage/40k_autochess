switch(states)
{
	#region Placement
		case states.placement:
		case states.free:
		case states.movement:
		
			draw_set_color(c_white)
			draw_set_halign(fa_center)
			draw_set_valign(fa_top)
		
			var _xx = display_get_gui_width()/2
			var _whose_turn = object_get_name(whose_turn.object_index)
			//draw_text(_xx,60,"IT IS "+string(_whose_turn)+"'S TURN")
			
			
			
		break
	#endregion
}