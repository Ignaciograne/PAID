% Ejemplo filtro Paso Bajo (Promedio)


clc;clear;

A=im2double(imread('woman.jpg'));
subplot(1,3,1)
imshow(A)
title('Imagen Original')

% Filtro del Promedio (5x5)
B1=1/25*ones(5); %5x5
Z1=zeros(size(A));
for k=1:3
  Z1(:,:,k)=conv2(A(:,:,k),B1,'same'); %Z es del mismo tamanho de A
end
subplot(1,3,2)
imshow(Z1)
title('Imagen Filtro del Promedio')

% Filtro del Gaussiano (5x5)
B2=1/256*[1 4 6 4 1;
          4 16 24 16 4;
          6 24 36 24 6;
          4 16 24 16 4;
          1 4 6 4 1]; %5x5
Z2=zeros(size(A));
for k=1:3
  Z2(:,:,k)=conv2(A(:,:,k),B2,'same'); %Z es del mismo tamanho de A
end
subplot(1,3,3)
imshow(Z2)
title('Imagen Filtro Gaussiano')
