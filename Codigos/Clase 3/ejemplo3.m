clc; clear;


%Cargar la imagen
A=imread('camarografo.jpg');

%Sumar ruido Gaussiano a una imagen
% Se recomienda normalizar y cambiar de formato
% la imagen

[m,n]=size(A); %Tamaño de una image
N=0.2*randn(m,n);

An=im2double(A); %Normalizar ([0,1]) y cambiar la tipo de variable

B=An+N;

subplot(1,2,1)
imshow(A)
title('Imagen Original')

%Despues de alguna operacion matematica,
%Se recomienda volver a convertir la imagen
%resultante en el formato de 8 bits

pkg load image %Cargar el paquete de procesamiento de imagenes
C=im2uint8(B); %Convierte a 8 bits

subplot(1,2,2)
imshow(C)
title('Imagen con Ruido')

imwrite(C,'imagen_ruido.jpg')


