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
figure,subplot(236)
subplot(231),imagesc(rgb2gray(img1_rgb)),colormap gray,title('Image 1 grayscale')
subplot(232),imagesc(rgb2gray(img2_rgb)),colormap gray,title('Image 2 grayscale')
subplot(233),imagesc(rgb2gray(img3_rgb)),colormap gray,title('Image 3 grayscale')
subplot(234),imagesc(rgb2gray(img4_rgb)),colormap gray,title('Image 4 grayscale')
subplot(235),imagesc(rgb2gray(img5_rgb)),colormap gray,title('Image 5 grayscale')
subplot(236),imagesc(rgb2gray(img6_rgb)),colormap gray,title('Image 6 grayscale')

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

% Image 1: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
segmentedImage1 = doSegmentation(img1_Hue, dark_car_Hue);
plotSegCentroidBoundaryBox(segmentedImage1, img1_rgb, 'Image 1 dark car');

% Image 2: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img2_Hue = img2_HSV_channels{1};
segmentedImage2 = doSegmentation(img2_Hue, dark_car_Hue);
plotSegCentroidBoundaryBox(segmentedImage2, img2_rgb, 'Image 2 dark car');

% Image 3: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img3_Hue = img3_HSV_channels{1};
segmentedImage3 = doSegmentation(img3_Hue, dark_car_Hue);
plotSegCentroidBoundaryBox(segmentedImage3, img3_rgb, 'Image 3 dark car');

% Image 4: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img4_Hue = img4_HSV_channels{1};
segmentedImage4 = doSegmentation(img4_Hue, dark_car_Hue);
plotSegCentroidBoundaryBox(segmentedImage4, img4_rgb, 'Image 4 dark car');

% Image 5: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img5_Hue = img5_HSV_channels{1};
segmentedImage5 = doSegmentation(img5_Hue, dark_car_Hue);
plotSegCentroidBoundaryBox(segmentedImage5, img5_rgb, 'Image 5 dark car');

% Image 6: segment dark car and display centroid and bounding box in the 
% binary image and in the color image
img6_Hue = img6_HSV_channels{1};
segmentedImage6 = doSegmentation(img6_Hue, dark_car_Hue);
plotSegCentroidBoundaryBox(segmentedImage6, img6_rgb, 'Image 6 dark car');

%% Exercise 2
img=imread('sunflowers.png');
%figure,imagesc(img),colormap gray
sigma=1;
sigmaIncrease=1.5;
numbOfScale=10;
radius=10;

[scale_space,radii]=computeScale(img,sigma,sigmaIncrease,numbOfScale);

ssSunflower1 = scale_space(386,458,:);
ssSunflower2 = scale_space(361,166,:);

figure,subplot(2,1,1),plot(squeeze(ssSunflower1),'*-')
title('Laplacian response for sunflower 1')

subplot(2,1,2),plot(squeeze(ssSunflower2),'*-');
title('Laplacian response for sunflower 2')

figure,imagesc(img),colormap gray,title('Image 1 with focus on sunflowers')
hold on
plot(458,386,'r*');
plot(166,361,'r*');

[~,val1]=max(ssSunflower1);
% show_all_circles(img, 458, 386, 1.41*val, 'r', 1),
figure,imagesc(img),colormap gray,hold on,title('Characteristic scale values')
%rectangle('Position',[458-1.41*val 386-1.41*val 2*1.41*val 2*1.41*val],'EdgeColor',[1,0,0],'lineWidth',2); %versione nostra
rectangle('Position',[420 340 90 75],'EdgeColor',[1,0,0],'lineWidth',2); %versione foto lab prof

[~,val2]=max(ssSunflower2);
rectangle('Position',[140 335 50 50],'EdgeColor',[0,0,1],'lineWidth',2);

pixelSize1=ceil(sqrt(2)*val1);
pixelSize2=ceil(sqrt(2)*val2);
text(400,100, "pixel value = "+pixelSize1,'Color','red','FontSize',15);
text(100,100, "pixel value = "+pixelSize2,'Color','blue','FontSize',15);