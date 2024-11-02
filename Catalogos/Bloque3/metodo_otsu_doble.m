function [T1, T2] = metodo_otsu_doble(A)
  % Paso 0: Calcular el histograma y normalizar
  [q, ~] = imhist(A);
  [m,n]=size(A);
  h=q/(m*n);


  % Paso 0: Calcular sumas acumuladas (P) y medias acumuladas (m)
  P = cumsum(h);
  m = cumsum((0:255)' .* h);
  mg = m(end);
  S = zeros(256, 256); % Inicialización de la matriz de varianzas entre clases

  % Paso 1: Bucle doble para calcular S(k1, k2)
  for k1 = 0:255
    for k2 = k1+1:255

      % Paso 1.1
      P1 = P(k1+1);
      P2 = P(k2+1) - P1;
      P3 = 1 - P(k2+1);

      if P1 > 0 && P2 > 0 && P3 > 0
        % Paso 1.2
        m1 = m(k1+1) / P1;
        m2 = (m(k2+1) - m(k1+1)) / P2;
        m3 = (mg - m(k2+1)) / P3;

        % Paso 1.3: Calcular la matriz de varianza S
        S(k1+1, k2+1) = P1 * (m1 - mg)^2 + P2 * (m2 - mg)^2 + P3 * (m3 - mg)^2;
      end
    end
  end

  % Paso 2: Encontrar los índices donde S alcanza su máximo
  [~, idx] = max(S(:));
  [T1, T2] = ind2sub(size(S), idx);
  T1 -= 1; % Ajustar índices para ser coherentes con el rango 0-255
  T2 -= 1;
end

