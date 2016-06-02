function tcpServer = tcpOpen(ip, port)
% Synopsis: Function creates and opens TCP server and returns its object.
%
% Input:    IP = (string) up on which to listen, '127.0.0.1' default
%           PORT = port number, 5000 default
fprintf('\tStarting TCP server...\n');
tcpServer = tcpip(ip, port, 'NetworkRole', 'server');
fprintf('\tTCP server created at %s:%d.\n', ip, port);
tcpServer.InputBufferSize = 50000;
tcpServer.Timeout = 30;

fprintf('\tWainting for client connection...\n');
% Waits until data is recieved through the port
fopen(tcpServer)
fprintf('\tClient connected.\n');
end