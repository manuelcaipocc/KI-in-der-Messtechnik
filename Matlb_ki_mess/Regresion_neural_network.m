clc; clear;

% --- DATENERZEUGUNG UND NORMALISIERUNG ---

% Wir erzeugen ein Trainingsdatenset:
% Jede Eingabe besteht aus 5 aufeinanderfolgenden Zahlen,
% das Ziel ist es, die sechste Zahl vorherzusagen.
X = zeros(95, 5);  % 95 Trainingsbeispiele, jeweils 5 Eingangswerte
Y = zeros(95, 1);  % Die Zielwerte (Ausgabe)

for i = 1:95
    X(i,:) = i:i+4;   % Beispiel: [1 2 3 4 5]
    Y(i) = i + 5;     % Ziel: 6
end

% --- NORMALISIERUNG DER DATEN ---
% Normalisierung ist eine Vorverarbeitungstechnik, um das Lernen zu verbessern.
% Hier verwenden wir die Min-Max-Normalisierung.

% Die Min-Max-Normalisierung transformiert alle Werte auf den Bereich [0, 1]:
% x_norm = (x - min) / (max - min)
% Dadurch werden alle Merkmale in den gleichen Skalenbereich gebracht,
% was verhindert, dass Merkmale mit großen Werten das Training dominieren.

% Vorteil speziell bei ReLU: Da ReLU negative Werte auf 0 setzt,
% ist es wichtig, dass die Daten in einem positiven Bereich liegen.
% Daher ist Min-Max die ideale Wahl.

X_min = min(X(:));
X_max = max(X(:));
X = (X - X_min) / (X_max - X_min);  % Normalisierung von X auf [0, 1]

Y_min = min(Y);
Y_max = max(Y);
Y = (Y - Y_min) / (Y_max - Y_min);  % Normalisierung von Y auf [0, 1]

% --- NETZWERKARCHITEKTUR UND INITIALISIERUNG ---

% Die Architektur besteht aus:
% - 5 Eingangswerten
% - 1 versteckten Schicht mit 10 Neuronen
% - 1 Ausgang

layers = [5, 10, 1];
num_layers = length(layers) - 1;

W = cell(num_layers,1);  % Gewichtsmatrizen
b = cell(num_layers,1);  % Bias-Vektoren

for i = 1:num_layers
    W{i} = randn(layers(i), layers(i+1)) * 0.1;  % Initialisierung mit kleinen Zufallswerten
    b{i} = zeros(1, layers(i+1));
end

% --- AKTIVIERUNGSFUNKTIONEN ---

% ReLU (Rectified Linear Unit)
act = @(x) max(0, x);           % Aktivierungsfunktion
dact = @(x) double(x > 0);      % Ableitung für Backpropagation

% Visualisierung der ReLU-Funktion
x_vals = -5:0.01:5;             % Eingabewerte für die Funktion
y_vals = act(x_vals);           % Auswertung der Funktion
figure;
plot(x_vals, y_vals, 'LineWidth', 2);
xlabel('x');
ylabel('ReLU(x)');
title('ReLU-Aktivierungsfunktion');
grid on;


% ReLU (Rectified Linear Unit):
% Definition:
%   ReLU(x) = max(0, x)
% Verhalten:
%   - Für x > 0: bleibt x unverändert
%   - Für x <= 0: wird x zu 0
% Vorteile:
%   - Sehr effizient, schnell zu berechnen
%   - Verhindert vanishing gradients in tiefen Netzen
%   - Ideal für positive Eingaben (wie nach Min-Max-Normalisierung)

act = @(x) max(0, x);
dact = @(x) double(x > 0);  % Ableitung für Backpropagation

% ℹ️ Wenn man stattdessen `tanh(x)` verwenden würde:
% tanh(x) ∈ (-1, 1) und ist symmetrisch um 0.
% Vorteile:
%   - Liefert auch negative Ausgaben, was bei zentrierten Daten nützlich ist
%   - Kann in kleinen Netzen stabiler sein
% Nachteil:
%   - Für große |x| geht die Ableitung gegen 0 → vanishing gradient

% --- HYPERPARAMETER ---

