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
title('Imagen original')

% Incorporar ruido (sal y pimienta) a una imagen
% El ruido sal y pimienta consiste en quitar algunos pixeles de la imagen original
% y reemplazarlos con pixeles completamente negros o complemente blancos.
Y = imnoise(A, 'salt & pepper', 0.05)
subplot(1,3,2)
imshow(Y)
title('Imagen con ruido sal y pimienta')

% Eliminar ruido (sal y pimienta) de una imagen
Z = medfil2(Y); % Limpiar imagen con filtro de la mediana
subplot(1,3,3)
imshow(Z)
title('Imagen limpiada')
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/SalYPimientaImagen.png)

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

<br></br>

### Cambiar imagen de color a blanco y negro
```Octave
A = imread('img.jpg');
% Yo puedo ejecutar size(A) lo cual me retorna tres cosas:
% - Número de pixeles horizontales de la imagen.
% - Número de pixeles verticales de la imagen.
% - Número de canales. Si me dice 3 canales, es un RGB. Si me dice 1 (o si no aparece del todo), está en escala de grises.

subplot(1,2,1)
imshow(A)
title('Imagen original')

% Transformación a escala de grises
B = rgb2gray(A);
subplot(1,2,2)
imshow(B)
title('Imagen en escala de grises')
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/EscalaDeGrisesImagen.png)

<br></br>

### Ajustar contraste
```Octave
pkg load image

A = imread('img.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

% Mejorar el contraste de grises
B = imadjust(A);
subplot(1,2,2)
imshow(B)
title('Imagen con contraste mejorado')
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/ContrasteMejoradoImagen.png)

<br></br>

### Redimensionar
```Octave
pkg load image

A = imread('img.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

% Redimensionar la imagen de tamaño
B = imresize(A, [256, 256]);
subplot(1,2,2)
imshow(B)
title('Imagen redimensionada')
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/RedimensionCuadradaImagen.png)

Aunque las dos imágenes se vean idénticas, la realidad es que son distintas. Note que la resolución en la segunda es
de peor calidad que la resolución para la primera imagen.

<br></br>

Nota: Los tamaños no tienen porqué ser cuadrados:
```Octave
pkg load image

A = imread('img.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

% Redimensionar la imagen de tamaño
B = imresize(A, [128, 256]);
subplot(1,2,2)
imshow(B)
title('Imagen redimensionada')
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/RedimensionNoCuadradaImagen.png)

<br></br>

### Rotar 
```Octave
pkg load image

A = imread('img.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

% Rotar la imagen
B = imrotate(A, 45); % Rotar la imagen A en 45 grados
subplot(1,2,2)
imshow(B)
title('Imagen rotada')
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/RotacionImagen.png)

<br></br>

### Detectar bordes
```Octave
pkg load image

A = imread('img.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

% Detección de bordes
B = edge(A, 'Canny');
subplot(1,2,2)
imshow(B)
title('Imagen con bordes resaltados')
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/BordesResaltadosImagen.png)

<br></br>

