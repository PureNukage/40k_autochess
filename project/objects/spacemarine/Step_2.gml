switch(states) 
{
	#region Placement
	case states.placement:
		
		
		arm_aim_xy(x+Direction,y)
			
			
	break
	#endregion
	
	#region Charging
	case states.charge:
	
		arm_aim_xy(x+Direction,y)
	
	break
	#endregion
}