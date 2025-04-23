clc
% --- DATENERZEUGUNG UND NORMALISIERUNG ---

% Wir erzeugen drei Klassen von Datenpunkten:
% - Klasse 1: 100 Zufallsvektoren mit Werten zwischen 0 und 100
% - Klasse 2: Werte zwischen 100 und 200
% - Klasse 3: Werte zwischen 200 und 300
X1 = rand(100,3) * 100;
X2 = rand(100,3) * 100 + 100;
X3 = rand(100,3) * 100 + 200;

% --- NORMALISIERUNG ---
% Alle Daten werden auf den Bereich [0, 1] skaliert.
% Feature-wise Min-Max-Normalisierung auf den Bereich [0, 1]
X_all = [X1; X2; X3];
X_min = min(X_all);
X_max = max(X_all);
X = (X_all - X_min) ./ (X_max - X_min + eps);  % eps vermeidet Division durch Null

% --- ONE-HOT-ENCODIERTE ZIELWERTE ---
% Wir verwenden One-Hot-Encoding für drei Klassen:
% Klasse 1 → [1 0 0], Klasse 2 → [0 1 0], Klasse 3 → [0 0 1]
Y = [repmat([1 0 0],100,1); repmat([0 1 0],100,1); repmat([0 0 1],100,1)];

% --- ARCHITEKTUR DES NEURONALEN NETZWERKS ---
% layers = [3, 10, 10, 3] bedeutet:
% 3 Eingabeneuronen → 2 versteckte Schichten mit je 10 Neuronen → 3 Ausgabeneuronen
layers = [3, 5, 3];
num_layers = length(layers) - 1;

% Initialisierung der Gewichtsmatrizen und Bias-Vektoren
W = cell(num_layers,1);
b = cell(num_layers,1);
for i = 1:num_layers
    % Kleine zufällige Startgewichte (Normalverteilung)
    W{i} = randn(layers(i), layers(i+1)) * sqrt(2 / (layers(i) + layers(i+1)));
    b{i} = zeros(1, layers(i+1));
end

% --- HYPERPARAMETER ---
lr = 0.001;        % Lernrate
% Die Lernrate bestimmt, wie stark die Gewichte bei jeder Iteration angepasst werden.
% Zu große Werte → instabiles Lernen, zu kleine → langsames Lernen

epochs = 1000;   % Anzahl der Epochen
% Eine Epoche bedeutet ein Durchlauf durch den gesamten Datensatz.
% 1000 Epochen = 1000 Lernzyklen → ausreichend für kleine Netze.

% --- TRAININGSLOOP ---
for epoch = 1:epochs
    % --- VORWÄRTSPASS ---
    A = cell(num_layers+1,1);
    Z = cell(num_layers,1);
    A{1} = X;  % Erste Schicht = Input

    for i = 1:num_layers
        Z{i} = A{i} * W{i} + b{i};  % Lineare Kombination

        if i < num_layers
            % Aktivierung durch ReLU in versteckten Schichten
            A{i+1} = relu(Z{i});
        else
            % Softmax-Ausgabe für Klassifikation
            A{i+1} = softmax(Z{i});
        end
    end

    % --- VERLUSTBERECHNUNG (Cross-Entropy) ---
    loss = -sum(sum(Y .* log(A{end} + eps))) / size(X,1);  % eps für numerische Stabilität

    % --- BACKPROPAGATION ---
    % Ausgangsfehler (Differenz zwischen Vorhersage und echtem Wert)
    dA = A{end} - Y;
    dZ = A{end} - Y;  % salida de softmax - etiquetas verdaderas

    for i = num_layers:-1:1
        % Calcular dW y db
        dW = A{i}' * dZ;
        db = sum(dZ, 1);

        % Gradientenabstieg
        W{i} = W{i} - lr * dW;
        b{i} = b{i} - lr * db;

        % Fehler rückwärts propagieren, nur wenn nicht Input-Schicht
        if i > 1
            dA_prev = dZ * W{i}';
            dZ = dA_prev .* drelu(Z{i-1});  % jetzt korrekt: Ableitung nur bei versteckten Schichten
        end
    end

    % Verlust ausgeben
    if mod(epoch,100) == 0
        fprintf("Epoche %d - Verlust: %.4f\n", epoch, loss);
    end
end

% --- TESTEN DES NETZES ---
% Wir testen ein Beispiel mit Werten zwischen 100 und 200 → sollte Klasse 2 sein
x_test = [110 120 130];
x_test = (x_test - X_min) ./ (X_max - X_min + eps);  % gleiche Normalisierung wie im Training

% Nur Vorwärtspass
for i = 1:num_layers-1
    x_test = relu(x_test * W{i} + b{i});
end
y_pred = softmax(x_test * W{end} + b{end});

[~, klasse] = max(y_pred);
fprintf("Vorhergesagte Klasse (Einzeltest): %d\n", klasse);

% --- TESTE DER VORHERSAGEN (MEHRERE BEISPIELE) ---
fprintf("\n--- Genauigkeit des Netzes auf Testbeispielen ---\n");

% Wir definieren einige neue Testpunkte (die nicht zum Training gehörten)
X_test_neu = [
    30 40 20;    % Klasse 1 erwartet
    80 70 60;    % Klasse 1 erwartet
    110 120 130; % Klasse 2 erwartet
    150 160 140; % Klasse 2 erwartet
    210 220 230; % Klasse 3 erwartet
    270 280 260; % Klasse 3 erwartet
];

Y_erwartet = [1; 1; 2; 2; 3; 3];  % Erwartete Klassen

korrekt = 0;

for i = 1:size(X_test_neu,1)
    x = (X_test_neu(i,:) - X_min) ./ (X_max - X_min + eps);  % gleiche Normalisierung
    for j = 1:num_layers-1
        x = relu(x * W{j} + b{j});
    end
    y_hat = softmax(x * W{end} + b{end});
    [~, k] = max(y_hat);
    fprintf("Beispiel %d → Erwartet: %d, Vorhergesagt: %d\n", i, Y_erwartet(i), k);
    if k == Y_erwartet(i)
        korrekt = korrekt + 1;
    end
end

% Genauigkeit ausgeben
genauigkeit = korrekt / length(Y_erwartet) * 100;
fprintf("Genauigkeit auf Testdaten: %.2f %%\n", genauigkeit);

% --- VISUALISIERUNG DER CLUSTER ---
figure;
scatter3(X1(:,1), X1(:,2), X1(:,3), 36, 'r', 'filled'); hold on;
scatter3(X2(:,1), X2(:,2), X2(:,3), 36, 'g', 'filled');
scatter3(X3(:,1), X3(:,2), X3(:,3), 36, 'b', 'filled');

xlabel('Merkmal 1');
ylabel('Merkmal 2');
zlabel('Merkmal 3');
title('Datenpunkte pro Klasse');
legend('Klasse 1', 'Klasse 2', 'Klasse 3');
grid on;
view(45, 30);

% --- FUNKTIONSDEFINITIONEN ---
function y = relu(x)
    y = max(0, x);
end

function y = drelu(x)
    y = double(x > 0);
end

function y = softmax(z)
    z = z - max(z, [], 2);  % para evitar overflow numérico
    e_z = exp(z);
    y = e_z ./ (sum(e_z, 2) + eps);  % eps evita división por cero
end
