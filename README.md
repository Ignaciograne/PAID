# PAID
Apuntes del curso Procesamiento y Análisis de Imágenes Digitales

## Clase 1
Introducción

## Clase 2
Feriado

## Clase 3
¿Qué es una imagen? Una representación bidimensional de un objeto (o una escena), el cual se obtiene a través de una cámara, escaner, resonancia magnetica, sensores, entre otros. Al medio por el cual se obtiene se denomina sistema.

Para efectos de este curso, estudiaremos la representación de imágenes a través de una computadora. Dicha representación se realiza a través de un "muestreo" del objeto, y dicho muestreo se almacena en un arreglo discreto bidimensional (matriz). Esto porque, al fin y al cabo, toda imagen se representa como una matriz I de tamaño mxn, donde cada I(i, j) corresponde a un pixel.

![](https://github.com/Ignaciograne/PAID/blob/main/Imgs/ImagenContinuaVsImageDiscreta.png)

En este curso, también, se estarán estudiando principalmente imágenes a escala de grises e imágenes a color usando el modelo RGB en formato de 8 bits (Nota: Cuidado con OpenCV, ya que suele cargar las imágenes en formato BGR y no RGB). En este formato, cada uno de los pixeles puede ir desde 0 hasta 255.

Para convertir una imagen de BGR a RGB:
```Python
import cv2

# Leer la imagen
A = cv2.imread('img.jpeg')

# Convertir el formato de imagen
A = cv2.cvtColoAar()
```

```Octave
x = -2:2
```

## Clase 4
