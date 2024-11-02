function A = vec2mat_diag(vec)
    A = zeros(8, 8);  % Predefinir la matriz de salida
    index = 1;
    rows = 8;
    cols = 8;

    for s = 2:2*rows
        if mod(s, 2) == 0
            % Diagonal hacia abajo
            for row = s-1:-1:1
                col = s - row;
                if row > 0 && row <= rows && col > 0 && col <= cols
                    A(row, col) = vec(index);
                    index = index + 1;
                    if index > length(vec)
                        return;
                    end
                end
            end
        else
            % Diagonal hacia arriba
            for col = s-1:-1:1
                row = s - col;
                if row > 0 && row <= rows && col > 0 && col <= cols
                    A(row, col) = vec(index);
                    index = index + 1;
                    if index > length(vec)
                        return;
                    end
                end
            end
        end
    end
end

