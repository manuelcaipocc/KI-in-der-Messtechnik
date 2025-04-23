% Parámetros del entorno 
spacing = 10;         % cm entre puntos
colors = {'r', 'b'};  % rojo y azul
sphere_size = 1;      % radio relativo de la esfera
outputFolder = 'synthetic_spiral_images';
mkdir(outputFolder)

% Coordenadas del recorrido espiral (X, Y)
path_coords = [
     0,  0;
     0, 10;
     0, 20;
    10, 20;
    20, 20;
    20, 10;
    20,  0;
    10,  0;
    10, 10
];

% Datos para guardar etiquetas
filenames = {};
sphere_coordinates = [];
distances_from_origin = [];
sphere_colors = {};

% Generación de imágenes (una sola esfera por imagen)
for i = 1:size(path_coords, 1)
    for c = 1:length(colors)
        clf;
        hold on;
        axis equal
        view(35, 25)
        camproj('perspective')

        % Mostrar eje y cuadrícula
        grid on;
        xlabel('X (cm)')
        ylabel('Y (cm)')
        zlabel('Z (cm)')

        % Limitar ejes con valores positivos en X/Y, y negativos en Z
        xlim([-2 25]);
        ylim([-2 25]);
        zlim([-2 5]);

        % Ticks cada 10 unidades
        xticks(0:10:25)
        yticks(0:10:25)
        zticks(-20:10:20)

        % Posición de la esfera
        x_position = path_coords(i,1);
        y_position = path_coords(i,2);
        z_position = 0;  % puedes variar si luego quieres probar profundidad
        
        % Dibujar un plano XY (z = 0) semitransparente
        [px, py] = meshgrid(0:5:25, 0:5:25); % puntos del plano
        pz = zeros(size(px));  % z = 0
        surf(px, py, pz, ...
        'FaceAlpha', 0.1, ...
        'EdgeColor', 'none', ...
        'FaceColor', [0.5 0.5 0.5]);


        % Dibujar la esfera
        [sx, sy, sz] = sphere(30);
        surf(sx * sphere_size + x_position, ...
             sy * sphere_size + y_position, ...
             sz * sphere_size + z_position, ...
             'FaceColor', colors{c}, 'EdgeColor', 'none');

        light('Position', [1 1 5], 'Style', 'infinite');
        lighting gouraud

        % Guardar imagen
        filename = sprintf('spiral_sphere_%d_%s.png', i, colors{c});
        filenames{end+1} = filename;
        sphere_coordinates(end+1,:) = [x_position, y_position, z_position];
        distances_from_origin(end+1) = norm([x_position, y_position, z_position]);
        sphere_colors{end+1} = colors{c};

        saveas(gcf, fullfile(outputFolder, filename));
    end
end

% Guardar etiquetas
T = table(filenames', sphere_coordinates(:,1), sphere_coordinates(:,2), ...
    sphere_coordinates(:,3), distances_from_origin', sphere_colors', ...
    'VariableNames', {'filename', 'x', 'y', 'z', 'distance_from_origin', 'color'});

writetable(T, fullfile(outputFolder, 'labels.csv'));
disp('¡Imágenes y etiquetas generadas exitosamente!');
