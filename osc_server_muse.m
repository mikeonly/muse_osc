% OSC Server for Muse headband
%
% Original code:
% Raymundo Cassani
% raymundo.cassani@gmail.com
% November 2014

% Check if the Instrumentation Control Toolbox is present
tbName = 'Instrument Control Toolbox';
verInfo = ver;
tbFlag = any(strcmp(tbName, {verInfo.Name}));
assert(tbFlag, 'Instument Control Toolbox needed.')

fprintf('\n')
        
%% Initializing function
% Use defaults to start TCP server.
% Create a function handler for adding new values to the TimeScope.
% eegAddToPlot = eegTimeScope();
% Create bar plot for alpha relative channel and get a handler for
% updating it.
addToBarPlot = barPlot([0 1], 'Alpha Relative');

museServer = tcpOpen('127.0.0.1', 7000);

% Calculate number of bits in OSC message.
alpharelBits = getnBits('/muse/elements/alpha_relative', 'ffff');
% eegBits = getnBits('/muse/eeg', 'ffff');

%% Receiving loop
while true
    try
%         Bar plot can be used to show alpha relative:
        args = tcpRead(museServer, alpharelBits);
        addToBarPlot(args);
        
%         This is used for plotting real-time EEG signal.
%         args = tcpRead(museServer, eegBits);
%         eegAddToPlot(args);
    catch err;
        break
    end
end

%% Closing statements
% Close TCP server.
tcpClose(museServer);

if exist('err', 'var')
    errorStruct = struct('indetifier', err.identifier, ...
        'message', err.message, ...
        'stack', err.stack);
    fprintf('\n')
    error(errorStruct);
end