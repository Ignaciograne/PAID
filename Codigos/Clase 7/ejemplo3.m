pkg load image

A=imread('peppers.jpg');
subplot(1,2,1)
imshow(A);
title('Imagen original')

% Forma 3 de calcular el histograma
subplot(1,2,2)
imhist(A)
title('Histograma')
