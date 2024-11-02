function T=metodo_otsu(A)
  %Paso 0: Calcular el histograma
  [q,~]=imhist(A);

  %Paso 1: Histograma normalizado
  [m,n]=size(A);
  h=q/(m*n); %(1/(m*n))*p

  %Paso 2: Vector de sumas acumuladas
  p=zeros(256,1);
  for k=0:255
    p(k+1)=sum(h(1:k+1));
  end

  %Paso 3: Vector de sumas acumuladas con peso
  mv=zeros(256,1);
  aux=[0:255]'.*h;
  for k=0:255
    mv(k+1)=sum(aux(1:k+1));
  end

  %Paso 4: Valor máximo de mv
  mg=mv(255);

  %Paso 5: Calculo del vecto de varianza
  s=((mg*p-mv).^2)./(p.*(1-p));

  %Paso 6: Calcular el umbral
  [~,T]=max(s);
end
