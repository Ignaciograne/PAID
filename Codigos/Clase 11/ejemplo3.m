% Ejemplo filtro Paso Bajo (Promedio)


clc;clear;

A=im2double(imread('woman.jpg'));
subplot(1,2,1)
imshow(A)
title('Imagen original')

% Filtro del Promedio (5x5)
B1=1/25*ones(5); %5x5
Z1=zeros(size(A));
for k=1:3
  Z1(:,:,k)=conv2(A(:,:,k),B1,'same'); %Z es del mismo tamanho de A
end
subplot(1,2,2)
imshow(Z1)
title('Imagen con filtro del promedio')

