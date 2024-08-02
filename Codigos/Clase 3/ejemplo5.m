clc; clear;

%Como obtener una imagen binaria

A=imread('lena.jpg');

An = double(A);
C = uint8(-An+255);
subplot(1,2,1)
imshow(A)
title('Imagen original')

subplot(1,2,2)
imshow(C)
title('Imagen negativa')
