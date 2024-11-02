clc; clear;

% Cargar y preparar los datos de entrenamiento
function [U, mean_face, known_faces] = prepare_training_data()
    num_subjects = 40;
    images_per_subject = 9;
    known_faces = cell(num_subjects * images_per_subject, 1);
    index = 1;

    % Leer todas las imágenes de cada sujeto
    for s = 1:num_subjects
        for img = 1:images_per_subject
            image_path = sprintf('training/s%02d/%d.jpg', s, img);
            img_matrix = imread(image_path);
            known_faces{index}.image = img_matrix;
            known_faces{index}.identity = sprintf('Subject%02d', s);
            index = index + 1;
        end
    end

    % Calcular la imagen media
    mean_face = zeros(size(known_faces{1}.image));
    for i = 1:length(known_faces)
        mean_face = mean_face + double(known_faces{i}.image);
    end
    mean_face = mean_face / length(known_faces);

    % Preparar una gran matriz con todas las imágenes para SVD
    all_faces = [];
    for i = 1:length(known_faces)
        all_faces = [all_faces, double(known_faces{i}.image(:))];
    end

    % Restar la imagen media
    all_faces = all_faces - mean_face(:);

    % Calcular SVD
    [U, S, V] = svd(all_faces, 'econ');
end

% Reconocer un rostro utilizando la información preparada
function identity = recognize_face(f, U, mean_face, known_faces, epsilon)
    a = double(f) - mean_face;  % Normalizar la imagen de entrada
    x = U' * a;  % Proyectar la imagen normalizada en el espacio de rostros

    min_distance = inf;
    identity = 'unknown';

    % Comparar con cada rostro conocido
    for i = 1:length(known_faces)
        known_face_vector = double(known_faces{i}.image) - mean_face;
        xi = U' * known_face_vector;
        distance = norm(x - xi);
        if distance < min_distance
            min_distance = distance;
            identity = known_faces{i}.identity;
        end
    end

    if min_distance > epsilon
        identity = 'unknown';
    end
end

% Ejemplo de uso del sistema de reconocimiento facial
[U, mean_face, known_faces] = prepare_training_data();
new_face = imread('compare/p10.jpg');
epsilon = 100;  % Definir un umbral apropiado
identity = recognize_face(new_face, U, mean_face, known_faces, epsilon);
fprintf('La identidad reconocida es: %s\n');

