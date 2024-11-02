clc; clear;
pkg load image;

function svdi = compute_svdi(original_image, distorted_image, block_size)
  % Asegurarse de que las imágenes estén en escala de grises y del mismo tamaño
  assert(ndims(original_image) == 2 && ndims(distorted_image) == 2);
  assert(all(size(original_image) == size(distorted_image)));

  [rows, cols] = size(original_image);
  svdi = 0;
  num_blocks = 0;

  % Iterar sobre los bloques de la imagen
  for i = 1:block_size:rows-block_size+1
    for j = 1:block_size:cols-block_size+1
      % Extraer bloques de la imagen original y distorsionada
      block_original = original_image(i:i+block_size-1, j:j+block_size-1);
      block_distorted = distorted_image(i:i+block_size-1, j:j+block_size-1);

      % Calcular SVD para ambos bloques
      [Uo, So, Vo] = svd(double(block_original));
      [Ud, Sd, Vd] = svd(double(block_distorted));

      % Calcular la distancia entre los valores singulares de los bloques
      distance = norm(diag(So) - diag(Sd));

      % Acumular el error total
      svdi = svdi + distance;
      num_blocks = num_blocks + 1;
    end
  end

  % Normalizar el SVDI dividiendo por el número de bloques
  svdi = svdi / num_blocks;
end


function c = hqi(A, B)
    % A y B son imágenes a escala de grises.
    % c es el valor de HQI.

    % Tamaño de la imagen
    [M, N] = size(A);

    % Obtener histogramas
    h_A = imhist(A);
    h_B = imhist(B);

    % Calcular el vector de diferencias Delta j
    delta_j = abs(h_A - h_B);

    % Calcular Delta TC
    Delta_TC = sum(delta_j);

    % Calcular Delta TC Factor
    Delta_TC_Factor = 1 - (Delta_TC / (2 * M * N));

    % Calcular HD (correlación entre histogramas)
    HD = sum(h_A .* h_B) / sum(h_A .^ 2);;

    % Calcular HQI
    c = Delta_TC_Factor * HD;
end


original = 'imOrig.jpg';
original_Image = imread(original);
files = dir('*.jpg');

fprintf('------------------------------------------------------------------');
display('');
fprintf('|   Imagen   |'); fprintf('  SSIM  |'); fprintf('  HQI  |'); fprintf('  SVDI  |');
display('');
fprintf('------------------------------------------------------------------');
display('');

% Definir el tamaño de bloque
block_size = 8;


for i = 1:length(files)
    filename = files(i).name;
    fprintf('| %s |', filename);


    mod_image = imread(filename);

    % Function calls
    fprintf('%d |', ssim_val = ssim(original_Image, mod_image));
    fprintf('%d |', c = hqi(original_Image, mod_image));
    fprintf('%d |', svdi = compute_svdi(original_Image, mod_image, block_size));



    display('');
    fprintf('------------------------------------------------------------');
    display('');
end
