classdef SpiralDataLoader
    properties
        Images         % Cell array de imágenes (RGB)
        Positions      % Matriz Nx3 de posiciones [x y z]
        Colors         % Vector Nx1, 1 para rojo, 0 para azul
        Filenames      % Lista de nombres de archivos
        ImageSize      % Tamaño final de las imágenes (ej. [128 128])
    end
    
    methods
        function obj = SpiralDataLoader(csvPath, imageFolder, imageSize)
            if nargin < 3
                imageSize = [128 128];  % Tamaño por defecto
            end
            obj.ImageSize = imageSize;
            data = readtable(csvPath);

            numSamples = height(data);
            obj.Images = cell(numSamples, 1);
            obj.Positions = zeros(numSamples, 3);
            obj.Colors = zeros(numSamples, 1);
            obj.Filenames = data.filename;

            for i = 1:numSamples
                % Leer imagen
                imgPath = fullfile(imageFolder, data.filename{i});
                img = imread(imgPath);
                img = imresize(img, obj.ImageSize);
                obj.Images{i} = img;

                % Leer posición
                obj.Positions(i, :) = [data.x(i), data.y(i), data.z(i)];

                % Leer color
                if strcmp(data.color{i}, 'r')
                    obj.Colors(i) = 1;
                else
                    obj.Colors(i) = 0;
                end
            end
        end

        function X = getImageArray(obj)
            % Convierte las imágenes a un arreglo 4D [H, W, C, N]
            imgSize = size(obj.Images{1});
            numImages = length(obj.Images);
            X = zeros([imgSize, numImages], 'like', obj.Images{1});
            for i = 1:numImages
                X(:, :, :, i) = obj.Images{i};
            end
        end
    end
end
