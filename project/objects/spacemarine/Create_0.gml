arm_sprite = s_spacemarine_arm		//	Set to the sprite_index of the desired arm
body_sprite = s_spacemarine_body	//	Set to the sprite_index of the desired body
ranged = 1							//	Set if this unit is ranged and can shoot
arm_pivot_x = 24					//	Set as the difference between the body origin.x and where the arm attaches
arm_pivot_y = 17					//	Set as the difference between the body origin.y and where the arm attaches
arm_angle_correction = 17			//	Set as an offset if the arm isn't facing exactly 90* to the right
movespeed = 4						//	Set; units max movespeed
move_distance = 5					//	Set; number of cells this unit can move
shoot_distance = 4					//	Set; number of cells this unit can shoot from
states = states.placement			//	Set; the starting state of this unit

// Inherit the parent event
event_inherited()