### Segmentación
Busca separar la imagen en diferentes tonalidades
```Octave
pkg load image

A = imread('img.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

% Segmentación
B = graythresh(A); % Calcula un umbral B de la escala de grises de la imagen A
C = im2bw(A,B); % Segmenta la imagen A usando el umbral B
subplot(1,2,2)
imshow(C)
title('Imagen segmentada')
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/SegmentacionImagen.png)

<br></br>



## Clase 5

Sea A una imagen de tamaño mxn (a color o escala de grises).
Se sabe que A(x,y), donde x ∈ {1,2,...} y y ∈ {1,2,...,n}, es un pixel de la imagen A.

Una operación geométrica se describe como una transformación de pixeles de la imagen A.

Por ejemplo, rotar 180º una imagen. Lo que se hace al fin y al cabo es modificar los pixeles y obtener una nueva imagen. Matemáticamente, esto se reperesenta de la siguiente manera:

$A(x,y) \rightarrow B(x', y') = B(T_x(x,y), T_y(x, y))$

donde $T_x$ y $T_y$ representan la transformación aplicada a los pixeles. A esto se le conoce como transformación de posición de pixeles.

Nota: Las transformadas $T_x$ y $T_y$ se conocen como transformadas afines.

En general, estas transformadas se representan como combinaciones lineales de $(x,y)$:

- $x' = T_x(x,y) = a_0x + a_1y + a_2$, donde $a_0$, $a_1$, $a_2$ ∈ $\mathbb{R}$.
- $y' = T_y(x,y) = b_ox + b_1y + b_2$, donde $b_0$, $b_1$, $b_2$ ∈ $\mathbb{R}$.

### Tipos de transformaciones afines lineales:
1. Traslación: Mover la imagen.

    Si:
    - $\Delta_x > 0$
    - $\Delta_y > 0$
    se dice que se tiene una traslación positiva. La cual luce tal que:

    ![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/TraslacionImagen.png)

    donde $\Delta_x$ y $\Delta_y$ son la cantidad de pixeles que se traslada una imagen en el eje $x$ y $y$, respectivamente.

    Debido a ser una transformación afín:
    
    $A(x,y) \rightarrow B(x', y')$, donde:
    - $x' = 1 \cdot x + 0 \cdot y + \Delta_x = x + \Delta_x$
    - $y' = 0 \cdot x + 1 \cdot y + \Delta_y = y + \Delta_y$

    Nota: Se debe tener cuidado con las dimensiones de la imagen en los pixeles que salen de los márgenes. Si un pixel sale del margen, nosotros eliminaremos dichos pixeles.

    ![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/DesaparecePixelDeImagen.png)

    esto implica que $x' > m$ y $y' > n$, como bien indica la figura anterior (PD: El profe menciona que en caso de descartarlo, en la programación debe de haber un `if` que verifique esta condición).

    El código para trasladar una imagen es:
    ```Octave
    pkg load image

    A = imread('img.jpg') % Recuerde que esta imagen se encuentra en formato de 8 bits
    A = imresize(A, [128, 128]); % Se redimensiona la imagen original para que la 
                                 % "animación" no ocurra tan lento
    subplot(1,2,1)
    imshow(A)
    title('Imagen original')

    [m,n,r] = size(A);
    % Traslación delta_x y delta_y de la imagen
    for i=1:min([m n])
      B = uint8(zeros(m,n,r)); % Se inicializa una matriz del mismo tamaño
                               % que la imagen original, en formato de 8 bits
      deltax = i; deltay = i;
      for x=1:m
        for y=1:n
          x_t = x+deltax; % Transformaciones
          y_t = y+deltay; % afines
          if and(x_t<=m, y_t<=n)
            B(x_t,y_t,:) = A(x,y,:) % Reubicación del pixel A(x,y) en la nueva imagen B
          end
        end
      end
    
      subplot(1,2,2)
      imshow(B)
      title('Imagen trasladada')
      pause(0.1)
    end
    ```

2. Rotación: Consiste en rotar la imagen una cantidad de grados $\theta$. Dicha rotación se hace en el sentido de las manecillas del reloj.

    ![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/EsbozoRotacionImagen.png)
    
    la formulación matemática de la rotación es la siguiente:
    
    ![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/RotacionFormulacionMatematica.png)
    
    donde:
    - $x' = a_0(x-x_c) + a_1(y-y_c) + x_c$
    - $y' = b_0(x-x_c) + b_1(y-y_c) + y_c$
  
        donde:
        - $a_0 = \cos(\theta)$ y $a_1 = \sin(\theta)$
        - $b_0 = -\sin(\theta)$ y $b_1 = \cos(\theta)$
        - $(x_c, y_c)$ es el punto desde donde queremos que rote la imagen
  
          Nota: Normalmente, deseamos rotar la imagen desde el centro de dicha imagen. Por ello:
          - $x_c = m/2$ (parte entera)
          - $y_c = n/2$ (parte entera)
        
    El código para rotar una imagen es:
    ```Octave
    pkg load image

    A = imread('img.jpg') % Recuerde que esta imagen se encuentra en formato de 8 bits
    A = imresize(A, [128, 128]); % Se redimensiona la imagen original para que la 
                                 % "animación" no ocurra tan lento
    subplot(1,2,1)
    imshow(A)
    title('Imagen original')

    [m,n,r] = size(A);
    % Traslación delta_x y delta_y de la imagen
    B = uint8(zeros(m,n,r));
    angulo = 45;
    a0 = cosd(angulo); a1 = sind(angulo); % cosd y sind utilizan grados
    b0 = -sind(angulo); b1 = cosd(angulo);
    xc = floor(m/2); yc = floor(n/2);
    for x=1:m
      for y=1:n
        x_aux = round(a0*(x-xc) + a1*(y-yc) + xc);
        y_aux = round(b0*(x-xc) + b1*(y-yc) + yc);
        x_t = mod(x_aux,m); % Valor entre 0 y m-1 MODULO M REDONDEADO
        y_t = mod(y_aux,n); % Valor entre 0 y n-1 MODULO N REDONDEADO
        if and(x_t==x_aux,y_t==y_aux)
          B(x_t+1,y_t+1,:)=A(x,y,:); % Se suma 1, porque la indexación inicia en 1
        end
      end
    end
    ```
  
    Nota: Al rotar la imagen, estamos perdiendo sus esquinas (además de información en la propia imagen):
    
    ![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/RotadaSinEsquinasImagen.png)

    esto ocurre debido al redondeo utilizado en el código con ángulos de por ejemplo 45°, ya que los pixeles se ubican en otras coordenadas que no son, en principio, las coordenadas correctas. Con 90°, por ejemplo, estos errores desaparecen y la imagen se ajusta perfecto:

    ![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/RotadaSinPerdidasImagen.png)
   
    En todo caso, para evitar la pérdida de pixeles, se debe de agrandar el fondo donde se despliega la misma:
    
    ![ToDo: En el catálogo](https://github.com/Ignaciograne/PAID/blob/main/Imgs/RotadaConEsquinasImagen.png)
    
    donde m' > m y n' > n.
    
    ¿Cómo hacer esto? 
    Pues, inicialmente se tiene una imagen de alto n con ancho m. La diagonal es sqrt(m^2 + n^2).
    La idea es entonces colocar la imagen original entro de una imagen que tenga dimensiones: floor(sqrt(m^2+n^2))+1 × floor(sqrt(m^2+n^2+1))+1.
    Una vez hecho esto, se rota la imagen original.
    
    ![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/RotacionPasoPaso.png)

<br></br>



## Clase 6
En la clase pasada estuvimos viendo algunas transformaciones geométricas, donde:
$A(x,y) \rightarrow B(x', y')$

Y si la transformación es lineal:
- $x' = T_x(x,y) = a_0x + a_1y + a_2$
- $y' = T_y(x,y) = b_0x + b_1y + b_2$

Entonces, la clase pasada vimos dos transformaciones afines (traslación y rotación).

### Más transformaciones afines lineales:
3. Escalamiento
    Existen tres posibles enfoques a la hora de escalar:
    - Incrementar el tamaño de la imagen y mantener el marco del mismo tamaño. 
    - Incrementar el tamaño de la imagen y del marco.
      El problema que ocurre a la hora de incrementar es que esto conlleva un problema de pixeles en negro.
    - Disminuir el tamaño de la imagen.

    Entonces, si yo tengo una imagen $A(x,y)$, y la busco escalar con factores $S_x$ (escalar filas) y $S_y$ (escalar columnas), lo que estaría buscando es entonces una imagen $B(x', y')$, donde $x' = s_x \dot x$ y $y = s_y \cdot y$.
    
<br></br>

Por otro lado, existen otro tipo de transformadas que no son lineales..
### Transformaciones afines no lineales:
La estructura sigue el mismo patrón que en las transformaciones lineales. Es decir, es simplemente mover pixeles, sólo que la regla de cómo se mueven es lo que cambia (comportamiento no lineal).
1. Efecto rippling
   
    Sea A una imagen de tamaño mxn. La transformación "rippling" se define como:
    $A(x,y) \rightarrow B(x', y')$
    donde:
    - $x' = x + A_x \cdot \sin \left( \frac{2\pi \cdot y}{L_x} \right)$
    - $y' = y + A_y \cdot \sin \left( \frac{2\pi \cdot x}{L_y} \right)$

      donde:
      - $L_x, L_y$ son los periodos de ondulación. Entre más grandes sean estos, menor será la cantidad de ondulaciones.
      - $A_x, A_y$ son los valores de amplitud de onda.

    ```Octave
    pkg load image

    % Ejemplo de rippling de una imagen
    A=imread('img.jpg');
    A=imresize(A, [128,128]); % Se reduce el tamaño de la imagen
                              % original para que no tarde tanto
    subplot(1,2,1)
    imshow(A)
    title('Imagen original')
    [m,n,r]=size(A);
    
    %Periodos
    Lx=75; Ly=75;
    
    % Variando Ampliación
    % Amplitudes
    for k=5:5:200
      Ax=k;
      Ay=k;
      B=uint8(zeros(m,n,r));
    
      for x=1:m
        for y=1:n
           xaux=round(x+Ax*sin(2*pi*y/Lx));
           xnew=mod(xaux,m);
           yaux=round(y+Ay*sin(2*pi*x/Ly));
           ynew=mod(yaux,m);
           if and(xnew==xaux,ynew==yaux)
              B(xnew+1,ynew+1,:)=A(x,y,:);
           end
        endfor
      endfor
    
      subplot(1,2,2)
      imshow(B)
      title('Imagen con efecto rippling')
      pause(0.05)
    end
    ```
    
    esto genera una especie de animación en la cual el fondo se va mezclando entre sí hasta desaparecer la imagen.


Nota: Octave tiene un comando para realizar transformaciones geométricas afines lineales. Para eso, se define una matriz de la siguiente estructura:

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/MatrizDeTransformacionLinealAfin.png)

donde $a_0$, $a_1$, $a_2$ son de la transformada $T_x(x,y) = $a_0x + a_1y + a_2$
    y $b_0$, $b_1$, $b_2$ son de la transformada $T_y(x,y) = $b_0x + b_1y + b_2$

Los pasos son los siguientes:
- Definir la matriz A
- Definir la transformada afín (Mediante el comando `T = maketform('affine', A)`)
- $I_t = imtransform(I, T)$ (donde $I_t$ es la imagen resultante con la transformación, $I$ es la imagen original y $T$ es la transformada afín). \[PD: este comando tiene algo que no se hace por sí solo cuando se implementa pixel por pixel: Se rellenan los pixeles negros.]

(Estos pasos se pueden realizar para no tener que hacer las operaciones pixel a pixel, por lo que es ideal para corroborar resultados).

Su código está dado por:
```Octave
pkg load image

