switch(mode)
{
	case 2:
	
	var _x = 15
	var _y = 15
	
	draw_text(_x,_y,"GENERAL")							_y += 15
	draw_text(_x,_y,"gui mouse x: "+string(gui_mouse_x))_y += 15 
	draw_text(_x,_y,"gui mouse y: "+string(gui_mouse_y))_y += 15
	
	with input {										_y += 15
		draw_text(_x,_y,"INPUT")						_y += 15
		draw_text(_x,_y,"grid x: "+string(grid_x))		_y += 15
		draw_text(_x,_y,"grid y: "+string(grid_y))		_y += 15
	}
	
	
	
	break;
}