points = 100
states = states.free

match.whose_turn_index = 0
match.player_list[| match.whose_turn_index] = id
match.whose_turn = match.player_list[| match.whose_turn_index]

//	Create an enemy AI
var _enemy = instance_create_layer(0,0,"Instances",enemy)
match.player_list[| 1] = _enemy

// Inherit the parent event
event_inherited()

