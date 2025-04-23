clc;           % Clear the console
clear;         % Remove all variables from the workspace

% --- Load dataset paths ---
% These are the paths to the folder containing images and their corresponding labels
imageFolder = 'synthetic_spiral_images';
csvPath = fullfile(imageFolder, 'labels.csv');

% --- Load dataset using a custom loader class ---
% This loader reads images and labels, resizes images to 128x128, and prepares them for training
loader = SpiralDataLoader(csvPath, imageFolder, [128 128]);

% --- Get image data ---
X = loader.getImageArray();         % Get the 4D image array [128 x 128 x 3 x N]
X = im2double(X);                   % Convert from uint8 [0-255] to double [0.0-1.0]

% --- Get labels: Position and Color ---
Ypos = loader.Positions;            % [N x 3] matrix with x, y, z positions
Ycolor = categorical(loader.Colors); % Categorical color labels: 0 or 1

% --- Visualize random images from the dataset ---
numToShow = 6;                      % Show 6 sample images
idx = randperm(size(X, 4), numToShow); % Random indices

figure('Name', '6 random images from the dataset');
for i = 1:numToShow
    subplot(2, 3, i);               % Arrange images in 2 rows, 3 columns
    imshow(X(:, :, :, idx(i)));    % Show the i-th image

    % Get position and color label for the image
    pos = Ypos(idx(i), :);
    col = string(Ycolor(idx(i)));
    colorName = 'Rojo';
    if col == "0"
        colorName = 'Azul';
    end
    
    title(sprintf('[%.0f, %.0f, %.0f] - %s', pos(1), pos(2), pos(3), colorName), ...
          'FontSize', 10);
end

% --- Flatten images into vectors ---
% Neural networks work with vectors; image is reshaped into [49152 x N] (128*128*3)
X = reshape(X, [], size(X, 4));

% --- Prepare labels ---
% Transpose to match shape [features x N]
Ypos = Ypos';                      % [3 x N]
Ycolor = double(Ycolor)';         % [1 x N], convert categorical to numeric
Y = [Ypos; Ycolor];               % [4 x N], final label array

% --- Split into training and testing sets ---
N = size(X, 2);                   % Total number of samples
idx = randperm(N);                % Shuffle data
train_count = round(0.8 * N);     % 80% training, 20% testing

Xtrain = X(:, idx(1:train_count));
Ytrain = Y(:, idx(1:train_count));

Xtest = X(:, idx(train_count+1:end));
Ytest = Y(:, idx(train_count+1:end));

% --- Network structure ---
% Theory: Fully connected feedforward neural network (Multilayer Perceptron)
% Input layer: 49152 neurons (1 per pixel)
% Hidden layer: 64 neurons (arbitrary choice, controls capacity)
% Output layer: 4 neurons -> [x, y, z, color]
input_size = size(Xtrain, 1);   % 49152
hidden_size = 64;
output_size = 4;

% Initialize weights with small random values (important for symmetry breaking)
W1 = randn(hidden_size, input_size) * 0.01;
b1 = zeros(hidden_size, 1);

W2 = randn(output_size, hidden_size) * 0.01;
b2 = zeros(output_size, 1);

% --- Hyperparameters ---
epochs = 1000;                  % Number of training cycles
lr = 0.01;                      % Learning rate

