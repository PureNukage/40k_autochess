points = 100							//	Set to the number of points this player has
states = states.free					//	Set; starting state

time_wait = 0

units_player_free = ds_list_create()

// Inherit the parent event
event_inherited()