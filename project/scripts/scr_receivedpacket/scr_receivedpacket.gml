var read_buffer = argument[0]
var msgid = buffer_read(read_buffer,buffer_u8)

switch(msgid)
{
	case 0:
		var _x = buffer_read(read_buffer,buffer_u32)
		var _y = buffer_read(read_buffer,buffer_u32)
		var value = buffer_read(read_buffer,buffer_u32)
		
		board.grid[_x,_y] = value		
		
	break;
}