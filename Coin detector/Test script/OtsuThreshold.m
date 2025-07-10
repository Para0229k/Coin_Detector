function [msk,thrsh] = OtsuThreshold(img)
	% define the threshold by using histogram
	hist = imhist(img);
	thrsh = otsuthresh(hist);
	thrsh = thrsh * 255;
	
	% apply threshold to img to make msk
	msk = img > thrsh;
end