% Ejemplo de rippling de una imagen
I=imread('img.jpg');
I=imresize(I, [128,128]);
subplot(1, 2, 1)
imshow(I)
title('Imagen original')

% Escalar una imagen con el comando imtransform
sx = 0.5; sy = 1.5;

% Recordemos que la estructura de una transformada afín:
% x' = Tx(x,y) = a0*x + a1*y + a2 = sx*x + 0*y  + 0 = sx*x
% y' = Ty(x,y) = b0*x + b1*y + b2 = 0*x  + sy*y + 0 = sy*y

% Paso 1: Definir matriz A
A=[sx 0  0;
   0  sy 0;
   0  0  1];

% Paso 2: Definir la transformada
T = maketform('affine',A);

% Paso 3:
It = imtransform(I,T);

% Plot
subplot(1,2,2)
imshow(It)
title('Imagen transformada con una transformación escalar')
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/TransformacionAfinConComandoDeOctave.png)

<br></br>

### Videos
Hasta el momento se ha estudiado cómo cargar y utilizar imágenes.

Ahora veremos algunos temas relacionados a videos:

```Octave
pkg load image
pkg load video

V = VideoReader('VIDEO.mp4'); % Se carga el video
fr = V.NumberOfFrames; % Numero de frames (cuadros)
m = V.Height; n = V.Width; % Dimensiones de cada cuadro

% Espacio para crear un nuevo video con las dimensiones del video original
Y = zeros(m,n,3,fr); % El 3 es para indicar que va a ser un video a color

% Leer video y ponerle ruido a los frames
for k=1:fr
    Z1=readFrame(V); % Leer el frame k. Z1 es una imagen de tamaño m x n x 3

    % Ahora le sumo un ruido gaussiano a cada canal del frame
    Y(:,:,1,k) = im2double(Z1(:,:,1))+randn(m,n); % Canal rojo
    Y(:,:,2,k) = im2double(Z1(:,:,2))+randn(m,n); % Canal verde
    Y(:,:,3,k) = im2double(Z1(:,:,3))+randn(m,n); % Canal azul
end

% Crear Video
video = VideoWriter('video_salida.mp4');
for i=1:fr
    writeVideo(video,im2uint8(Y(:,:,:,i)));
end
close(video)
```

