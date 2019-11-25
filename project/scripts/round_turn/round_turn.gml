/// @param match_state

var _state = argument[0]

match.whose_turn_index++
if match.whose_turn_index >= ds_list_size(match.player_list) {
	match.whose_turn_index = 0
}

//	End of the placement stage, flip all players states to movement
if match.states == states.placement and _state == states.movement {
	for(var i=0;i<ds_list_size(match.player_list);i++) {
		match.player_list[| i].states = states.movement
	}
}

match.states = _state

match.whose_turn = match.player_list[| match.whose_turn_index]	