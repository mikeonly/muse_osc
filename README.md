muse_osc
========
Read OSC TCP packages sent by muse-io in Matlab

### Instructions
1. Create TCP stream using `muse-io`. 
2. Run `muse_osc` Matlab script to read the stream.

### Customization
You can customize OSC streaming using `muse-io` options as described in MuseIO documentation for [Command Line Options](http://developer.choosemuse.com/research-tools/museio/command-line-options#Options_you_will_probably_never_use). Currently, not all streaming options are supported. 

Any path with [available data](http://developer.choosemuse.com/research-tools/available-data) can be read and processed. 

### Further reading
1. [Open Sound Control](http://opensoundcontrol.org/spec-1_0) specifies the structure of TCP packages. 
2. [OSC Paths](https://sites.google.com/a/interaxon.ca/muse-developer-site/museio/osc-paths/3-2-0) page descibes how to read timestamps. 
