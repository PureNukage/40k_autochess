match.whose_turn_index++
if match.whose_turn_index >= ds_list_size(match.player_list) {
	match.whose_turn_index = 0
	
	match.states += 1
	
	#region	Calculate things when entering this state
	switch(match.states)
	{
		case states.shooting:
			
			//	Calculate can_shoots for all players units
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
	#endregion
}

match.whose_turn = match.player_list[| match.whose_turn_index]	