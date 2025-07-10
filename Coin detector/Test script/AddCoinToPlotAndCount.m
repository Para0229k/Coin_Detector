function [coinvalue, x_plot, y_plot, col] = AddCoinToPlotAndCount(x, y, cls)
	% setting radius, color and coinvalue by class
	if cls == 1
		r = 22;
		col = 'r';
		coinvalue = 10;
	elseif cls == 2
		r = 30;
		col = 'g';
		coinvalue = 5;
	else
		r = 40;
		col = 'm';
		coinvalue = 25;
	end
	
	% plot the result
	x_plot = x + cos(0:pi/16:2*pi) * r;
	y_plot = y + sin(0:pi/16:2*pi) * r;
	plot(x_plot,y_plot,col);
end