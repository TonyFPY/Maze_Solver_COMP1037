% Function to return the first index of the node in QUEUE that QUEUE(index, 1) == 1;
% Copyright 2009-2010 The MathWorks, Inc.

function i_first = first_one(QUEUE, QUEUE_COUNT)
if(size(QUEUE, 1) ~= 0)
    for j = QUEUE_COUNT : -1 : 1
        if(QUEUE(j, 1) == 1)
            i_first = j;
            break;
        end
    end
else
    i_first = -1; % empty i.e no more paths are available.
end