arm_rotation = point_direction(x,y,mouse_x,mouse_y)

if arm_rotation > 90 and arm_rotation < 270 {
	image_xscale = -1	
	arm_x = x+28
	arm_y = y-22
	arm_yscale = -1
} else {
	image_xscale = 1
	arm_x = x-28
	arm_y = y-22
	arm_yscale = 1
}