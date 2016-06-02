function p = eegTimeScope()
p = @proceed;
% Create TimeScope oject from Digital Signal Processing toolbox.
fprintf('\tCreating EEG visualizer...\n')
eegTimeScope = dsp.TimeScope(...
    'NumInputPorts', 4, ...        % 4 channels, separate for each electrode
    'SampleRate', 220, ...
    'Name', 'EEG', ...
    'LayoutDimensions', [4,1], ... % [numberOfRows, numberOfColumns]
    'ShowGrid', true, ...
    'ShowLegend', true, ...
    'TimeSpanOverrunAction', 'Scroll', ...
    'YLimits', [0 1000]);
fprintf('\tEEG visualizer initialized.\n')
% Create function handler for adding channel input to the TimeScope
% object for plotting and analysis.
    function proceed(input)
        step(eegTimeScope, input(1), input(2), input(3), input(4));
    end
end