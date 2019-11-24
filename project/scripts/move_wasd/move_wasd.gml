hspd = (keyboard_check(ord("D")) - keyboard_check(ord("A")))*movespeed
vspd = (keyboard_check(ord("S")) - keyboard_check(ord("W")))*movespeed

x += hspd
y += vspd