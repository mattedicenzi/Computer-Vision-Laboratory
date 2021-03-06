%% Lab 4 - Color-based segmentation and Blob detection
% Marco Demutti
% 4389233
% Matteo Dicenzi
% 4342944

clear all
close all

%% Exercise 1 - Color-based segmentation

% Read all 6 RGB images
img1_rgb=imread('ur_c_s_03a_01_L_0376.png', 'png');
img2_rgb=imread('ur_c_s_03a_01_L_0377.png', 'png');
img3_rgb=imread('ur_c_s_03a_01_L_0378.png', 'png');
img4_rgb=imread('ur_c_s_03a_01_L_0379.png', 'png');
img5_rgb=imread('ur_c_s_03a_01_L_0380.png', 'png');
img6_rgb=imread('ur_c_s_03a_01_L_0381.png', 'png');

% Display all images in greyscale
figure,subplot(2,3,6)
subplot(2,3,1),imagesc(rgb2gray(img1_rgb)),colormap gray,title('Image 1 grayscale')
subplot(2,3,2),imagesc(rgb2gray(img2_rgb)),colormap gray,title('Image 2 grayscale')
subplot(2,3,3),imagesc(rgb2gray(img3_rgb)),colormap gray,title('Image 3 grayscale')
subplot(2,3,4),imagesc(rgb2gray(img4_rgb)),colormap gray,title('Image 4 grayscale')
subplot(2,3,5),imagesc(rgb2gray(img5_rgb)),colormap gray,title('Image 5 grayscale')
subplot(2,3,6),imagesc(rgb2gray(img6_rgb)),colormap gray,title('Image 6 grayscale')

% Convert RGB to HSV
img1_hsv=rgb2hsv(img1_rgb);
img2_hsv=rgb2hsv(img2_rgb);
img3_hsv=rgb2hsv(img3_rgb);
img4_hsv=rgb2hsv(img4_rgb);
img5_hsv=rgb2hsv(img5_rgb);
img6_hsv=rgb2hsv(img6_rgb);

% Split images in the three RGB and three HSV channels (stored in cells)
[img1_RGB_channels, img1_HSV_channels] = splitRGBandHSV(img1_rgb, img1_hsv);
[img2_RGB_channels, img2_HSV_channels] = splitRGBandHSV(img2_rgb, img2_hsv);
[img3_RGB_channels, img3_HSV_channels] = splitRGBandHSV(img3_rgb, img3_hsv);
[img4_RGB_channels, img4_HSV_channels] = splitRGBandHSV(img4_rgb, img4_hsv);
[img5_RGB_channels, img5_HSV_channels] = splitRGBandHSV(img5_rgb, img5_hsv);
[img6_RGB_channels, img6_HSV_channels] = splitRGBandHSV(img6_rgb, img6_hsv);

% Display RGB and HSV channels of each image
plotRGBandHSV(img1_RGB_channels, img1_HSV_channels, "Image 1");
plotRGBandHSV(img2_RGB_channels, img2_HSV_channels, "Image 2");
plotRGBandHSV(img3_RGB_channels, img3_HSV_channels, "Image 3");
plotRGBandHSV(img4_RGB_channels, img4_HSV_channels, "Image 4");
plotRGBandHSV(img5_RGB_channels, img5_HSV_channels, "Image 5");
plotRGBandHSV(img6_RGB_channels, img6_HSV_channels, "Image 6");

% Select dark car in image 1 for Hue component and display it
img1_Hue = img1_HSV_channels{1};
dark_car_Hue = img1_Hue(368:413,557:644);
figure, imagesc(dark_car_Hue), colormap gray, title('Dark car');

% Compute minThr and maxThr as m-0.4*s, m+0.4*s
mean_subimg_Hue = mean2(dark_car_Hue);
stdev_subimg_Hue = std2(dark_car_Hue);
minThr = mean_subimg_Hue - 0.4*stdev_subimg_Hue;
maxThr = mean_subimg_Hue + 0.4*stdev_subimg_Hue;

% Image 1: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
segmentedImage1 = doSegmentation(img1_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage1, img1_rgb, 'Image 1 dark car');

