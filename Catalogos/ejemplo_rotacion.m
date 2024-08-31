pkg load image

% Carga de la imagen original
A = imread('barbara.jpg'); % Asume formato de 8 bits
A = imresize(A, [128 128]); % Ejemplo de tamaño

% Mostrar la imagen original
subplot(1,3,1);
imshow(A);
title('Imagen Original');

% Escalamiento
s_x = 0.5; % Escalar filas a la mitad
s_y = 1.5; % Escalar columnas en un 50% más

% Aplicar el escalamiento
B = imresize(A, [floor(size(A, 1) * s_x) floor(size(A, 2) * s_y)]);

% Mostrar la imagen escalada
subplot(1,3,2);
imshow(B);
title('Imagen Escalada');

% Crear una nueva imagen del tamaño original con fondo negro o un color de fondo
C = zeros(size(A, 1), size(A, 2), 3, 'uint8');

% Calcular inicio para centrar la imagen escalada en el marco original
inicio_x = round((size(C, 1) - size(B, 1)) / 2) + 1;
inicio_y = round((size(C, 2) - size(B, 2)) / 2) + 1;

% Asegurar que los índices no son negativos
inicio_x = max(inicio_x, 1);
inicio_y = max(inicio_y, 1);

% Calcular fin, asegurando no exceder dimensiones de C
fin_x = min(inicio_x + size(B, 1) - 1, size(C, 1));
fin_y = min(inicio_y + size(B, 2) - 1, size(C, 2));

% Insertar la imagen escalada en la nueva imagen
C(inicio_x:fin_x, inicio_y:fin_y, :) = B(1:(fin_x-inicio_x+1), 1:(fin_y-inicio_y+1), :);

% Mostrar la imagen ajustada al marco original
subplot(1,3,3);
imshow(C);
title('Imagen Ajustada al Marco Original');

