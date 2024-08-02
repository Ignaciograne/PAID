clc; clear
pkg load image

A=imread('imagen1.jpg');
subplot(1,3,1)
imshow(A)
title('Imagen original')

%Eliminar ruido (Sal y Pimienta) de una imagen
Y=imnoise(A,'salt & pepper',0.05);
subplot(1,3,2)
imshow(Y)
title('Imagen con ruido sal y pimienta')

%Limpiar ruido sal y pimienta
Z = medfilt2(Y); %Limpiar imagen con filtro de la mediana
subplot(1,3,3)
imshow(Z)
title('Imagen limpiada')



