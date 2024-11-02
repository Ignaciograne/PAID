%Ejemplo del metodo de Otsu con un umbral
clc; clear; close all
pkg load image
A=imread('imagen3.jpg');
subplot(1,3,1)
imshow(A)
title('Imagen original A')

%Metodo de Otsu
T=metodo_otsu(A)

%Mostrar la imagen
D=zeros(size(A));
D(A>T)=1;
D(A<=T)=0;
subplot(1,3,2)
imshow(D)
title(['Umbral Simple Otsu T=' num2str(T)])

%Metodo de Otsu doble
[T1, T2]=metodo_otsu_doble(A)

%Mostrar la imagen
E = zeros(size(A));
E(A <= T1) = 0; % Clase 1
E(A > T1 & A <= T2) = 0.5; % Clase 2
E(A > T2) = 1; % Clase 3
subplot(1,3,3)
imshow(E)
title(['Umbral Doble Otsu T1=' num2str(T1) ' T2=' num2str(T2)])

