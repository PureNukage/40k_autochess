switch(states)
{
	#region Free
		case states.free:
		
			//	My turn to place units
			if match.whose_turn == id and match.states == states.placement {
			
				time_wait = time.seconds + 1
				states = states.placement
			
			}
			
			//	My turn to move units
			if match.whose_turn == id and match.states == states.movement {
				
				//	Make all units active
				ds_list_clear(units_active)
				for(var i=0;i<ds_list_size(units);i++) {
					units[| i].active = true
				}
				ds_list_copy(units_active,units)
				
				//	Throw players units into a list
				ds_list_copy(units_player_free,player.units)
				
				time_wait = time.seconds + 1
				states = states.movement
			}
	
		break
	#endregion
	
	#region Placement
		case states.placement:
			
			//	Time to make a move
			if time.seconds_switch and time.seconds == time_wait {
				
				//	I am able to place another ork
				if points >= data.units[ork,1] {
					time_wait = time.seconds + 1
					var _cell_x = irandom_range(grid_width-2,grid_width-1)
					var _cell_y = irandom_range(0,grid_height-1)
					while gridController.grid[# _cell_x, _cell_y] > 0 {
						_cell_x = irandom_range(grid_width-2,grid_width-1)
						_cell_y = irandom_range(0,grid_height-1)	
					}
				
					var _xx = gridController.grid_positions_x[_cell_x]
					var _yy = gridController.grid_positions_y[_cell_y]
					_xx += cell_width/2
					_yy += cell_height/2
					
					//	Spawn ork and place in grid
					var _ork = instance_create_layer(_xx,_yy,"Instances",ork)
					_ork.owner = id
					_ork.cell_x = _cell_x
					_ork.cell_y = _cell_y
					gridController.gridIDs[# _cell_x, _cell_y] = _ork
					gridController.grid[# _cell_x, _cell_y] = ork
					ds_list_add(units,_ork)
					
					//	Subtract points
					points -= data.units[ork,1]
					debug_log("Just placed an ORK at grid cell "+string(_cell_x)+","+string(_cell_y))
				} 
				//	I am NOT able to place another ork; ending turn				
				else {
					time_wait = 0
					states = states.free
					
					round_turn()					
						
				}
				
			}
	
		break
	#endregion
	
	#region Movement
		case states.movement:
			
			//	Time to make a move
			if time.seconds_switch and time.seconds == time_wait {
				
				#region	Select a random unit
				if !ds_list_empty(units_active) {
					selected = ds_list_find_value(units_active,irandom_range(0,ds_list_size(units_active)-1))
					selected_grid_x = selected.cell_x
					selected_grid_y = selected.cell_y
					
					//	Calculate enemy units within move_distance to my selected unit
					ds_list_clear(units_player_nearby)
					for(var i=0;i<ds_list_size(player.units);i++) {
						var _enemy = player.units[| i]
						
						//	This enemy is nearby
						if point_distance(selected_grid_x,selected_grid_y,_enemy.cell_x,_enemy.cell_y) <= selected.move_distance {
							ds_list_add(units_player_nearby,_enemy)
						} 						
						
					}
					
					#region	This unit doesn't have a target!
					if selected.target == -1 {
						
						#region	Unit has nearby enemy units
						if !ds_list_empty(units_player_nearby) {
							selected.target = irandom_range(0,ds_list_size(units_player_nearby)-1)	
						} 
						#endregion
						
						#region	No enemy units nearby
							else {
							
								//  Select a target enemy that isn't nearby
								if !ds_list_empty(player.units) {
									selected.target = ds_list_find_value(player.units,irandom_range(0,ds_list_size(player.units)-1))
								} 
								//	There are 0 enemy units what-so-ever. Way to go play tester
								else {
									debug_log("ERROR There are 0 enemy units what-so-ever. Way to go play tester...")
								}
							
							}
						#endregion
						
						time_wait = time.seconds + 1
						
					} 
					#endregion
					
					#region	This unit has a target!
					else {
					
						//	Does this target have a free cell?
						var check = check_nearby_cells(selected.target)
						
						#region	Found an empty cell!
						if is_array(check) {
							
							#region	This unit can move to the free cell!
							if point_distance(selected_grid_x,selected_grid_y,check[0],check[1]) <= selected.move_distance {
								
								move_unit_cellxy(check[0],check[1])
								
								time_wait = time.seconds + 1
								
							} 
							#endregion
							
							#region	This unit cannot move to the free cell
							else {
								
								move_unit_closest_cellxy(check[0],check[1])
								
								time_wait = time.seconds + 1
							
							}
							#endregion
						
						} 
						#endregion				
						
						#region	No empty cells
						else {
							
							time_wait = time.seconds + 1
							
						}
						#endregion
					
					}
					#endregion
					
				} 
				#endregion
				
				#region No more units of mine left to move
				else {
					debug_log("I have no more active units on the battlefield")	
					
					round_turn()
				}
				#endregion		
				
			}
				
		break
	#endregion
}