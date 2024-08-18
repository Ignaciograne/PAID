pkg load image

A=imread('peppers.jpg');
subplot(2,2,1)
imshow(A)
title('Imagen original')

subplot(2,2,2)
imhist(A)
title('Histograma de la imagen original')

A=double(A);
r_min=min(min(A))
r_max=max(max(A))
s_min=r_min+70 % s_min debe ser más grande que r_min
s_max=r_max-70 % s_max debe ser más pequeño que r_max

% Operacion de Estiramiento
B=((s_max-s_min)/(r_max-r_min))*(A-r_min)+s_min;
B=uint8(B);

subplot(2,2,3)
imshow(B)
title('Imagen reducida')

subplot(2,2,4)
imhist(B)
title('Histograma de la imagen reducida')
