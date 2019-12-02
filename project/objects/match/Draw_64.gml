#region Phase Strings
	switch(states)
	{
		case states.placement:
			var _state = "DEPLOYMENT PHASE"
		break
		case states.movement:
			var _state = "MOVEMENT PHASE"
		break
		case states.shooting:
			var _state = "SHOOTING PHASE"
		break	
		case states.charge:
			var _state = "CHARGE PHASE"
		break
		case states.fight:
			var _state = "FIGHTING PHASE"
		break
		case states.morale:
			var _state = "MORALE PHASE"
		break
	
	}
#endregion

//	Draw current phase
draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_top)

var _x = display_get_gui_width()/2
var _y = 15

draw_text(_x,_y,_state)