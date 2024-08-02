clc; clear;

%Como obtener una imagen binaria

A=imread('bote.jpg');
subplot(1,2,1)
imshow(A)
title('Imagen original')

[m,n]=size(A);
alpha=127;
C=zeros(m,n);
for i=1:m
  for j=1:n
    if A(i,j)<=alpha
      C(i,j)=0;
    else
      C(i,j)=255;
    end
  end
end
subplot(1,2,2)
imshow(C)
title('Imagen binaria')
