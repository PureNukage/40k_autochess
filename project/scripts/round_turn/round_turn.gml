var current_turn = match.whose_turn_index
var current_phase = match.states

match.whose_turn_index++
if match.whose_turn_index >= ds_list_size(match.player_list) {
	match.whose_turn_index = 0
	
	#region	Calculate things for the current phase
	switch(match.states)
	{
		case states.placement:	
		case states.movement:
			match.states += 1	
		break
		case states.shooting:
			
			with playerParent {
				//	Does anyone have any units still able to shoot?
				if !ds_list_empty(units_can_shoot) {
					
					//	Does anyone have any more Readied units?
					if !ds_list_empty(units_ready) {
						
					} else {
						match.ready_check = false		
					}
					
				} else {
					match.states++	
				}
				
			}
			
			
		break
	
	
	}
	#endregion
	
	#region	Calculate things when entering this state
	if match.states != current_phase {
		switch(match.states)
		{
			case states.shooting:
			
				match.ready_check = true
			
				//	Calculate can_shoot unit lists for all players
				with playerParent {
	
					ds_list_clear(units_can_shoot)
					for(var i=0;i<ds_list_size(units);i++) {
									
						if units[| i].can_shoot {
							ds_list_add(units_can_shoot,units[| i])
						}
					
					}
				
				}
				
			break
		}
	}
	#endregion
	
}

match.whose_turn = match.player_list[| match.whose_turn_index]	