% Image 2: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img2_Hue = img2_HSV_channels{1};
segmentedImage2 = doSegmentation(img2_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage2, img2_rgb, 'Image 2 dark car');

% Image 3: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img3_Hue = img3_HSV_channels{1};
segmentedImage3 = doSegmentation(img3_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage3, img3_rgb, 'Image 3 dark car');

% Image 4: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img4_Hue = img4_HSV_channels{1};
segmentedImage4 = doSegmentation(img4_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage4, img4_rgb, 'Image 4 dark car');

% Image 5: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img5_Hue = img5_HSV_channels{1};
segmentedImage5 = doSegmentation(img5_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage5, img5_rgb, 'Image 5 dark car');

% Image 6: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img6_Hue = img6_HSV_channels{1};
segmentedImage6 = doSegmentation(img6_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage6, img6_rgb, 'Image 6 dark car');

% Repeat all steps for Red car
red_car_Hue=img1_Hue(352:429,678:784);
figure, imagesc(red_car_Hue), colormap gray, title('Red car');

% Suggested threshold values
minThr = 0.97;
maxThr = 1;

% Computation of different values of threshold
mean_subimg1_Hue2 = mean2(red_car_Hue);
stdev_subimg1_Hue2 = std2(red_car_Hue);
minThr2 = mean_subimg1_Hue2 - stdev_subimg1_Hue2;
maxThr2 = mean_subimg1_Hue2 + stdev_subimg1_Hue2;

% Image 1: segment red car and display centroid and bounding box in the 
% binary image and in the color image
segmentedImage1 = doSegmentation(img1_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage1, img1_rgb, 'Image 1 red car');

% Repeat using different treshold values
segmentedImage1 = doSegmentation(img1_Hue, minThr2, maxThr2);
plotSegCentroidBoundaryBox(segmentedImage1, img1_rgb, 'Image 1 red car, computed with different treshold values');

% Repeat procedure for all the other images (using only minThr, maxThr)
segmentedImage2 = doSegmentation(img2_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage2, img2_rgb, 'Image 2 red car');

segmentedImage3 = doSegmentation(img3_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage3, img3_rgb, 'Image 3 red car');

segmentedImage4 = doSegmentation(img4_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage4, img4_rgb, 'Image 4 red car');

segmentedImage5 = doSegmentation(img5_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage5, img5_rgb, 'Image 5 red car');

segmentedImage6 = doSegmentation(img6_Hue, minThr, maxThr);
plotSegCentroidBoundaryBox(segmentedImage6, img6_rgb, 'Image 6 red car');

%% Exercise 2
img=imread('sunflowers.png');
start_sigma = 1;
sigmaIncrease = 1.5;
numbOfScale = 10;
radius = 10;

[scale_space,radii] = computeScale(img,start_sigma,sigmaIncrease,numbOfScale);

% Focus on given sunflowers
ssSunflower1 = scale_space(386,458,:);
ssSunflower2 = scale_space(361,166,:);

figure,subplot(2,2,1),plot(squeeze(ssSunflower1),'*-')
title('Laplacian response for sunflower 1')

subplot(2,2,2),plot(squeeze(ssSunflower2),'*-');
title('Laplacian response for sunflower 2')

[~,val1]=max(ssSunflower1); % characteristic scale
% Compute characteristic scale value in pixels for the first sunflower
pixelSize1=ceil(sqrt(2)*radii(val1));

subplot(2,2,3),imagesc(img),colormap gray,hold on,
show_all_circles(img, 458, 386, pixelSize1)
title("evidencing sunflower 1 with characteristic scale pixel value = "+pixelSize1)
plot(458,386,'r*');

% Repeat for the other sunflower
[~,val2]=max(ssSunflower2);
pixelSize2=ceil(sqrt(2)*radii(val2));

subplot(2,2,4),imagesc(img),colormap gray,hold on
show_all_circles(img, 166, 361, pixelSize2)
title("evidencing sunflower 2 with characteristic scale pixel value = "+pixelSize2);
plot(166,361,'r*');

