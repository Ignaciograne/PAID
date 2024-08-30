% Ejemplo de convolucion matricial, aplicado a imagenes
clc;clear;

A=im2double(imread('cameraman.jpg')); %256x256
B=1/9*ones(3); %3x3

%Z=conv2(A,B); %(256+3-1)=258 -> 258x258
Z=conv2(A,B); %Z es del mismo tamanho de A

subplot(1,2,1)
imshow(A)
title('Imagen original')

subplot(1,2,2)
imshow(Z)
title('Imagen convolucionada')



