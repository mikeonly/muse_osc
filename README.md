muse_osc
========
Read OSC TCP packages sent by muse-io in Matlab

Because of slow Matlab decoding speed, script does not uses OSC structure to read messages and allows only receiving of `float32` type arguments. If there is only one type of packages in the stream, instead of decoding all bits, the server calculates the package's size and reads only last `n` `float32` numbers from it. Read instructions on how to send only one type of data to the Matlab.

### Instructions
1. Connect to the Interaxon Muse using `muse-io`.
2. Run MuseLAB and open the port (default is 5000) to receive messages from `muse-io`.
3. Run Matlab script `osc_server_muse` with the specified port (e.g. 5001) and message specification. You need to input path (e.g. `/muse/eeg`) and tag (e.g. `ffff`) to allow the script to compute the messages' length. For the path and tag combinations, read [available data](http://developer.choosemuse.com/research-tools/available-data) in the documentation. For EEG plotting, Matlab uses [DSP Toolbox](http://www.mathworks.com/help/dsp/index.html) object [`TimeScope`]().
3. Go to `OSC > Outgoing` tab in the MuseLAB and add new forwarding address, e.g. `127.0.0.1:5001`.
4. To forward only one type of messages from the MuseLAB, choose one address pattern in the menu. It should now send predefined messages that can be quickly read by Matlab.

### Description

Currently script allows for time-domain and bar plots of input channels. For EEG, it is recommended to use `TimeScope`, while `alpha_relative` channel and others can be plotted dynamically using bar plot object. 

### Further reading
1. [Open Sound Control](http://opensoundcontrol.org/spec-1_0) specifies the structure of TCP packages. 
2. [OSC Paths](https://sites.google.com/a/interaxon.ca/muse-developer-site/museio/osc-paths/3-2-0) page descibes how to read timestamps. 
