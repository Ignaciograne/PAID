% Supongamos que 'face_images' es una matriz donde cada columna es una imagen de rostro (ya vectorizada).
% N es el número de imágenes y M es el número de píxeles en cada imagen (m * n = M).
pkg load image;  % Cargar el paquete de procesamiento de imágenes, asegúrate de tenerlo instalado

num_subjects = 40;  % Número de sujetos
images_per_subject = 9;  % Número de imágenes por sujeto
image_size = [112, 92];  % Tamaño común de cada imagen (por ejemplo, 112x92 píxeles)

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

new_image = double(imread('compare/p1.jpg'));

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

if min_distance < threshold  % 'threshold' es un umbral predefinido
    fprintf('La imagen corresponde al individuo %d\n', index);
else
    fprintf('La imagen no corresponde a ningún individuo conocido\n');
end

