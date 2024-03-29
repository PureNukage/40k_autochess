#region End Turn Button
	if match.whose_turn == player.id and (match.states != states.charge and match.states != states.fight) {
	
		if point_in_rectangle(gui_mouse_x,gui_mouse_y,button_endturnX,button_endturnY,button_endturnX+button_endturn_width,button_endturnY+button_endturn_height) and player.unit_placing == -1 {
			button_endturn_mouseover = true
			button_endturn_color = button_endturn_color_mouseover
		
			//	If pressing END TURN
			if input.mouse_leftpress or input.mouse_left {
				button_endturn_color = button_endturn_color_pressed		
			}
		
			if input.mouse_leftrelease {
				button_endturn_color = button_endturn_color_pressed
				
				//	I am choosing to skip shooting units
				if match.states == states.shooting {
					if match.ready_check {
						if !ds_list_empty(player.units_ready) {
							for(var i=0;i<ds_list_size(player.units_ready);i++) {
								var _unit = player.units_ready[| i]
								_unit.ready = false
							}
							ds_list_clear(player.units_ready)
						}
					} else {
						if !ds_list_empty(player.units_can_shoot) {
							for(var i=0;i<ds_list_size(player.units_can_shoot);i++) {
								var _unit = player.units_can_shoot[| i]
								_unit.can_shoot = false
							}
							ds_list_clear(player.units_can_shoot)	
						}	
					}
				}
				
				round_turn()
			
			}	
		
		
		} else {
			button_endturn_mouseover = false	
			button_endturn_color = button_endturn_color_free
		}
	}
#endregion

if match.whose_turn == player.id and player.selected > -1 {
	
	#region Ready Button 
	if point_in_rectangle(gui_mouse_x,gui_mouse_y,button_readyX,button_readyY,button_readyX+button_ready_width,button_readyY+button_ready_height) {
		button_ready_mouseover = true
		button_ready_color = button_ready_color_mouseover
		
		//	Darken the button color
		if input.mouse_leftpress or input.mouse_left {
			button_ready_color = button_ready_color_pressed			
		}
		
		//	Ready the selected unit
		if input.mouse_leftrelease { 
			ds_list_add(player.units_ready,player.selected)
			ds_list_delete(player.units_active,player.selected)
			player.selected.active = false
			player.selected.ready = true
			
			//	Clean up data
			player.selected = -1
			player.selected_grid_x = -1
			player.selected_grid_y = -1
			player.states = states.free
			
		}
				
	} else {
		button_ready_mouseover = false
		button_ready_color = button_ready_color_free
				
	}
	#endregion
	
	#region Movement Button
	if point_in_rectangle(gui_mouse_x,gui_mouse_y,button_movementX,button_movementY,button_movementX+button_movement_width,button_movementY+button_movement_height) and player.states == states.free {
		button_movement_mouseover = true
		button_movement_color = button_ready_color_mouseover
		
		//	Darken the button color
		if input.mouse_leftpress or input.mouse_left {
			button_movement_color = button_ready_color_pressed
			
		}
		
		//	Move the selected unit
		if input.mouse_leftrelease {	
			player.states = states.movement	
		}
		
	} else {
		button_movement_mouseover = false
		button_movement_color = button_ready_color_free
			
	}
	#endregion
	
}