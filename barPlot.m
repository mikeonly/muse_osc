function p = barPlot(limits, name)
% Synopsis:     Function creates a bar plot and returns a handler for
%               pushing new values.
% Input:        LIMITS (vector) specifies [ymin ymax] values
%               NAME (string) used to give name to a bar plot
p = @proceed;
% Create TimeScope oject from Digital Signal Processing toolbox.
fprintf('\tCreating figure for ''%s''...\n', name)
b = bar([0 0 0 0]);
ylim(limits);
fprintf('\tBar plot ''%s'' initialized.\n', name)
% Create function handler for changing bar plot.
    function proceed(input)
        % Variable linked to YData, specified as a string containing a
        % MATLAB workspace variable name.
        b.YData = input;
        drawnow;
    end
end