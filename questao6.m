% Parâmetros:
N=1000;

Mu_X = 10;
Sigma_X =5;

Mu_Y = 5;
Sigma_Y = 1;

Corr_X_Y = 0;


% Cálculos

CorrMatrix =    [1          Corr_X_Y
                 Corr_X_Y   1       ];

L = chol(CorrMatrix);

SeqNCorrX = normrnd(Mu_X, Sigma_X, N, 1);
SeqNCorrY = normrnd(0, Sigma_X, N, 1);; normrnd(0, 1, N, 1);

SeqNCorr = [ SeqNCorrX SeqNCorrY];


SeqCorr = SeqNCorr * L;

SeqCorr(:,2) = SeqCorr(:,2) - Mu_X * Corr_X_Y + Mu_Y * Sigma_X / Sigma_Y;

SeqCorr(:,2) = SeqCorr(:,2) / Sigma_X * Sigma_Y;


% Resultados


fprintf("Mean X: %f Sigma X: %f\n", mean(SeqCorr(:,1)), sqrt(var(SeqCorr(:,1))));
fprintf("Mean Y: %f Sigma Y: %f\n", mean(SeqCorr(:,2)), sqrt(var(SeqCorr(:,2))));
fprintf("Corr X Y: %f\n", corr(SeqCorr(:,1),SeqCorr(:,2)));

tiledlayout(2,2)
nexttile()
scatter(SeqCorr(:,1),SeqCorr(:,2))
set(gca, 'XColor', 'r')
set(gca, 'YColor', 'b')
xlabel('X');
ylabel('Y');

nexttile()

plot(SeqCorr(:,1), 'Color', 'r')
xlabel('n');
ylabel('X');

nexttile()

plot(SeqCorr(:,2), 'Color', 'b')
xlabel('n');
ylabel('Y');

nexttile()

histogram(SeqCorr(:,1), 'FaceColor', 'r','Normalization','probability')

xlabel('Value');
ylabel('Rel Freq');

hold on

histogram(SeqCorr(:,2), 'FaceColor', 'b','Normalization','probability')

