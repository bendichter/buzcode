function  [n, evchans] = plx_event_chanmap(filename)
% plx_event_chanmap(filename): return map of raw event numbers for each channel
%
% [n, evchans] = plx_event_chanmap(filename)
%
% INPUT:
%   filename - if empty string, will use File Open dialog
%
% OUTPUT:
%   n - number of event channels
%   evchans - 1 x n array of event channel numbers
%
% In a .plx file there are only a few event channel headers, so the raw
% event channel numbers are NOT the same as the index in the event channel
% array.
% E.g. there may be only 2 event channels in a .plx file header, but those channels
% correspond to raw event channel numbers 7 and 34. So in this case NChans = 2, 
% and evchans[1] = 7, evchans[2] = 34.
% The plx_ routines that return arrays always return arrays of size NChans. However,
% routines that take channels numbers as arguments always expect the raw  
% channel number.  So in the above example, to get the event timestamps from  
% the second channel, use
%   [n, ts, sv] = plx_event_ts(filename, evchans[2])

if nargin ~= 1
    error 'expected 1 input argument';
end

[ filename, isPl2 ] = internalPL2ResolveFilenamePlx( filename );
if isPl2 == 1
    % the code here is only to support legacy scripts with plx_* APIs 
    % when working with .plx and .pl2 files generated by OmniPlex.
    % all .plx files generated by OmniPlex have these 43 hardcoded event channels
    n = 43;
    evchans = [1:32 257:259 101:108];
    return;
end

[n, evchans] = mexPlex(28, filename);

end