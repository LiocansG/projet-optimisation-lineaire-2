% Votre algorithme pour resoudre
%
%   min_{0 <= xprime <= 1} ||A*xprime - yprime||_1

function xprime = votrealgorithme(A,yprime)

% !!! Ecrivez votre code ici !!!

yprime = yprime'; %On prend la transpos�e de yprime

%On cree le vecteur objectif
cprime = zeros(size(A,2),1); %On remplit de 0 pour chaque coefficient x

c2prime = ones(size(A,1),1); %On remplit de 1 pour chaque coefficient t

c = cat(1,c2prime, cprime);

% Création du vecteur de contraintes
Aprime = zeros(2*size(A, 1), 2*size(A, 2));

% Remplissage des contraintes en utilisant A
lineCount = 1;
for x = 1:size(A, 1)
    for y = 1:size(A, 2)
        Aprime(lineCount, size(A, 1) + y) = A(x, y);
        Aprime(lineCount + 1, size(A, 1) + y) = -A(x, y);
    end
    lineCount = lineCount + 2;
end

% Remplissage des contraintes pour les variables d'écart
count = 1;
for i = 2:2:(2*size(A, 1))
    Aprime(i-1:i, count) = -1;
    count = count + 1;
end


% Création du vecteur B
B = zeros(1, 2*size(yprime, 2));

rowCount = 1;
for i = 1:size(yprime, 2)
    B(1, rowCount) = yprime(1, i);
    B(1, rowCount+1) = -yprime(1, i);
    rowCount = rowCount + 2;
end

% Creation du vecteur de bornes inférieurs
lb = zeros(size(A,2)+size(A,1),1);

% Création du vecteur de bornes supérieures
ubPrime = Inf(1, size(A, 1));
ub2Prime = ones(1, size(A, 2));

ub = [ubPrime, ub2Prime];

% Création du tableau pour spécifier le sens des inégalités
ctype = repmat('U', 1, 2 * size(A, 1));

%On cr�e un tableau pour sp�cifier le type des variables
%Ici on n'impose pas de variables binaires
vartype = [];
vartype = repmat('C', 1, size(A, 1) + size(A, 2));

x = glpk(c, Aprime, B, lb, ub, ctype, vartype, 1);

% Copy elements from x to xprime within a specified range
xprime(size(A,1) : size(A,1) + size(A,2)) = x(size(A,1) : size(A,1) + size(A,2));

xprime = round(xprime);