% Anzahl der Trainingsdurchläufe (Epochen)
epochs = 2000;

% Lernrate (learning rate):
% Der Faktor, der bestimmt, wie groß die Schritte beim Anpassen der Gewichte sind.
% - Zu groß: Training wird instabil oder divergiert
% - Zu klein: Training ist sehr langsam oder bleibt stecken
lr = 0.01;

% --- TRAININGSLOOP ---
for epoch = 1:epochs
    A = cell(num_layers+1,1);  % Aktivierungen
    Z = cell(num_layers,1);    % Zwischenergebnisse (z = a*W + b)
    A{1} = X;

    % Vorwärtspass
    for i = 1:num_layers
        Z{i} = A{i} * W{i} + b{i};
        if i < num_layers
            A{i+1} = act(Z{i});   % ReLU-Aktivierung in versteckten Schichten
        else
            A{i+1} = Z{i};        % Lineare Ausgabe für Regression
        end
    end

    % Fehlerberechnung: mittlerer quadratischer Fehler (MSE)
    loss = mean((A{end} - Y).^2);

    % Rückwärtsdurchlauf (Backpropagation)
    dA = 2 * (A{end} - Y) / size(X,1);

    for i = num_layers:-1:1
        dZ = dA;
        if i < num_layers
            dZ = dZ .* dact(Z{i});
        end
        dW = A{i}' * dZ;
        db = sum(dZ, 1);
        dA = dZ * W{i}';

        % Aktualisierung der Gewichte und Bias
        W{i} = W{i} - lr * dW;
        b{i} = b{i} - lr * db;
    end

    % Fehlerausgabe alle 100 Epochen
    if mod(epoch, 100) == 0
        fprintf("Epoche %d - Fehler: %.6f\n", epoch, loss);
    end
end

% --- TESTEN DES NETZES MIT EINEM BEISPIEL ---

% Testdaten ebenfalls normalisieren (mit gleichen Werten wie beim Training!)
x_test = ([96 97 98 99 100] - X_min) / (X_max - X_min);

for i = 1:num_layers-1
    x_test = act(x_test * W{i} + b{i});
end

y_pred = x_test * W{end} + b{end};

% Rücktransformation (Denormalisierung) des Ergebnisses
y_pred_orig = y_pred * (Y_max - Y_min) + Y_min;
fprintf("Vorhersage (normalisiert): %.4f → Tatsächlicher Wert: %.1f\n", y_pred, y_pred_orig);

% --- TESTEN DES NETZES MIT MEHREREN BEISPIELEN ---

X_test = zeros(10, 5);
Y_true = zeros(10, 1);

for i = 96:105
    idx = i - 95;
    X_test(idx,:) = i:i+4;
    Y_true(idx) = i + 5;
end

% Testdaten normalisieren
X_test_norm = (X_test - X_min) / (X_max - X_min);

Y_pred = zeros(10, 1);

for n = 1:size(X_test_norm, 1)
    x = X_test_norm(n, :);
    for i = 1:num_layers-1
        x = act(x * W{i} + b{i});
    end
    Y_pred(n) = x * W{end} + b{end};
end

% Rücktransformation der Vorhersagen
Y_pred = Y_pred * (Y_max - Y_min) + Y_min;

% Fehleranzeige
disp('--- TESTERGEBNISSE ---');
fprintf('%6s  %12s  %12s  %12s\n', 'Test-Nr', 'Erwartet', 'Vorhersage', 'Absoluter Fehler');
for i = 1:10
    fehler = abs(Y_true(i) - Y_pred(i));
    fprintf('%6d  %12.2f  %12.2f  %12.2f\n', i, Y_true(i), Y_pred(i), fehler);
end

% Visualisierung der Ergebnisse
figure;
plot(1:10, Y_true, '-o', 'LineWidth', 2);
hold on;
plot(1:10, Y_pred, '-x', 'LineWidth', 2);
legend('Erwartet (True)', 'Vorhersage (Predicted)');
xlabel('Test-Nr.');
ylabel('Zielwert');
title('Modellvorhersage vs. Tatsächlicher Wert');
grid on;
