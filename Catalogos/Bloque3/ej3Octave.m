clc; clear; close all
pkg load image
A=imread('linea2.jpg');

%Convertirla a Binaria
B=im2double(A);
B(B<0.5)=0; B(B>=0.5)=1;
imshow(B)

%Calcular la discretización angulo y p
h1=0.5; %Paso entre los angulos
angulos=deg2rad(0:h1:180);
[m,n]=size(B);
d=sqrt(m^2+n^2);
h2=0.5; %Paso entre los p
ps=-d:h2:d;

%Crear la matriz de acumulacion
m1=length(angulos); n1=length(ps);
Acumulador=zeros(m1,n1);

%Llenar la matriz de acumulación

[x_b,y_b]=find(B); %Pares ordenados donde se detectan bordes

for i=1:length(x_b)
  for ang_ind=1:length(angulos)
    ang=angulos(ang_ind);
    p=x_b(i)*cos(ang)+y_b(i)*sin(ang);
    [~,p_ind]=min(abs(ps-p));
    Acumulador(ang_ind,p_ind)+=1;
  end
end

%Mostrar graficamente el comportamiento del acumulador
%figure
%surface(angulos,ps,Acumulador','EdgeColor','none')
%xlabel('p')
%ylabel('angulos')


numlineas=6;

for i=1:numlineas
  %Encontrar la posición donde el Acumulador alcanza el máximo
  maxA=max(max(Acumulador));
  [xp,yp]=find(Acumulador==maxA);

  for k=1:length(xp)
    %Graficar la linea rectangle
    angMax=angulos(xp(k));
    pMax=ps(yp(k));


    if abs(sin(angMax))<10^-5
      x_v=pMax/cos(angMax);
      line([n 1], [x_v x_v],'LineWidth',2)
      xlim([0 n])
      ylim([0 m])
    else
      %Calcular pendiente
      pendiente=-cos(angMax)/sin(angMax);
      interseccion=pMax/sin(angMax);
      %Necesitamos el punto (1,y1)
      y1=pendiente*1+interseccion;
      %Necesitamos el punto (m,ym)
      ym=pendiente*m+interseccion;
      %Necesitamos el punto (x1,1)
      x1=(1-interseccion)/pendiente;
      %Necesitamos el punto (xn,n)
      xn=(n-interseccion)/pendiente;
      if pendiente>0
        if 0<y1
          line([y1 n], [1 xn],'LineWidth',2)
          xlim([0 n])
          ylim([0 m])
        else
          line([1 ym], [x1 m],'LineWidth',2)
          xlim([0 n])
          ylim([0 m])
        end
      else
        if y1>m
          line([ym n], [m xn],'LineWidth',2)
          xlim([0 n])
          ylim([0 m])
        else
          line([y1 1], [1 x1],'LineWidth',2)
          xlim([0 n])
          ylim([0 m])
        end
      end
    end
    Acumulador(xp(k),yp(k))=0;
  end
end
