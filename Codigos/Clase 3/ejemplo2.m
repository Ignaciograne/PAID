clc; clear;
%Cargar la imagen
A=imread('camarografo.jpg');
B=imread('fondo.jpg');

%Sumar imagenes
subplot(1,3,1)
imshow(A)
subplot(1,3,2)
imshow(B)
subplot(1,3,3)
imshow(A+B)

%Sumar ruido Gaussiano a una imagen

[m,n]=size(A) %Tamaño de una image

