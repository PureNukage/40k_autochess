arm_sprite = s_ork_arm				//	Set to the sprite_index of the desired arm
body_sprite = s_ork_body		//	Set to the sprite_index of the desired body
arm_pivot_x = 28			//	Set as the difference between the body origin.x and where the arm attaches
arm_pivot_y = 21				//	Set as the difference between the body origin.y and where the arm attaches
arm_angle_correction = 0	//	Set as an offset if the arm isn't facing exactly 90* to the right
movespeed = 4				//	Set; units max movespeed
states = states.placement   //	Set; the starting state of this unit

// Inherit the parent event
event_inherited()

