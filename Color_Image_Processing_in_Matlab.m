close all;

%Reading an original images
original_image_1 = imread('images7.jpg');
original_image_2 = imread('images1.jpg');

%Getting the hsv image
hsv_image_1 = rgb2hsv(original_image_1);
hsv_image_2 = rgb2hsv(original_image_2);

%Getting the gray image from RGB
gray_RGB = rgb2gray(original_image_1);

%Getting the gray image from HSV
gray_hsv = rgb2gray(hsv_image_1);

%Showing the resulted four images #1
figure(1);
subplot(2,2,1), imshow(original_image_1), title('Original image #1');
subplot(2,2,2), imshow(hsv_image_1), title('HSV image #1');
subplot(2,2,3), imshow(gray_RGB), title('Gray image from RGB #1');
subplot(2,2,4), imshow(gray_hsv_1), title('Gray image from HSV #1');

%Showing the resulted two images #2
figure(2);
subplot(1,2,1), imshow(original_image_2), title('Original image #2');
subplot(1,2,2), imshow(hsv_image_2), title('HSV image #2');

%Pceudo-color
gray_to_ind_1 = gray2ind(gray_RGB,256);
pceudo_1 = ind2rgb(gray_to_ind_1, colormap(hsv(256)));

gray_to_ind_2 = gray2ind(rgb2gray(original_image_2),256);
pceudo_2 = ind2rgb(gray_to_ind_2, colormap(hsv(256)));

figure(3);
subplot(2,2,1), imshow(original_image_1), title('Original image #1');
subplot(2,2,2), imshow(pceudo_1), title('Pceudo-color image #1');
subplot(2,2,3), imshow(original_image_2), title('Original image #2');
subplot(2,2,4), imshow(pceudo_2), title('Pceudo-color image #2');

%Luminance
rgb_brightening = im2double(original_image_1);
rgb_brightening(:,:,1) = rgb_brightening(:,:,1) + 0.3;
rgb_brightening(:,:,2) = rgb_brightening(:,:,2) + 0.3;
rgb_brightening(:,:,3) = rgb_brightening(:,:,3) + 0.3;

histogram_equalization(:,:,1) = histeq(original_image_1(:,:,1));
histogram_equalization(:,:,2) = histeq(original_image_1(:,:,2));
histogram_equalization(:,:,3) = histeq(original_image_1(:,:,3));

%Showing the resulted three images
figure(4);
subplot(1,3,1), imshow(original_image_1), title('Original image');
subplot(1,3,2), imshow(rgb_brightening), title('RGB brightening');
subplot(1,3,3), imshow(histogram_equalization), title('RGB Histogram Equalization');

bright_hsv = hsv_image_1;
bright_hsv(:,:,3) = bright_hsv(:,:,3) + 0.2;
hsv_equalization = hsv_image_1;
hsv_equalization(:,:,3) = histeq(hsv_equalization(:,:,3));

%Showing the resulted three images
figure(5);
subplot(1,3,1), imshow(original_image_1), title('Original image');
subplot(1,3,2), imshow(bright_hsv), title('HSV brightening');
subplot(1,3,3), imshow(hsv_equalization), title('HSV Histogram Equalization');

%Segmentation
segmented_image = imread('Example7.jpg');
[n,m,~] = size(segmented_image);

%rgb color cutting
bg = [0;0;0];
color = zeros(3,1);
color(1:3) = segmented_image(174,174,:);
val = zeros(3,1);
threshold = 27;
rgb_cut = segmented_image;
for i =1:n
for j=1:m
val(1:3) = segmented_image(i,j,1:3);
if(norm (val-color)>threshold)
rgb_cut(i,j,1:3) =bg; end;
end;
end;

%hsv color cutting
segmented_image_hsv = rgb2hsv(segmented_image);
[n,m,k] = size(segmented_image_hsv);
bg = [0;0;0];
hue = segmented_image_hsv(174,174,1);
threshold = 0.015;
hsv = segmented_image_hsv;
for i =1:n
for j=1:m
val = segmented_image_hsv(i,j,1);
if(norm (val-hue)>threshold)
hsv(i,j,1:3) = bg; end;
end;
end;

%Showing the resulted three images
figure(6);
subplot(1,3,1); imshow(segmented_image); title('Original image');
subplot(1,3,2); imshow(rgb_cut); title('RGB cutting');
subplot(1,3,3); imshow(hsv2rgb(hsv)); title('HSV cutting');
