% OSC Server for Muse headband
%
% Original code:
% Raymundo Cassani
% raymundo.cassani@gmail.com
% November 2014

% Check if the Instrumentation Control Toolbox is present
requirements = {'Instrument Control Toolbox', 'DSP System Toolbox'};
verInfo = ver;
tbFlags = [];
list = '';
for k = 1:numel(requirements)
    tb = requirements{k};
    % Array that contains flag 'missing'
    tbFlags = [tbFlags ~any(strcmp(tb, {verInfo.Name}))];
    list = strcat(list,tb,{', '});
end
% Assert that nothing is missing and print error otherwise
if sum(tbFlags) == 1
    assert(false, '\n\t%s is missing.',...
        strcat(list{1}(1:end-2)))
end
if sum(tbFlags) > 1
    assert(false, '\n\tSeveral toolboxes are missing: %s\n',...
        strcat(list{1}(1:end-2),'.'))
end

fprintf('\n')

%% Initializing function
% Calculate number of bits in OSC message.
% nbits = getnBits('/muse/elements/alpha_relative', 'ffff');
nbits = getnBits('/muse/eeg', 'ffff');

% Create a function handler for adding new values to the TimeScope.
% eegAddToPlot = eegTimeScope();

% Create bar plot for alpha relative channel and get a handler for
% updating it.
% addToBarPlot = barPlot([0 1], 'Alpha Relative');

ts = timeseries('EEG')
ts.DataInfo.Units = 'mV';
ts.TimeInfo.Units = 's';
blink = tsdata.event('Blink', 7);
blink.Units = 's';

% Use defaults to start TCP server.
museServer = tcpOpen('127.0.0.1', 7006);

%% Receiving loop
i = 0;

fprintf('\tStart.')

while i < 1100
    try
%         Bar plot can be used to show alpha relative:
%         args = tcpRead(museServer, alpharelBits);
%         addToBarPlot(args);
          i = i + 1;
%         This is used for plotting real-time EEG signal.
%         args = tcpRead(museServer, eegBits);
%         eegAddToPlot(args);
    catch err;
        break
    end
end

% Start recording 20 packets (2 seconds)
while i < 1540
    args = tcpRead(museServer, nbits);
    ts = ts.addsample('Time',i/220,'Data',args(1));
    i = i + 1;
end

% Display stimulus
fprintf('\tBlink!')
ts = addevent(ts, blink); % Add blink event

% Record 30 packets (3 seconds) after event
while i < 2200
    args = tcpRead(museServer, nbits);
    ts = ts.addsample('Time',i/220,'Data',args(1));
    i = i + 1;
end

fprintf('\tEnd.')
plot(ts)
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