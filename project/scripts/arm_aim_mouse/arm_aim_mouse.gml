arm_rotation = point_direction(x,y,mouse_x,mouse_y)
var angle_correction 
if image_xscale > 0 angle_correction = arm_angle_correction else angle_correction = -1*arm_angle_correction
arm_rotation += angle_correction

if arm_rotation-angle_correction > 90 and arm_rotation-angle_correction < 270 {
	image_xscale = -1	
	arm_x = x+arm_pivot_x
	arm_y = y-arm_pivot_y
	arm_yscale = -1
} else {
	image_xscale = 1
	arm_x = x-arm_pivot_x
	arm_y = y-arm_pivot_y
	arm_yscale = 1
}