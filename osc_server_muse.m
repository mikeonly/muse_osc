% OSC Server for Muse headband
% 
% Original code:
% Raymundo Cassani 
% raymundo.cassani@gmail.com
% November 2014

clear all;
close all;

% Check if the Instrumentation Control Toolbox is present
tbName = 'Instrument Control Toolbox';
verInfo = ver;
tbFlag = any(strcmp(tbName, {verInfo.Name}));
assert(tbFlag, 'Instument Control Toolbox needed.')

% Server parameters
ip = '127.0.0.1'; % Localhost
port = 6000;  % TCP Port (default port is 5000)
timeoutSec = 10; % In seconds

tcpServer = tcpip(ip, port, 'NetworkRole', 'server');
tcpServer.InputBufferSize = 5000; 
tcpServer.Timeout = timeoutSec;

fprintf('\n');
fprintf('\tWainting for client connection...\n');

% Waits until data is recieved through the port
fopen(tcpServer);

fprintf('\tClient connected.\n');

% Temporary used for EEG and accelerometer plotting
% ---
fse = 220; % EEG output frequency
fsa = 50;  % Accelerometer output frequency
secBuffer = 10;

eegName = {'TP9'; 'FP1'; 'FP2'; 'TP10'};
eegBuffer = zeros([fse*secBuffer,numel(eegName)]);
accName = {'F/B'; 'U/D'; 'R/L'};
accBuffer = zeros([fsa*secBuffer,numel(accName)]);

eegCounter = 0;
plot1 = true;
conf1 = true;

figure()
% ---

while 1
    try
        size = fread(tcpServer, 1, 'int32'); % Get size of the content
        contents = fread(tcpServer, size);
        
        [path, tag, sequence] = splitOscMessage(contents);
        
        switch path % Process packet depending on its path
            case '/muse/eeg' % Process EEG packet
                % Split sequence into tagged data
                data = oscFormat(tag, sequence); 
                
                % Temporary used for EEG plotting
                % ---
                eegBuffer = [eegBuffer(2:end, :); cell2mat(data)];
                eegCounter = eegCounter+1;
                % ---
            case '/muse/acc'
                % Split sequence into tagged data
                data = oscFormat(tag, sequence); 
                
                % Temporary used for EEG plotting
                % ---
                accBuffer = [accBuffer(2:end, :); cell2mat(data)];
                % ---
            otherwise
                % Do nothing
                % More cases can be added to treat other paths
        end
        
        % Temporary used for EEG plotting
        % ---
        if eegCounter == 44
            if plot1
                subplot(2,1,1);
                time = 0:1/fse:secBuffer-1/fse;
                h1 = plot(time,eegBuffer);
                legend(eegName, 'Location','EastOutside');
                xlabel('Time (s)')
                ylabel('Voltage (uV)')
                
                subplot(2,1,2);
                time = 0:1/fsa:secBuffer-1/fsa;
                h2= plot(time,accBuffer);
                xlabel('Time (s)')
                ylabel('Acceleration (mG)')
                legend(h2, accName, 'Location','EastOutside');
                
                plot1 = false;
                
            else
                cell1 = (num2cell(eegBuffer,1))';
                set(h1,{'ydata'},cell1);
                cell2 = (num2cell(accBuffer,1))';
                set(h2,{'ydata'},cell2);
            end
            drawnow;
            eegCounter = 0;
        end % if eegCounter
        % ---
        
    catch err;
        break
    end
end

fclose(tcpServer);
delete(tcpServer);
fprintf('\tEnd of acquisition.\n');

if exist('err', 'var')
    errorStruct = struct('indetifier', err.identifier, ...
                         'message', err.message, ...
                         'stack', err.stack);
    fprintf('\n\n')                 
    error(errorStruct);
end