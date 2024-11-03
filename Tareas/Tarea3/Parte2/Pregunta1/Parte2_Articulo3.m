close all; clc; clear;
pkg load image;  % Cargar el paquete de procesamiento de imágenes, asegúrate de tenerlo instalado

num_subjects = 40;  % Número de sujetos
images_per_subject = 9;  % Número de imágenes por sujeto
image_size = [112, 92];  % Tamaño común de cada imagen (112x92 píxeles)

% Pre-allocating the matrix to hold all vectorized images
face_images = zeros(prod(image_size), num_subjects * images_per_subject);

index = 1;
for i = 1:num_subjects
    for j = 1:images_per_subject
        filename = sprintf('training/s%02d/%d.jpg', i, j);
        img = imread(filename);

        % Convertir a escala de grises si es necesario
        if size(img, 3) == 3
            img = rgb2gray(img);
        end

        % Redimensionar la imagen si es necesario
        img = imresize(img, image_size);

        % Convertir la imagen a un vector columna
        img_vector = img(:);

        % Añadir el vector columna a la matriz face_images
        face_images(:, index) = img_vector;
        index = index + 1;
    end
end

% Paso 1: Calcular la imagen media
mean_face = mean(face_images, 2);

% Paso 2: Sustraer la imagen media de todas las imágenes de entrenamiento
A = face_images - mean_face;

% Paso 3: Calcular SVD
[U, S, V] = svd(A, 'econ');  % 'econ' para economizar en el uso de memoria si M es mucho mayor que N

for i = 1:num_subjects
  filename = sprintf('compare/p%02d.jpg', i);
  new_image = double(imread(filename));

  % Paso 4: Proyectar una nueva imagen f en el espacio de caras
  f = new_image(:);  % Convertir la nueva imagen en un vector columna si aún no lo es
  f_normalized = f - mean_face;
  x = U' * f_normalized;  % Coordenadas de f en el espacio de caras

  % Paso 5: Clasificar la nueva imagen comparando la distancia con las proyecciones de las imágenes de entrenamiento
  projections = U' * A;  % Proyecciones de las imágenes de entrenamiento
  differences = bsxfun(@minus, projections, x);
  distances = sqrt(sum(differences.^2, 1));
  [min_distance, index] = min(distances);

  threshold = 1e4;

  % Cargar y mostrar imágenes
  figure;  % Crea una nueva ventana de figura
  subplot(1, 2, 1);
  imshow(new_image, []);
  title(['Imagen ' num2str(i)]);

  if min_distance < threshold
      % Calcular la posición del individuo reconocido en la matriz original
      subject_index = ceil(index / images_per_subject);
      image_index = mod(index, images_per_subject);
      if image_index == 0
          image_index = images_per_subject;
      end
      recognized_image_filename = sprintf('training/s%02d/%d.jpg', subject_index, image_index);
      recognized_image = imread(recognized_image_filename);

      subplot(1, 2, 2);  % Selecciona la segunda subfigura
      imshow(recognized_image);
      title(sprintf('Reconocido como Sujeto %02d, Imagen %d', subject_index, image_index));
  else
      subplot(1, 2, 2);  % Selecciona la segunda subfigura
      imshow(zeros(size(new_image)));  % Muestra una imagen en negro si no se reconoce
      title('No Reconocido');
  end
endfor
