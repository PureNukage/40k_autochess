/// @param match_state

var _state = argument[0]

match.whose_turn_index++
if match.whose_turn_index >= ds_list_size(match.player_list) {
	match.whose_turn_index = 0
}

match.states = _state

match.whose_turn = match.player_list[| match.whose_turn_index]	