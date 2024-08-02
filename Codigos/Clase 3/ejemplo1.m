clc; clear;
%Cargar la imagen
A=imread('camarografo.jpg');

%Informacion de la imagen
imfinfo('camarografo.jpg');

%Tipo de formato
class(A) %uni8 -> 8 Bits

%Guardar imagen
imwrite(A,'camarografoBMP.bmp')

%Mostrar un imagen
subplot(1,2,1) %[X _]
imshow(A)
title('Imagen Camarografo')

% Operaciones basica con imagenes

% Suma

B=A+150; % Sumar a cada pixel de A el valor de 20

subplot(1,2,2) %[_ X]
imshow(B)
title('Imagen Modificada')


