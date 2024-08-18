pkg load image

A=imread('sydney.jpg');
subplot(2,2,1)
imshow(A);
title('Imagen Original')


%Calcular el histograma de A
h=zeros(256,1);
for i=0:255
  h(i+1)=sum(sum(A==i));
end
subplot(2,2,2)
bar(0:255,h)
title('Histograma')
xlim([0 255])

% Distribución Acumulada
ac=zeros(256,1);
[m,n]=size(A);
for i=0:255
  ac(i+1)=sum(h(1:i+1))/(m*n);
end

%Obtener la nueva imagen aplicando la técnica de ecualización
B=zeros(m,n); A=double(A);
for x=1:m
  for y=1:n
    B(x,y)=round(ac(A(x,y)+1)*255);
  end
end
B=uint8(B);
subplot(2,2,3)
imshow(B)
title('Imagen Ecualizada')

%Calcular el histograma de B
h2=zeros(256,1);
for i=0:255
  h2(i+1)=sum(sum(B==i));
end
subplot(2,2,4)
bar(0:255,h2)
title('Histograma de B')
xlim([0 255])
