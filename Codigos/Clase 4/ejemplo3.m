clc; clear;
pkg load image

A=imread('imagen2.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

B=imadjust(A); %Mejorar el contraste de grises de una imagen
subplot(1,2,2)
imshow(B)
title('Imagen con contraste mejorado')
