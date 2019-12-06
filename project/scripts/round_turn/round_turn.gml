var current_turn = match.whose_turn_index
var current_phase = match.states

match.whose_turn_index++
#region If we've cycled through all players
	if match.whose_turn_index >= ds_list_size(match.player_list) {
		match.whose_turn_index = 0
	
		#region	Calculate things for the current phase
		switch(match.states)
		{
			case states.placement:	
			case states.movement:
			case states.charge:
				match.states += 1	
			break
			case states.shooting:
		
				var players_still_ready = 0
				var players_still_canshoot = 0
				for(var i=0;i<ds_list_size(match.player_list);i++) {
					var _player = match.player_list[| i]
					var _object_name = object_get_name(_player.object_index)
					with _player {
						//	Does anyone have any units still able to shoot?
						if !ds_list_empty(units_can_shoot) {
							players_still_canshoot++
						
							//	Does anyone have any more Readied units?
							if !ds_list_empty(units_ready) {
								players_still_ready++
							}
						
						}
					}	
				}
			
				if players_still_ready == 0 and players_still_canshoot > 0 {
					match.ready_check = false		
				}
			
				if players_still_ready == 0 and players_still_canshoot == 0 {
					match.states++	
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
#endregion

match.whose_turn = match.player_list[| match.whose_turn_index]