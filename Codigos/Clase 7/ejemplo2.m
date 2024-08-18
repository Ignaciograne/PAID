pkg load image

A=imread('peppers.jpg');
subplot(1,2,1)
imshow(A);
title('Imagen original')

%Forma 2 de calcular el histograma
h2=zeros(256,1); %h1=[h1(0) h1(1) ... h1(255)]
for i=0:255
    h2(i+1) = sum(sum(A==i))
end
subplot(1,2,2)
bar(0:255,h2)
title('Histograma')
xlim([0 255])
