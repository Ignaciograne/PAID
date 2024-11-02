function vec = mat2vect_diag(A)
    [rows, cols] = size(A);
    vec = [];
    if rows ~= 8 || cols ~= 8
        error('La matriz debe ser de tamaño 8x8');
    end

    % Empezar el recorrido zigzag
    % Matriz de salida indexada
    count = 1;
    for s = 2:2*rows
        if mod(s, 2) == 0
            % Diagonal hacia abajo
            for row = s-1:-1:1
                col = s - row;
                if row > 0 && row <= rows && col > 0 && col <= cols
                    vec(count) = A(row, col);
                    count = count + 1;
                end
            end
        else
            % Diagonal hacia arriba
            for col = s-1:-1:1
                row = s - col;
                if row > 0 && row <= rows && col > 0 && col <= cols
                    vec(count) = A(row, col);
                    count = count + 1;
                end
            end
        end
    end

    % Truncar el vector al último elemento no-cero
    last_non_zero = max(find(vec~=0));
    vec = vec(1:last_non_zero);
end

