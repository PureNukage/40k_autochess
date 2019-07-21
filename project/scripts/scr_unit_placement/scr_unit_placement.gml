var buffer = buffer_create(1024,buffer_fixed,1)
var _x = argument[0]
var _y = argument[1]
var value = argument[2]

buffer_seek(buffer,buffer_seek_start,0)
buffer_write(buffer,buffer_u8,0)
buffer_write(buffer,buffer_u32,_x)
buffer_write(buffer,buffer_u32,_y)
buffer_write(buffer,buffer_u32,value)
network_send_packet(socket,buffer,buffer_tell(buffer))