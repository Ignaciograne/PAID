clc; clear;
pkg load image

A=imread('imagen3.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

%B = edge(A, 'Canny'); %Detectar bordes de una imagen
%subplot(1,2,2)
%imshow(B);
%title('Imagen con bordes resaltados')

% Segmentar imagen
B = graythresh(A); %Calcular un umbral C de la escala de grises de la imagen A
C = im2bw(A, B); %Segmentar la imagen A, usando el umbral C
subplot(1,2,2)
imshow(C);
title('Imagen segmentada')
