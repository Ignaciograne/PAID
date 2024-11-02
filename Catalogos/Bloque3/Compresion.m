pkg load signal

% Matriz de tamaño 8x8
A = [154 123 123 123 123 123 123 136;
     192 180 136 154 154 154 136 110;
     254 198 154 154 180 154 123 123;
     239 180 136 180 180 166 123 123;
     180 154 136 167 166 149 136 136;
     128 136 123 136 154 180 198 154;
     123 105 110 149 136 136 180 166;
     110 136 123 123 123 136 154 136];

% Paso 1: Resatr 128 a cada entrada
M = A-128;

% Paso 2: Calcular la DCT-2D
D = dct2(M);

% Paso 3: Obtener la atriz cuantificada
Q = cuantificacion(50);

% Matriz cuantificada
C=round(D./Q)
