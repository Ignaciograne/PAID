# PAID
Apuntes del curso Procesamiento y Análisis de Imágenes Digitales

## Tabla de contenidos
- [Clase 1](#clase-1)
- [Clase 2](#clase-2)
- [Clase 3](#clase-3)
- [Clase 4](#clase-4)
- [Clase 5](#clase-5)
- [Clase 6](#clase-6)
- [Clase 7](#clase-7)
- [Clase 8](#clase-8)
- [Clase 9](#clase-9)
- [Clase 10](#clase-10)
- [Clase 11](#clase-11)
- [Clase 12](#clase-12)
- [Clase 13](#clase-13)
- [Clase 14](#clase-14)
- [Clase 15](#clase-15)
- [Clase 16](#clase-16)
- [Clase 17](#clase-17)
- [Clase 18](#clase-18)
- [Clase 19](#clase-19)
- [Clase 20](#clase-20)
- [Clase 21](#clase-21)
- [Clase 22](#clase-22)
- [Clase 23](#clase-23)
- [Clase 24](#clase-24)
- [Clase 25](#clase-25)
- [Clase 26](#clase-26)
- [Clase 27](#clase-27)
- [Clase 28](#clase-28)
- [Clase 29](#clase-29)
- [Clase 30](#clase-30)
- [Clase 31](#clase-31)
- [Clase 32](#clase-32)


## Clase 1
Introducción

## Clase 2
Feriado

## Clase 3
¿Qué es una imagen? Una representación bidimensional de un objeto (o una escena), el cual se obtiene a través de una cámara, escaner, resonancia magnetica, sensores, entre otros. Al medio por el cual se obtiene se denomina sistema.

Para efectos de este curso, estudiaremos la representación de imágenes a través de una computadora. Dicha representación se realiza a través de un "muestreo" del objeto, y dicho muestreo se almacena en un arreglo discreto bidimensional (matriz). Esto porque, al fin y al cabo, toda imagen se representa como una matriz I de tamaño mxn, donde cada I(i, j) corresponde a un pixel (también denominado entrada).

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/ImagenContinuaVsImageDiscreta.png)

En este curso, también, se estarán estudiando principalmente imágenes a escala de grises e imágenes a color usando el modelo RGB en formato de 8 bits (Nota: Cuidado con OpenCV, ya que suele cargar las imágenes en formato BGR y no RGB). En este formato, y para imágenes en escala de grises, cada uno de los pixeles puede ir desde 0 hasta 255.

Para convertir una imagen de BGR a RGB:
```Python
import cv2

# Leer la imagen
A = cv2.imread('img.jpeg')

# Convertir el formato de imagen
A = cv2.cvtColor(A, cv2.COLOR_BGR2RGB)
```

Para imágenes a color, cada uno de los pixeles no es un número, sino que cada pixel representa tres números para las tonalidades rojo, verde y azul, respectivamente. La combinación de cada una de estas intensidades da como resultado un color para cada pixel.
Cada pixel puede, entonces, tomar 256^3 = 16777216 tonalidades de color diferentes. 

Con Octave:
```Octave
clc; % Para limpiar ventana de comandos
clear; % Para limpiar las variables

% Cargar la imagen
A = imread('img.jpg');

% Información de la imagen
imfinfo('img.jpg')

% Tipo de formato
class(A)

% Mostrar la imagen
imshow(A)
tite('Mi imagen') % Colocarle un título

% Guardar imagen en otro formato
imwrite('A', 'imgBMP.bmp')
```

Con respecto a formatos:
El formato en cuestión lo que hace es determinar el algoritmo. Por ejemplo, para una imagen 256x256 en JPG, dicha imagen debería de guardar, en principio, 65536 pixeles. No obstante, no lo hace. Lo comprime y solamente guarda unas 10 k (por decir algo) y luego, mediante el algoritmo de JPG, reconstruye para mostrar el resto de los pixeles que no fueron nunca guardados.
JPG es entonces famoso por guardar imágenes que ocupen poco espacio y tengan una calidad decente. PNG, por su parte, toma un poco más de espacio pero permite una mejor calidad. En general, el formato se va a encargar de determinar cuántos pixeles guardar y cómo reconstruir los faltantes (mediante qué algoritmo).

### Para mostrar varias imágenes en un mismo plot:
```Octave
subplot(1,2,1) % [X _]
imShow(A)
title('Mi imagen 1')

subplot(1,2,2) % [_ X]
imshow(B)
title('Mi imagen 2')
```

### Tipo de formato de imágenes en Octave y cómo trabajar con ellos
```Octave
pkg load image % Necesario para utilizar im2uint8. Es el paquete de procesamiento de imágenes

A = imread('img.pg')

A1 = double(A); % Cambiar a formato double --> Hay que tener cuidado con este porque al
                %                              tener en formato decimal, lo entiende como
                %                              números de 0 a 1, y como los pixeles tienen
                %                              valores del tipo 125.25 entonces al ser
                %                              mayores que 1 los tira todos en blanco y
                %                              parece que no se muestra más que un fondo blanco
A2 = im2double(A); % Cambiar a formato double y normalizar
A3 = im2uint8(A2); % Desnormaliza y convierte a formato de 8 bits

% Nota: Cuando se hacen operaciones matemáticas, se recomienda convertir la imagen usando el comando im2double
```

### Sumar valores numéricos a una imagen
```Octave
% Suma: Le suma el valor en cuestión (en este caso, 20) a cada pixel de la imagen, por lo que se aclara la misma
B = A + 20;

% Resta: Le resta el valor en cuestión (en este caso, 20) a cada pixel de la imagen, por lo que se oscurece la misma
B = A - 20

imshow(B)
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/SumaImagen.png)

<br></br>

### Sumar imágenes entre sí
```Octave
A = imread('img1.jpg')
B = imread('img2.jpg')

subplot(1,3,1)
imshow(A)
subplot(1,3,2)
imshow(B)
subplot(1,3,3)
imshow(A+B) % Se suman las tonalidades
% También es posible hacer algo como A+B-50 (donde el 50 puede ser cualquier otro número)
% para combinar las imágenes sin que "se pierda información", ya que no llegará a la barrera
% del 255 y no se "sobreaclarará".
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/SumaImagenes.png)

<br></br>

### Sumar ruido Gaussiano a una imagen
```Octave
pkg load image 

A = imread('img.jpg')

% Sumar ruido Gaussiano a una imagen
% Se recomienda normalizar y cambiar de formato la imagen
[m,n] = size(A);
N = randn(m,n);
% Y si yo quisiera disminuir un poco el ruido puedo N = 0.2*randn(m,n);

An = im2double(A); % Se normaliza y se cambia el tipoo de variable

B = An+N;

imshow(B)

% Después de alguna operación matemática, se recomienda volver a convertir la 
% imagen resultante en el formato de 8 bits

C = im2uint8(B); % Convertir a 8 bits
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/RuidoGaussianoImagen.png)

<br></br>

### Negativo de una imagen 
Consiste en, para una imagen I, aplicar In = -I+255:
```Octave
A = imread('img1.jpg');

An = double(A);
C = uint8(-An+255);
subplot(1,2,1)
imshow(A)

subplot(1,2,2)
imshow(C)
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/NegativoImagen.png)

<br></br>

### Imagen binaria 
Se toma un número arbitrario y se compara con todos los pixeles de la imagen para determinar si son 
mayores o menores al número en cuestión:
```Octave
A = imread('img.jpg')
subplot(1,2,1)
imshow(A)
title('Imagen original')

[m,n] = size(A);
alpha = 127;
C = zeros(m,n);
for i = 1:m
  for j=1:n
    if A(i,j) <= alpha
      C(i,j) = 0;
    else
      C(i,j) = 255;
    end
  end
end

subplot(1,2,2)
imshow(V)
title('Imagen binaria')
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/BinarioImagen.png)

<br></br>


## Clase 4
Vamos a ver algunas funciones extra en Octave...

### Introducir y/o eliminar ruido
```Octave
pkg load image % Para utilizar imnoise

A = imread('img1.jpg')
subplot(1,3,1)
imshow(A)

% Incorporar ruido (sal y pimienta) a una imagen
% El ruido sal y pimienta consiste en quitar algunos pixeles de la imagen original
% y reemplazarlos con pixeles completamente negros o complemente blancos.
Y = imnoise(A, 'salt & pepper', 0.05)
subplot(1,3,2)
imshow(Y)

% Eliminar ruido (sal y pimienta) de una imagen
Z = medfil2(Y); % Limpiar imagen con filtro de la mediana
subplot(1,3,3)
imshow(Z)
```

* Poner imagen aquí *

Aunque la primera y la última imagen sean idénticas, visualmente hablando, en realidad no lo son.

Por ello, se mide el error como:
```Octave
% Error: |A - Z| (La diferencia entre la teórica y la experimental)

% MSE (Mean Squared Error): Compara pixel por pixel
er1 = norm(A-Z, 'fro') % Aplicando la norma de Frobenius. No obstante, esto da error,
                       % debido al formato de 8 bits de la imagen. Por ello, se debe
                       % de convertir a una imagen normalizada.
er1 = norm(im2double(A) - im2double(Z), 'frob') % ¡Forma correcta!
                                                % La idea es buscar que el error sea lo más pequeño posible.

% SSIM (Structural Similarity Index Measure): Compara la estructura general de la imagen
% (Para usar esta se debe de colocar la función que nos pasó el profesor en el mismo directorio que nuestro código).
er2 = ssim(A,Z) % Da valores [-1, 1], donde si dos imágenes son muy parecidas, el resultado tiende a 1.
```

### Cambiar imagen de color a blanco y negro
```Octave
A = imread('img.jpg');
% Yo puedo ejecutar size(A) lo cual me retorna tres cosas:
% - Número de pixeles horizontales de la imagen.
% - Número de pixeles verticales de la imagen.
% - Número de canales. Si me dice 3 canales, es un RGB. Si me dice 1, está en escala de grises.

subplot(1,2,1)
imshow(A)
title('Imagen original')

% Transformación a escala de grises
B = rgb2gray(A);
subplot(1,2,2)
imshow(B)
title('Imagen en escala de grises')
```
















## Clase 5
## Clase 6
## Clase 7
## Clase 8
## Clase 9
## Clase 10
## Clase 11
## Clase 12
## Clase 13
## Clase 14
## Clase 15
## Clase 16
## Clase 17
## Clase 18
## Clase 19
## Clase 20
## Clase 21
## Clase 22
## Clase 23
## Clase 24
## Clase 25
## Clase 26
## Clase 27
## Clase 28
## Clase 29
## Clase 30
## Clase 31
## Clase 32
