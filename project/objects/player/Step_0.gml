arm_rotation = point_direction(x,y,mouse_x,mouse_y)
var angle_correction 
if image_xscale > 0 angle_correction = 17 else angle_correction = -17
arm_rotation += angle_correction

hspd = (keyboard_check(ord("D")) - keyboard_check(ord("A")))*movespeed
vspd = (keyboard_check(ord("S")) - keyboard_check(ord("W")))*movespeed

x += hspd
y += vspd

if arm_rotation-angle_correction > 90 and arm_rotation-angle_correction < 270 {
	image_xscale = -1	
	arm_x = x+24
	arm_y = y-17
	arm_yscale = -1
} else {
	image_xscale = 1
	arm_x = x-24
	arm_y = y-17
	arm_yscale = 1
}