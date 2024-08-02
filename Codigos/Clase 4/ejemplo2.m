clc; clear;
pkg load image

A=imread('imagen4.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

B=rgb2gray(A); %Nos permite pasar de color a escala de grises
subplot(1,2,2)
imshow(B)
title('Imagen en escala de grises')


