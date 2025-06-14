% === 1. Cargar imagen y normalizar ===

img_url = 'https://irp.cdn-website.com/1fec50a0/MOBILE/jpg/16395.jpg';
img = imread(img_url);
img = im2double(rgb2gray(img));
[h, w] = size(img);

% === 2. Filtros Sobel ===
Gx = [-1 0 1; -2 0 2; -1 0 1];  % Derivada horizontal
Gy = [-1 -2 -1; 0 0 0; 1 2 1];  % Derivada vertical

% === 3. Gradiente manual ===
grad_x_manual = zeros(h, w);
grad_y_manual = zeros(h, w);
for i = 2:h-1
    for j = 2:w-1
        region = img(i-1:i+1, j-1:j+1);
        grad_x_manual(i,j) = sum(sum(region .* Gx));
        grad_y_manual(i,j) = sum(sum(region .* Gy));
    end
end

% === 4. Gradiente con conv2 ===
grad_x_conv2 = conv2(img, Gx, 'same');
grad_y_conv2 = conv2(img, Gy, 'same');

% === 5. Magnitud del gradiente y bordes ===
grad_mag_manual = sqrt(grad_x_manual.^2 + grad_y_manual.^2);
grad_mag_conv2  = sqrt(grad_x_conv2.^2 + grad_y_conv2.^2);

threshold = 0.2;
edges_manual = grad_mag_manual > threshold;
edges_conv2  = grad_mag_conv2 > threshold;

% === 6. Mostrar comparación visual ===
figure;
subplot(2,3,1); imshow(img); title('Original');
subplot(2,3,2); imshow(grad_mag_manual); title('Grad (manuell)');
subplot(2,3,3); imshow(edges_manual); title('Kanten (manuell)');
subplot(2,3,5); imshow(grad_mag_conv2); title('Grad (conv2)');
subplot(2,3,6); imshow(edges_conv2); title('Kanten (conv2)');

% === 7. Detección y medición automática ===
% Rellenar huecos y eliminar ruido pequeño
BW = imfill(edges_conv2, 'holes');
BW = bwareaopen(BW, 500);

% Calcular diámetro equivalente
stats = regionprops(BW, 'EquivDiameter', 'Centroid', 'Area');

% Escala real: 100 píxeles = 25 mm => 1 px = 0.25 mm
pixel_scale_mm = 0.25;

% Seleccionar la región más grande
[~, idx] = max([stats.Area]);
equiv_diam_px = stats(idx).EquivDiameter;
equiv_diam_mm = equiv_diam_px * pixel_scale_mm;

% Mostrar en la imagen
figure; imshow(img); hold on;
visboundaries(BW, 'Color', 'b');
centro = stats(idx).Centroid;
text(centro(1), centro(2), ...
    sprintf('D = %.2f mm', equiv_diam_mm), ...
    'Color', 'yellow', 'FontSize', 12, 'FontWeight', 'bold');

fprintf('\n==== Automatische Durchmesserbestimmung ====\n');
fprintf('Äquivalenter Durchmesser in Pixel: %.2f px\n', equiv_diam_px);
fprintf('Geschätzter Außendurchmesser: %.2f mm\n', equiv_diam_mm);
fprintf('Skalierung: 1 Pixel = %.3f mm\n', pixel_scale_mm);
