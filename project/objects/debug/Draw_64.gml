switch(mode)
{
	case 2:
	
	draw_set_color(c_white)
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	var _x = 15
	var _y = 15
	
	draw_text(_x,_y,"GENERAL")							_y += 15
	draw_text(_x,_y,"gui mouse x: "+string(gui_mouse_x))_y += 15 
	draw_text(_x,_y,"gui mouse y: "+string(gui_mouse_y))_y += 15
														_y += 15
	draw_text(_x,_y,"player count: "+string(ds_list_size(match.player_list)))	_y += 15
	
	with input {										_y += 15
		draw_text(_x,_y,"INPUT")						_y += 15
		draw_text(_x,_y,"grid x: "+string(grid_x))		_y += 15
		draw_text(_x,_y,"grid y: "+string(grid_y))		_y += 15
	}
	
	
	
	break;
}