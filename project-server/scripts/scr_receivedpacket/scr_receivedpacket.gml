var read_buffer = argument[0]
var socket = argument[1]
var msgid = buffer_read(read_buffer,buffer_u8)

switch(msgid)
{
	case 0:
		var _x = buffer_read(read_buffer,buffer_u32)
		var _y = buffer_read(read_buffer,buffer_u32)
		var value = buffer_read(read_buffer,buffer_u32)
		
		grid[_x,_y] = value
		
		var buffer = buffer_create(1024,buffer_fixed,1)
		buffer_write(buffer,buffer_u8,0)
		buffer_write(buffer,buffer_u32,_x)
		buffer_write(buffer,buffer_u32,_y)
		buffer_write(buffer,buffer_u32,value)
		for(var i=0;i<ds_list_size(socketlist);i++) {
			var _socket = ds_list_find_value(socketlist,i)
			network_send_packet(_socket,buffer,buffer_tell(buffer))
		}
		
		
	break;
		
}