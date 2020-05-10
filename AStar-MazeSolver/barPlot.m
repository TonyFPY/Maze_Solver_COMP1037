
function [] = barPlot(nond, none, tpc)
figure(2);
c = categorical({'Nodes discovered','Nodes expanded', 'Total path cost'});
num = [nond none tpc];
bar(c,num);
for i = 1 : length(num)
    text(i, num(i), num2str(num(i)),'VerticalAlignment','middle','HorizontalAlignment','center');
end
title('AStarMazeSolver');
ylabel('Number');
grid on;