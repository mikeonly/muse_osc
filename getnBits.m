function nbitsToRead = getnBits(path, tag)
% Synopsis:     Calculate number of bits to read from the OSC stream to get
%               a content of message
% Input:        PATH (string) is a string containing OSC path of a packet
%               to read, e.g. '/muse/eeg'
%               TAG (string) is an OSC tag without comma of value
%               specification, e.g. 'ffff'
% Output:       Number of bits to read
% For example, whole EEG packet is:
% int32 + /muse/eeg000,ffff000 + 4*float32
% Where int32           size byte                        32 bits
%       /muse/eeg000    4-byte chunks of path            96 bits
%       ,ffff000        4-byte chunks of tag             64 bits
%       4*float32       4 float-point values of EEG     128 bits
nbitsToRead = 32 + ...          % int32 at the beginning of the message
              (ceil((length(path)+1)/4)*4 + ... % 4-byte chunks of path
              ceil((length(tag)+2)/4)*4)*8 + ... % 4-byte chunks of tag
              length(tag)*32;       % assuming tag consists of f's only        
end