% --- Training loop ---
for epoch = 1:epochs
    % --- Forward propagation ---
    % Step 1: Linear combination (Z1) + Activation (A1)
    Z1 = W1 * Xtrain + b1;
    A1 = relu_func(Z1);        % ReLU activation adds non-linearity

    % Step 2: Output layer (Z2) + Activation for classification
    Z2 = W2 * A1 + b2;
    A2 = Z2;                   
    A2(end, :) = sigmoid_func(Z2(end, :));  % Sigmoid for binary output (color)

    % --- Loss computation (Mean Squared Error) ---
    loss = mean((A2 - Ytrain).^2, 'all');

    % --- Backpropagation ---
    % Gradient of loss w.r.t. output
    dZ2 = 2 * (A2 - Ytrain);
    dZ2(end, :) = dZ2(end, :) .* dsigmoid_func(Z2(end, :)); % Derivative of sigmoid

    % Gradients for W2 and b2
    dW2 = dZ2 * A1' / size(Xtrain, 2);
    db2 = sum(dZ2, 2) / size(Xtrain, 2);

    % Backpropagate to hidden layer
    dA1 = W2' * dZ2;
    dZ1 = dA1 .* drelu_func(Z1); % Derivative of ReLU

    % Gradients for W1 and b1
    dW1 = dZ1 * Xtrain' / size(Xtrain, 2);
    db1 = sum(dZ1, 2) / size(Xtrain, 2);

    % --- Update weights using gradient descent ---
    W1 = W1 - lr * dW1;
    b1 = b1 - lr * db1;
    W2 = W2 - lr * dW2;
    b2 = b2 - lr * db2;

    % --- Display loss every 100 epochs ---
    if mod(epoch, 100) == 0
        fprintf('Epoch %d, Loss = %.4f\n', epoch, loss);
    end
end

% --- Inference on test set ---
Z1_test = W1 * Xtest + b1;
A1_test = relu_func(Z1_test);

Z2_test = W2 * A1_test + b2;
Z2_test(end, :) = sigmoid_func(Z2_test(end, :));  % Apply sigmoid for color prediction

Ypred_test = Z2_test;

% --- Evaluation ---
% Separate true labels
Ytrue_pos = Ytest(1:3, :);       % True 3D positions
Ytrue_color = Ytest(4, :);       % True color (0 or 1)

% Separate predicted labels
Ypred_pos = Ypred_test(1:3, :);  % Predicted 3D positions
Ypred_color = Ypred_test(4, :) > 0.5;  % Threshold for binary decision

% --- Compute metrics ---
pos_error = mean(vecnorm(Ypred_pos - Ytrue_pos));    % Mean Euclidean distance
acc_color = mean(Ypred_color == Ytrue_color);        % Classification accuracy

fprintf('Average position error: %.2f\n', pos_error);
fprintf('Color classification accuracy: %.2f %%\n', acc_color * 100);


% --- Activation functions and their derivatives ---
function y = relu_func(x)
    y = max(0, x);             % ReLU: outputs 0 if x < 0, else x
end

function dy = drelu_func(x)
    dy = double(x > 0);        % Derivative of ReLU
end

function y = sigmoid_func(x)
    y = 1 ./ (1 + exp(-x));    % Sigmoid: maps real values to [0,1]
end

function dy = dsigmoid_func(x)
    s = sigmoid_func(x);       % Derivative of sigmoid
    dy = s .* (1 - s);
end

% --- Convert binary color value to text label ---
function txt = colorText(v)
    if v == 1
        txt = "Rojo";
    else
        txt = "Azul";
    end
end

% --- Show 3 random test predictions with real labels ---
numToShow = min(3, size(Xtest, 2));
idx_show = randperm(size(Xtest, 2), numToShow);

% Reshape Xtest to recover original image dimensions
Xtest_imgs = reshape(Xtest, [128, 128, 3, size(Xtest, 2)]);

figure('Name', 'Predictions vs Ground Truth (Test set) - 3 Examples');
for i = 1:numToShow
    i_idx = idx_show(i);
    subplot(1, 3, i);                 % Plot in a row
    imshow(Xtest_imgs(:, :, :, i_idx));

    % Get true and predicted values
    pos_real = Ytrue_pos(:, i_idx);
    color_real = Ytrue_color(i_idx);

    pos_pred = Ypred_pos(:, i_idx);
    color_pred = Ypred_color(i_idx);

    % Display labels
    title({
        sprintf('True: [%.0f, %.0f, %.0f] - %s', pos_real(1), pos_real(2), pos_real(3), colorText(color_real)), ...
        sprintf('Pred: [%.0f, %.0f, %.0f] - %s', pos_pred(1), pos_pred(2), pos_pred(3), colorText(color_pred))
    }, 'FontSize', 9);
end
