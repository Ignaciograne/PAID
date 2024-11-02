pkg load image;

% Cargar la imagen original y la marca de agua
I = imread('imagen.jpg');
W = imread('marca.jpg');  % Asumiendo que W es 64x64

alpha = 0.001;  % Factor de ganancia

% Asegurar que los datos sean de tipo double para procesamiento
I = double(I);
W = double(W);

% Obtener dimensiones para procesamiento por bloques
[m, n] = size(I);
mb = m / 8;  % Número de bloques en la dimensión vertical
nb = n / 8;  % Número de bloques en la dimensión horizontal

% Inicializar matrices para los valores DCT
DCT_blocks = zeros(m, n);
DC = zeros(mb, nb);

% Aplicar DCT y recoger valores DC
% Aplicar IDCT y asegurar que los valores están en el rango 0-255
for i = 0:mb-1
    for j = 0:nb-1
        block = idct2(DCT_blocks(8*i+1:8*i+8, 8*j+1:8*j+8));
        % Recortar los valores a 0-255
        block = max(min(block, 255), 0);
        I_marked(8*i+1:8*i+8, 8*j+1:8*j+8) = block;
    end
end


% Aplicar SVD a los valores DC
[U, S, V] = svd(DC);
S = S + alpha * W;  % Modificar los valores singulares
DC_mod = U * S * V';

% Insertar los valores DC modificados de vuelta en los bloques DCT
for i = 0:mb-1
    for j = 0:nb-1
        DCT_blocks(8*i+1, 8*j+1) = DC_mod(i+1, j+1);
    end
end

% Aplicar IDCT para reconstruir la imagen
for i = 0:mb-1
    for j = 0:nb-1
        block = DCT_blocks(8*i+1:8*i+8, 8*j+1:8*j+8);
        I_marked(8*i+1:8*i+8, 8*j+1:8*j+8) = idct2(block);
    end
end

% Guardar la imagen con marca de agua
imwrite(uint8(I_marked), 'imagen_con_marca.png');