Nota: El profesor menciona que este enfoque es bueno porque en el curso no se tocará el tema del audio al ser un curso de meramente imágenes.

<br></br>

### Medianas para recuperación de información
A veces se pierde información de una imagen.

Por ejemplo, para la siguiente imagen:
```Octave
A = rand(3,3);
imshow(A)
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/ImagenPierdeInformacion1.png)

podría ocurrir que se perdiera la información de uno de sus pixeles. Por ejemplo el del centro. Esto ocasionaría que se viera tal que:
Por ejemplo, para la siguiente imagen:
```Octave
A(2,2) = 0;
imshow(A)
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/ImagenPierdeInformacion2.png)

Pero, gracias a la estadística, es posible recuperar su información por medio de los pixeles adyacentes. Para ello, se utiliza el concepto de mediana.
Por ejemplo, para la siguiente imagen:
```Octave
m = A(:); % Vectoriza la matriz
v = median(m); % Obtiene la mediana
A(2,2) = v; % Asigna en el pixel negro la información 'recuperada'
imshow(v)
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/ImagenPierdeInformacion3.png)

de esta manera, se asgina un valor que no es escrito al azar, sino que está escrito con la información de los pixeles adyacentes de la imagen.

<br></br>



## Clase 7
### Procesamiento de imágenes utilizando histogramas
Primeramente, ¿qué es un histograma?

Sea A una imagen a escala de grises, de tamaño $mxn$. Entonces, el histograma de una imagen es la representación de la frecuencia de aparición de uno de los niveles de grises de una imagen.

Asumiremos que la imagen A está en formato de 8 bits: $A(x,y) ∈$ {0, 1, 2, ... 255}.

Entonces, quiero saber cuántas veces aparece el 0, cuántas veces aparece el 1, el 2, el 3... el 255, etc.

Sea $h ∈ \mathbb{R}^{256}$ (un vector de 256), entonces:
  - $h(k) = h_k = \text{card}$ { $(x,y) / A(x,y) = k$ }
  donde:
    - $k ∈$ {0, 1, 2, ..., 255}
   
Ej: Considere la matriz $A ∈ \mathbb{R}$, tal que:

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/MatrizParaHistograma.png)

queda claro que los valores que toma A están en el conjunto {0, 1, 2, 3, 4, 5}, donde se tiene:
- $0 \rightarrow 6$ reps
- $1 \rightarrow 5$ reps
- $2 \rightarrow 2$ reps
- $3 \rightarrow 1$ reps
- $4 \rightarrow 1$ reps
- $5 \rightarrow 2$ reps

entonces: $h = \[6 \, 4 \, 2 \, 1 \, 1 \, 2 \]$.

La representación del histograma se da por medio de una gráfica de bastones:
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/HistogramaDeMatrices.png)

Ahora, ¿cómo se trata esto para imágenes?

Existen tres maneras para calcular un histograma. Todos dan el mismo resultado, aunque la visualización pueda ser un poco diferente. Pero, al final de cuentas, sigue siendo lo mismo.

1. Primera técnica: Ir entrada por entrada
```Octave
pkg load image

