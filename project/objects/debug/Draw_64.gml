switch(mode)
{
	#region Game Variables 
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
			draw_text(_x,_y,"grid moved: "+string(grid_moved))  _y += 15
		}
	
		with player {											_y += 15
			draw_text(_x,_y,"selected: "+string(selected))	_y += 15
			draw_text(_x,_y,"cell goal possible: "+string(cell_goal_possible))  _y += 15
			draw_text(_x,_y,"cell goal x: "+string(cell_goal_x))				_y += 15
			draw_text(_x,_y,"cell goal y: "+string(cell_goal_y))				_y += 15
		
		
		
		
		}	

		break
	#endregion
}