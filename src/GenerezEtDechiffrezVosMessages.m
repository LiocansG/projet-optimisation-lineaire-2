% Projet d'optimisation non lineaire
%
% Envoi d'un message crypte atravers un canal avec du bruit qaussien...
%
% Encodez vous-meme et dechiffrez un message:

clear all; clc;

% Message a envoyer
my_mess = "Ca c'est ma fusee";
fprintf('The encoded message is: %s \n', my_mess)

% Message sous forme binaire
[x,d]  = encoding_bin(my_mess);

% Longeur du message
n = length(x);

% Longeur du message qui va etre envoye
m = 4*n;

% Matrice d'encodage: on prend une matrice aleatoirement generee
A = randn(m,n);

% Message que l'on desire envoyer
y = A*x;

% Bruit ajoute par le canal de transmition
% = normale N(0,sigma) pour un % des entrees de y
% Define initial percenterror
initial_percenterror = 0.005;
percenterror = 0.38;
max_iterations = 10; % Number of iterations

for iteration = 1:max_iterations
    % Update percenterror for the current iteration
    percenterror += initial_percenterror;

    % Generate noisy signal
    yprime = noisychannel(y, percenterror);

    % Solve the optimization problem
    xprime = votrealgorithme(A, yprime);

    % Calculate the error
    error = norm(x - xprime);

    % Display the results
    fprintf('Iteration %d:\n', iteration);
    fprintf('Percent Error: %.2f%%\n', percenterror * 100);
    fprintf('Error Norm: %.4f\n', error);
    fprintf('The recovered message is: %s\n', decoding_bin(xprime, d));
    fprintf('\n');
end
