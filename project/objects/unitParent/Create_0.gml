//arm_sprite = -1				//	Set to the sprite_index of the desired arm
//body_sprite = -1			//	Set to the sprite_index of the desired body
//arm_pivot_x = 0				//	Set as the difference between the body origin.x and where the arm attaches
//arm_pivot_y = 0				//	Set as the difference between the body origin.y and where the arm attaches
//arm_angle_correction = 0	//	Set as an offset if the arm isn't facing exactly 90* to the right
//movespeed = 0				//	Set; units max movespeed
//states = states.placement //	Set; the starting state of this unit

arm_rotation = 0			//	Active; the angle of the arm 
arm_x = x-arm_pivot_x		//	Active; the x-axis point to attach the arm
arm_y = y-arm_pivot_y		//	Active; the y-axis point to attach the arm
arm_yscale = 1				//	Active; the image_yscale of the arm

hspd = 0					//	Active; units horizontal speed
vspd = 0					//	Active; units vertical speed

owner = -1					//	Active; what player owns this unit
path = path_add()			//	Active; units path
pos = -1					//	Active; current position in the path
x_goto = -1					//	Active; next x position in the path
y_goto = -1					//	Active; next y position in the path