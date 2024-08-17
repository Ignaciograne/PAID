pkg load image

% Ejemplo de rippling de una imagen
I=imread('barbara.jpg');
I=imresize(I,[128,128]);
subplot(1,2,1)
imshow(I)

%Escalar una imagen con el comando
%imtransform

sx=0.5; sy=1.5;

%x'=Tx(x,y)=a0*x+a1*y+a2=sx*x+0*y+0=sx*x
%y'=Ty(x,y)=b0*x+b1*y+b2=0*x+sy*y+0=sy*y

%Paso 1: Definir matriz A
A=[sx 0 0;
   0 sy 0;
   0 0  1];

%Paso 2: Definir la transformada
T=maketform('affine',A);
It=imtransform(I,T);
subplot(1,2,2)
imshow(It)
