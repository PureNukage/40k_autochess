var type, port, maxclients

type = network_socket_tcp
port = 64199
maxclients = 32

server = network_create_server(type,port,maxclients)

socketlist = ds_list_create()

//Create empty grid for the board, 9x9
for(var _x=0;_x<9;_x++) {
	for(var _y=0;_y<9;_y++) {
		grid[_x,_y] = 0
	}
}