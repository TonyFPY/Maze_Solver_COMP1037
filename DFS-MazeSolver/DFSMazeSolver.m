%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 04-26-2005    Copyright 2009-2010 The MathWorks, Inc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function []= DFSMazeSolver(maze)

% initialization
WINDOW_SIZE = size(maze, 2);
MAX_X = WINDOW_SIZE;
MAX_Y = WINDOW_SIZE;
xStart = MAX_X;
xTarget = 1;
for j = 1 : MAX_Y
    if(maze(WINDOW_SIZE, j) ~= 8)
        yStart = j;
    end 
end 
for j = 1 : MAX_Y
    if(maze(1, j) ~= 8)
        yTarget = j;
    end 
end 

% OBSTACLE: [X val, Y val]
OBSTACLE = [];
k = 1;
for i = 1 : MAX_X
    for j = 1 : MAX_Y
        if(maze(i, j) == 0)
            OBSTACLE(k, 1) = i;
            OBSTACLE(k, 2) = j;
            k = k + 1;
        end
    end
end
OBST_COUNT = size(OBSTACLE, 1);
OBST_COUNT = OBST_COUNT + 1;
OBSTACLE(OBST_COUNT, :) = [xStart, yStart];

%% add the starting node as the first node (root node) in QUEUE
% QUEUE: [0/1, X val, Y val, Parent X val, Parent Y val, g(n)]
xNode = xStart;
yNode = yStart;
QUEUE = [];
QUEUE_COUNT = 1;
NoPath = 1; % assume there exists a path
path_cost = 0; % cost g(n): start node to the current node n
QUEUE(QUEUE_COUNT, :) = insert(xNode, yNode, xNode, yNode, path_cost);
QUEUE(QUEUE_COUNT, 1) = 0; % What does this do?

% Start the search
while((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)
    
    % expand the current node to obtain child nodes
    exp = expand(xNode, yNode, path_cost, xTarget, yTarget, OBSTACLE, MAX_X, MAX_Y);
    exp_count  = size(exp, 1);
    % Update QUEUE with child nodes; exp: [X val, Y val, g(n)]
    if(exp_count ~= 0)
        for i = 1 : exp_count
            QUEUE_COUNT = QUEUE_COUNT + 1;
            QUEUE(QUEUE_COUNT, :) = insert(exp(i, 1), exp(i, 2), xNode, yNode, exp(i, 3));
        end
    end
    
    f_index = first_one(QUEUE, QUEUE_COUNT);
    if(f_index ~= -1)
        % move the node to OBSTACLE
        OBST_COUNT = size(OBSTACLE, 1);
        OBST_COUNT = OBST_COUNT + 1;
        OBSTACLE(OBST_COUNT, 1) = xNode;
        OBSTACLE(OBST_COUNT, 2) = yNode;
        % mark this node
        QUEUE(f_index, 1) = 0;
        xNode = QUEUE(f_index, 2);
        yNode = QUEUE(f_index, 3);
        path_cost = QUEUE(f_index, 6); % cost g(n)
        if(xNode ~= xTarget || yNode ~= yTarget)
            maze(xNode, yNode) = 2;
            dispMaze(maze);
        end
        % pause(0.05);
    else
        NoPath = 0; % there is no path!
    end
end
%% Output / plot your route
result();
