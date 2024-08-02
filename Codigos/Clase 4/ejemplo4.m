clc; clear;
pkg load image

A=imread('imagen1.jpg'); %Es de tamaño 512 x 512
subplot(1,2,1)
imshow(A)
title('Imagen original')

B=imrotate(A,45); %Es de tamaño 256 x 256
subplot(1,2,2)
imshow(B)
title('Imagen rotada')


