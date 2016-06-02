function tcpClose(tcpServer)

fclose(tcpServer);
delete(tcpServer);
fprintf('\tServer closed.\n');

end