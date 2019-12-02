switch(states)
{
	#region Free
		case states.free:
		
			//	Skip shooting turn if no readied units
			if match.whose_turn == id and match.ready_check and ds_list_empty(units_ready) {
				debug_log("I am skipping turn because I have no ready units")	
				round_turn()
			}
		
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
			if (time.seconds >= time_wait) {	
				
				#region I don't have a unit selected
				if selected == -1 { 
				
					#region	Select a random unit
					if !ds_list_empty(units_active) {
						selected = ds_list_find_value(units_active,irandom_range(0,ds_list_size(units_active)-1))
						selected_grid_x = selected.cell_x
						selected_grid_y = selected.cell_y
					
						debug_log("Selecting unit "+string(selected.id))
						
						time_wait = time.seconds
					}
					#endregion
					
					#region No more units of mine left to move
					else {
						debug_log("I have no more active units on the battlefield")	
					
						round_turn()
					
						states = states.free
					}
					#endregion		
					
				} 
				#endregion
				
				#region I already have a unit selected
				else {			
					
					#region	Calculate enemy units within move_distance to my selected unit
					ds_list_clear(units_player_nearby)
					for(var i=0;i<ds_list_size(player.units);i++) {
						var _enemy = player.units[| i]
						
						//	This enemy is nearby
						if point_distance(selected_grid_x,selected_grid_y,_enemy.cell_x,_enemy.cell_y) < selected.move_distance {
							ds_list_add(units_player_nearby,_enemy)
						} 						
						
					}
					#endregion
					
					#region	This unit doesn't have a target!
					if selected.target == -1 {
						
						debug_log("Unit "+string(selected.id)+ " doesn't have a target!")
						
						#region	Unit has nearby enemy units
						if !ds_list_empty(units_player_nearby) {
							
							#region	Look for a nearby unit that can be charged
							for(var i=0;i<ds_list_size(units_player_nearby);i++) {
								var _enemy = units_player_nearby[| i]
								
								var _check = check_nearby_cells(_enemy)
								//	This nearby enemy unit can be charged!
								if is_array(_check) and point_distance(selected_grid_x,selected_grid_y,_check[0],_check[1]) < selected.move_distance {
									selected.target = _enemy
								}
								
							}
							#endregion
							
							#region	There were no units available to charge
							if selected == -1 {
								selected.target = ds_list_find_value(units_player_nearby,irandom_range(0,ds_list_size(units_player_nearby)-1))	
							}
							#endregion
							
							debug_log("Gave unit "+string(selected.id)+ " a nearby target of " +string(selected.target))
						} 
						#endregion
						
						#region	No enemy units nearby
							else {
							
								//  Select a target enemy that isn't nearby
								if !ds_list_empty(player.units) {
									selected.target = ds_list_find_value(player.units,irandom_range(0,ds_list_size(player.units)-1))
									
									debug_log("Gave unit "+string(selected.id)+ " a target NOT nearby of "+string(selected.target))
								} 
								//	There are 0 enemy units what-so-ever. Way to go play tester
								else {
									debug_log("ERROR There are 0 enemy units what-so-ever. Way to go play tester...")
								}
							
							}
						#endregion
						
						time_wait = time.seconds
						
					} 
					#endregion
					
					#region	This unit has a target!
					else {
					
						//	Does this target have a free cell?
						var check = check_nearby_cells(selected.target)
						
						#region	Found an empty cell!
						if is_array(check) {
							
							debug_log("Target "+string(selected.target)+ " has a free cell!")
							
							#region	This unit can move to the free cell!
							if point_distance(selected_grid_x,selected_grid_y,check[0],check[1]) < selected.move_distance {
							
								if selected.target.ready {
									var _list = selected.target.owner.units_ready
									ds_list_delete(_list,ds_list_find_index(_list,selected.target))	
								}
								selected.target.can_shoot = false
								
								move_unit_cellxy(check[0],check[1])
								
								time_wait = time.seconds + 1
								
								debug_log("Unit "+string(selected.id)+" is charging its target")
								
							} 
							#endregion
							
							#region	This unit cannot move to the free cell
							else {
								
								debug_log("Target out of move distance. Moving unit "+string(selected)+" as close to its target as it can")
								
								move_unit_closest_cellxy(check[0],check[1])
								
								time_wait = time.seconds + 1
							
							}
							#endregion
						
						} 
						#endregion
						
						#region	No empty cells
						else {
							
							debug_log("This target has no free cells. Moving unit "+string(selected)+" as close to its target as it can")
							
							move_unit_closest_cellxy(selected.target.cell_x,selected.target.cell_y)
							
							time_wait = time.seconds + 1
							
						}
						#endregion
					
					}
					#endregion
				}
				#endregion
				
			}
				
		break
	#endregion
}