match.whose_turn_index++
if match.whose_turn_index >= ds_list_size(match.player_list) {
	match.whose_turn_index = 0
	
	//switch(match.states)
	//{
	//	case states.placement:	var next_state = states.movement break
	//	case states.movement: var next_state = states.shooting break
	//}
	
	match.states += 1
}

match.whose_turn = match.player_list[| match.whose_turn_index]	