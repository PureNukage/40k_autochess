#region	Draw "END TURN" if it is the players turn
if match.whose_turn == player.id and (match.states != states.charge and match.states != states.fight) {
	
	drawButton(button_endturn_width,button_endturn_height,button_endturnX,button_endturnY,button_endturn_color,button_endturn_string,button_endturn_mouseover)
	
}
#endregion

#region Draw "MOVE" AND "READY" window on players movement turn and when a unit is selected
if match.whose_turn == player.id and player.selected > -1 and player.states == states.free {
	
	draw_set_alpha(.33)
	draw_set_color(c_ltgray)
	draw_roundrect(window_movementX,window_movementY,window_movementX+window_movement_width,window_movementY+window_movement_height,false)
	draw_set_alpha(1)
	
	drawButton(button_ready_width,button_ready_height,button_readyX,button_readyY,button_ready_color,button_ready_string,button_ready_mouseover,button_ready_string_help)
	
	drawButton(button_movement_width,button_movement_height,button_movementX,button_movementY,button_movement_color,button_movement_string,button_movement_mouseover,button_movement_string_help)
	
}


#endregion