A=imread('img.jpg');
subplot(2,2,1)
imshow(A);
title('Imagen Original')

% Forma 1 de calcular el histograma
h1=zeros(256,1); % h1 = [h1(0) h1(1) ... h1(255)]
[m,n]=size(A);

for x=1:m
  for y=1:n
    h1(A(x,y)+1) = h1(A(x,y)+1)+1;
  end
end
subplot(2,2,2)
bar(0:255,h1)
title('Histograma')
xlim([0 255])
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/HistogramaManera1.png)

esta técnica es un poco "fuerza bruta", ya que recorre entrada por entrada.


2. Segunda técnica (método más eficiente): Utilizar las funcionalidades de Octave
Lo que se hace es aprovechar una funcionalidad de matriz binaria de Octave, donde es posible obtener una matriz que tenga 1's en las posiciones donde se cumple una condición, y 0's en las posiciones donde no.
```Octave
A = [4 5 7 1 3; 4 1 1 4 6; 1 7 5 9 3]
I = (A == 4)
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/HistogramaManera2TrucoDetras.png)

Esto permite diseñar un for que simplemente vaya desde 0 hasta 255, preguntando en dónde se tienen 1's:
```Octave
pkg load image

A=imread('img.jpg');
subplot(1,2,1)
imshow(A);
title('Imagen original')

% Forma 2 de calcular el histograma
h2 = zeros(256,1); % h1 = [h1(0) h1(1) ... h1(255)]
for i=0:255
  h2(i+1) = sum(sum(A==i)) % Se deben de agregar dos sum porque
                           % sino solamente sumaría columnas
end
subplot(1,2,2)
bar(0:255,h2)
title('Histograma')
xlim([0 255])
```

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/HistogramaManera2.png)


3. Tercera técnica (Desventaja: No genera ningún vector): Graficar mediante Octave
```Octave
pkg load image

A=imread('img.jpg');
subplot(1,2,1)
imshow(A);
title('Imagen original')

% Forma 3 de calcular el histograma
subplot(1,2,2)
imhist(A)
title('Histograma')
```
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/HistogramaManera3.png)

#### Técnicas para modificar una imagen a través del histograma
A veces se tienen imágenes con tonalidades muy grises. Por ejemplo:
![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/ImagenDeEjemploEnTonalidadGris.png)

pero, puede ser que se desee que una imagen tenga una distribución de pixeles que abarque más tonalidades, de tal manera que, al final de cuentas, siga manteniéndose el comportamiento, pero que ya no esté todo acumulado en una tonalidad de pixeles tan similar, sino que abarque un mayor rango de la escala de grises (desde 0 hasta 255). 

<br></br>



## Clase 8
Feriado

<br></br>



## Clase 9


<br></br>



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
