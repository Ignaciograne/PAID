% Tipo de formartos de imagenes
% en octave y como trabajar con
% ellos

clc; clear;
pkg load image

A=imread('bote.jpg');
%imshow(A)

Ab=A(1:5,1:5) %En formato de 8 bits
A1=double(Ab) %Cambiar de formato a double
A2=im2double(Ab) %Cambiar a formato double y normalizar
A3=im2uint8(A2) %Desnormalizar y convertir a formato de 8 bits


%Nota: Cuando se hacen operaciones matematicas, se recomienda
%      convertir a la imagen usando elcomando im2double


