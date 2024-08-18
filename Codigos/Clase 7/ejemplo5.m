pkg load image

A=imread('sydney.jpg');
subplot(2,2,1)
imshow(A)
title('Imagen original')

subplot(2,2,2)
imhist(A)
title('Histograma de la imagen original')

A=double(A);
r_min=min(min(A)); r_max=max(max(A));

% Operacion de Estiramiento
B=floor(255/(r_max-r_min))*(A-r_min);
B=uint8(B);

subplot(2,2,3)
imshow(B)
title('Imagen estirada')

subplot(2,2,4)
imhist(B)
title('Histograma de la imagen estirada')
