pkg load image;

% Leer la imagen original y convertir a escala de grises
I = double(imread('imagen.jpg'));

% Leer y preparar la imagen de marca de agua
watermark = double(imread('marca.jpg'));

% Parámetro de ganancia
alpha = 0.05;

function [U, S, V, watermarked_image] = apply_water_mark(Image, Watermark, alpha)
    % Dividir en bloques de 8x8 y aplicar DCT
    DCT_blocks = blockproc(Image, [8 8], @(block) dct2(block));

    % Extraer valores DC y construir la matriz A
    A = blockproc(DCT_blocks, [8 8], @(block) block(1,1));

    % Aplicar SVD
    [U, S, V] = svd(A);

    % Modificar solo los valores singulares (diagonal de S)
    S_mod = S;
    S_mod(1:min(size(S), size(Watermark)), 1:min(size(S), size(Watermark))) = S_mod(1:min(size(S), size(Watermark)), 1:min(size(S), size(Watermark))) + alpha * Watermark;

    % Recomponer A modificado
    A_mod = U * S_mod * V';

    % Reemplazar los valores DC en los bloques DCT
    blocks = mat2cell(DCT_blocks, repmat(8, 1, size(Image,1)/8), repmat(8, 1, size(Image,2)/8));

    for i = 1:size(blocks,1)
        for j = 1:size(blocks,2)
            blocks{i,j}(1,1) = A_mod(i,j);
        end
    end

    DCT_blocks_mod = cell2mat(blocks);

    % Aplicar DCT inversa y obtener la imagen final
    watermarked_image = blockproc(DCT_blocks_mod, [8 8], @(block) idct2(block));
end


function watermark_extracted = remove_water_mark(Image, watermarked_image, alpha)
    % Inicializar la matriz de DCT extraída
    DCT_blocks_extracted = zeros(size(watermarked_image)) / alpha;

    block_size = 8;

    % Inicializar la marca de agua extraída
    watermark_extracted = zeros(size(Image)/block_size);

    % Procesar cada bloque de 8x8

    for i = 1:block_size:size(watermarked_image,1)
        for j = 1:block_size:size(watermarked_image,2)
            block = watermarked_image(i:i+block_size-1, j:j+block_size-1);
            DCT_block = dct2(block);

            % Recuperar la marca de agua del coeficiente DC
            watermark_extracted(ceil(i/block_size), ceil(j/block_size)) = (DCT_block(1,1) - dct2(Image(i:i+block_size-1, j:j+block_size-1))(1,1)) / alpha;
        end
    end
end


[U, S, V, watermarked_image] = apply_water_mark(I, watermark, alpha);
watermark_extracted = remove_water_mark(I, watermarked_image, alpha);



% Mostrar la imagen con marca de agua
figure;
subplot(2,2,1)
imshow(uint8(I))
title('Imagen original')

subplot(2,2,2)
imshow(uint8(watermark))
title('Marca de agua')

subplot(2,2,3)
imshow(uint8(watermarked_image))
title('Imagen con marca de agua')

subplot(2,2,4)
imshow(uint8(watermark_extracted));
title('Marca de Agua Extraída');

