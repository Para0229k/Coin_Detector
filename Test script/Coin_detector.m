% Creating test image 'im' by splicing together two built in images.
% Also zero-padding (adding zeros around the border) with half the
% filter size (filtsize) we will use so that the filter could be
% centered on any actual image pixel, including those near the border.
% 'coins.png' contains bright nickels and dimes on a dark background
% 'eight.tif' contains dark quarters on a bright background, so we invert it
% to match 'coins.png'

filtsize = 85;
im1 = imread('coins.png');
[r, c] = size(im1);

im2 = imread('eight.tif');
[r2, c2] = size(im2);

filtsizeh = floor(filtsize / 2);
im = zeros(r + r2 + filtsize, c + filtsize);
im(filtsizeh + 1:filtsizeh + r + r2, filtsizeh + 1:filtsizeh + c) = [im1; 255 - im2(:, 1:c)];
[r, c] = size(im);
imagesc(im); colormap(gray); title('test image'); axis equal;



%%%%% 1. Localize the centroid of each coin

% Otsu threshold
[msk, ~] = OtsuThreshold(im);
figure; imagesc(msk); colormap(gray); title('Otsu'); axis equal;

% Dilate
msk_dil = imdilate(msk, ones(9, 9));
figure; imagesc(msk_dil); colormap(gray); title('Dilated'); axis equal;

% Erode
msk_dil_erd = imerode(msk_dil, ones(23, 23));
figure; imagesc(msk_dil_erd); colormap(gray); title('Eroded'); axis equal;

% Connected components to get centroids of coins:
comps = bwconncomp(msk_dil_erd);
ctd = regionprops(comps);

hold on;
centroid = zeros(length(ctd), 2);
component_size = zeros(length(ctd), 1);

for i = 1:length(ctd)
	% show the distribution of centroids
	plot(ctd(i).Centroid(1), ctd(i).Centroid(2), 'r+');
	
	% save centroid coordinates
	centroid(i, 1:2) = ceil(ctd(i).Centroid(1:2));
	
	% save component size
	component_size(i, 1) = ctd(i).Area;
end



%%%%% 2. Measure features for each coin using a bank of matching filters

% make matching filters to create features
% Define diameters and filter size to use for filters
dimediameter = 31;
nickeldiameter = 41;
quarterdiameter = 51;

% Use the MakeCircleMatchingFilter function to create matching filters for dimes, nickels, and quarters
dimefilter = MakeCircleMatchingFilter(filtsize, dimediameter);
quarterfilter = MakeCircleMatchingFilter(filtsize, quarterdiameter);
nickelfilter = MakeCircleMatchingFilter(filtsize, nickeldiameter);

% show the result
figure;
subplot(1,3,1); imagesc(dimefilter); colormap(gray); title('dime filter'); axis tight equal;
subplot(1,3,2); imagesc(nickelfilter); colormap(gray); title('nickel filter'); axis tight equal;
subplot(1,3,3); imagesc(quarterfilter); colormap(gray); title('quarter filter'); axis tight equal;

% Evaluate each of the 3 matching filters on each coin to serve as 3 feature measurements
D = zeros(length(centroid), 3);
for i = 1 : length(centroid)
	% compute local region
	local_region = msk_dil_erd(centroid(i, 2) - filtsizeh:centroid(i, 2) + filtsizeh, centroid(i, 1) - filtsizeh:centroid(i, 1) + filtsizeh);
	
	% compute correlation
	D(i,1) = corr(dimefilter(:), local_region(:));
	D(i,2) = corr(nickelfilter(:), local_region(:));
	D(i,3) = corr(quarterfilter(:), local_region(:));
end



%%%%% 3. Perform k-means clustering of features for unsupervised learning classifier

% apply k-means
rng(0);
[cls_init] = kmeans(D, 3);

% relabel centroid classes based on average size of the objects in each class. smallest will be dime, next nickel, and largest quarter
% first compute sum and number for every classes
c_sum = zeros(1, 3);
c_num = zeros(1, 3);

for i = 1:length(cls_init)
	if cls_init(i) == 1
		c_sum(1) = c_sum(1) + component_size(i);
		c_num(1) = c_num(1) + 1;
	elseif cls_init(i) == 2
		c_sum(2) = c_sum(2) + component_size(i);
		c_num(2) = c_num(2) + 1;
	else
		c_sum(3) = c_sum(3) + component_size(i);
		c_num(3) = c_num(3) + 1;
	end
end

% compute average for every classes
class_ave_object_size = zeros(length(c_sum), 1);

for i = 1:length(c_sum)
	class_ave_object_size(i, 1) = c_sum(i) / c_num(i);
end

% then find the sorting indices
[~, classmap] = sort(class_ave_object_size);

% relabel centroid classes
cls = zeros(length(centroid), 1);
for i = 1:length(centroid)
	if cls_init(i) == classmap(1)
		cls(i, 1) = 1;
	elseif cls_init(i) == classmap(2)
		cls(i, 1) = 2;
	else
		cls(i, 1) = 3;
	end
end

% visualize the result
figure; imagesc(im); colormap(gray); title('test image'); hold on; axis equal;

% plot circles around each coin with different color/diameter unique to each type and count the change
% compute total count and plot the coin
totcount = 0;
for i = 1:length(centroid)
	[coinvalue, ~, ~, ~] = AddCoinToPlotAndCount(centroid(i, 1), centroid(i, 2), cls(i));
	totcount = totcount + coinvalue;
end

title([num2str(totcount),' cents'])