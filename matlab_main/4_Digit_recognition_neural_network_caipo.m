clc;           % Clears the MATLAB console
clear;         % Clears all workspace variables
% === DATA LOADING ===
trainImages = MNISTLoader.loadImages('train-images.idx3-ubyte');
trainLabels = MNISTLoader.loadLabels('train-labels.idx1-ubyte');
testImages  = MNISTLoader.loadImages('t10k-images.idx3-ubyte');
testLabels  = MNISTLoader.loadLabels('t10k-labels.idx1-ubyte');
% === VISUALIZATION OF 12 TRAINING SET IMAGES ===
figure('Name','Training Set Examples');
for i = 1:12
    subplot(3,4,i);
    imshow(trainImages(:,:,i));
    title(['Label: ', num2str(trainLabels(i))]);
end
% === PREPROCESSING ===
X = reshape(trainImages, 28*28, []).';   % [numSamples x 784]
Y = oneHot(trainLabels);                 % [numSamples x 10]
% Display the shape of the one-hot encoding
disp("Example of one-hot encoding for the first 5 labels:");
disp(trainLabels(1:5));
disp(Y(1:5,:));
% === NETWORK ARCHITECTURE DEFINITION ===
inputSize = 784;
hiddenSize = 64;
outputSize = 10;
numSamples = size(X,1);
epochs = 5;
lr = 0.1;
% === WEIGHTS AND BIASES INITIALIZATION ===
W1 = randn(inputSize, hiddenSize) * 0.01;
b1 = zeros(1, hiddenSize);
W2 = randn(hiddenSize, outputSize) * 0.01;
b2 = zeros(1, outputSize);
% === NETWORK TRAINING ===
for epoch = 1:epochs
    for i = 1:numSamples
        % FORWARD
        x = X(i,:);
        y = Y(i,:);
        z1 = x * W1 + b1;
        a1 = sigmoid(z1);
        z2 = a1 * W2 + b2;
        a2 = softmax(z2);
        % BACKWARD
        dz2 = a2 - y;
        dW2 = a1' * dz2;
        db2 = dz2;
        dz1 = (dz2 * W2') .* sigmoid_derivative(z1);
        dW1 = x' * dz1;
        db1 = dz1;
        % UPDATE
        W2 = W2 - lr * dW2;
        b2 = b2 - lr * db2;
        W1 = W1 - lr * dW1;
        b1 = b1 - lr * db1;
    end
    fprintf('Epoch %d completed\n', epoch);
end
% === TESTING ===
X_test = reshape(testImages, [], size(testImages,3));
num_test = size(X_test, 2);
predictions = zeros(num_test,1);
for i = 1:num_test
    x = reshape(X_test(:,i), 1, []);
    if i == 1
        disp("Debug info:");
        disp("x = "); disp(size(x));
        disp("W1 = "); disp(size(W1));
    end
    z1 = x * W1 + b1;
    a1 = sigmoid(z1);
    z2 = a1 * W2 + b2;
    a2 = softmax(z2);
    [~, pred] = max(a2);
    predictions(i) = pred - 1;
end
accuracy = sum(predictions == double(testLabels)) / num_test;
fprintf('Test Accuracy: %.2f%%\n', accuracy * 100);
disp("Dimensions:");
disp("x ="); disp(size(x));
disp("W1 ="); disp(size(W1));
% === VISUALIZATION OF TEST RESULTS ===
figure('Name','Predictions on Test Set');
for i = 1:12
    subplot(3,4,i);
    imshow(testImages(:,:,i));
    title(['Pred: ', num2str(predictions(i)), ...
           ' | Real: ', num2str(testLabels(i))]);
end
% === AUXILIARY FUNCTIONS ===
% Sigmoid activation function
function y = sigmoid(x)
    y = 1 ./ (1 + exp(-x));
    % === PLOTTING THE SIGMOID FUNCTION ===
    if isequal(size(x), [1,1]) && x == 0  % only when called from plotting
        figure('Name','Sigmoid Function');
        x_vals = -10:0.1:10;
        y_vals = 1 ./ (1 + exp(-x_vals));
        plot(x_vals, y_vals, 'LineWidth', 2);
        grid on;
        title('Activation Function: Sigmoid');
        xlabel('x'); ylabel('sigmoid(x)');
    end
end
% Derivative of the sigmoid function
function y = sigmoid_derivative(x)
    s = sigmoid(x);
    y = s .* (1 - s);
end
% Softmax to convert output to probabilities
function y = softmax(x)
    expX = exp(x - max(x));
    y = expX / sum(expX);
end
% One-hot encodes labels
function Y = oneHot(labels)
    numLabels = length(labels);
    Y = zeros(numLabels,10);
    for i = 1:numLabels
        Y(i, labels(i)+1) = 1;
    end
end
% === SOFTMAX DISTRIBUTION EXAMPLE FOR 10 ELEMENTS ===
disp('--- Softmax example with 10 elements (classes 0-9) ---');
valores = randn(1,10) * 2;   % arbitrary values simulating neural network output
probabilidades = softmax(valores);
disp('Input values (logits):');
disp(valores);
disp('Probability distribution after softmax:');
disp(probabilidades);
fprintf('Sum of probabilities: %.4f\n', sum(probabilidades));
% === VISUALIZATION ===
figure('Name','Softmax Distribution - Colors by Class');
subplot(1,2,1);
colores = lines(10);  % 10 distinct colors
x_vals = 0:9;
for i = 1:10
    bar(x_vals(i), probabilidades(i), 'FaceColor', colores(i,:), 'EdgeColor','none');
    hold on;
    % Label above each bar
    text(x_vals(i), probabilidades(i) + 0.02, ...
         sprintf('%.2f', probabilidades(i)), ...
         'HorizontalAlignment','center', ...
         'FontSize', 9, 'FontWeight', 'bold');
end
title('Softmax: Probabilities per Class (0-9)');
xlabel('Class');
ylabel('Probability');
xticks(0:9);  % Ensure all numbers from 0 to 9 appear
ylim([0, 1.1]);  % Space for text above
grid on;
subplot(1,2,2);
bar(1, probabilidades, 'stacked');
colormap(lines(10));
title('Stacked Bar (Sum = 1)');
ylabel('Total Probability');
xticks([]);
ylim([0, 1]);
grid on;
legend(arrayfun(@(x) sprintf('Class %d', x), 0:9, 'UniformOutput', false), ...
       'Location','eastoutside');