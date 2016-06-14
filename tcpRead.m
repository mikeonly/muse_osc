function args = tcpRead(server, nbitsToRead, precision)
% Synopsis:     Function to read nelements from a channel with specified
%               path and tag.
% 
% Input:        SERVER (object) server to read from
%               NBITSTOREAD (number) number of bits in the message to read
%               PRECISION (string) data format of the packet
% Number of float32 value can be passed to the fopen manually to
% avoid in-program calculations and work only with information of
% interest.
contents = fread(server, nbitsToRead/32, precision);
% Read last 4 float32 values from contents, which contain mV
% reading from electrodes.
args = contents(end-3:end);
end