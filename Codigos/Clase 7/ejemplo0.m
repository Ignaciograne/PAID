pkg load image

%I=rgb2gray(imread('imagen_oscura.jpg'));
I=imread('sydney.jpg');
subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imhist(I)
