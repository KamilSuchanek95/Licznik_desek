clear; clc; % doda�em te� r�ne clear() w kodzie by czy�ci�o poszczeg�lne
% nieu�ywane zmienne bo robi� nam �mietnik w Workspace
%% dane
l = load('lengths.txt');
n = load('numbers.txt');
Tl = 3000;
%% sortowanie
[l,idx] = sort(l,'descend');
n = n(idx); clear idx;
indeksy_za_duzych = find(l*2>Tl); % indeksy tam gdzie 2 nie zmieszcz� si� w 1 kupce
 
posortowane = [];
if(length(indeksy_za_duzych)<1) % je�li nie ma deski, ktora jest za duza aby wejsc do kupki 2 razy...
  for i = 1:numel(indeksy_za_duzych)% p�tla po indeksach
    for j = 1:n( indeksy_za_duzych(i) )% p�tla po liczbie desek dla tego indesu
        posortowane(end + 1, 1) = l( indeksy_za_duzych(i) );
    endfor
  endfor
  % czyszczenie ju� posortowanych
  l(indeksy_za_duzych)= [];
  n(indeksy_za_duzych)= [];
endif;clear i; clear j
% wi�c, je�li nie ma tak duzych desek, to ten etap pomijamy, oraz...
% w p�tli while zostaje dodany jeden warunek if() wi�cej....
% i chyba ju� dzia�a. program nie zak�ada� nieobecno�ci desek, kt�re...
% nie mie�ci�y si� w danej kupce dwa razy.
clear indeksy_za_duzych
summary = []; % wektor dla n z powtorkami, tzn.: 5,5,5,5,5,10,10,10 itd...
nums = 1; % ta zmienna pomaga nam indeksowa� i dobrze wpisywac powt�rki
for h = 1:numel(n) % tworzenie wektora z powtorkami
  summary(nums:nums + n(h) - 1, 1) = ones(n(h), 1)*l(h);
  nums =  nums + n(h);
endfor; clear nums; clear h; clear l; clear n;

summary = sort(summary,'descend');% sortujemy wektor z powtorkami...
while( numel(summary) > 0 )
  for k = 1:size(posortowane, 1) % p�tla po wierszach kupek
     dosc_mala_deska_index = find(summary+sum(posortowane(k, :)) <= Tl);
     if dosc_mala_deska_index % je�li ma�ego cokolwiek znalaz�o to:
      index = dosc_mala_deska_index(1);
      posortowane(k, end+1) = summary(index);
      summary(index) = [];
     endif
  endfor
  kontrolka = 0;
  for r = 1:size(posortowane, 1) % upewnij sie �e dla ka�dego s� za du�e
    all_za_duze = find(summary+sum(posortowane(r, :)) > Tl);
    if all_za_duze 
      kontrolka = kontrolka + 1;
    endif
  endfor
  if kontrolka >= size(posortowane, 1) % je�li nigdzie sie nie mie�ci
    if size(posortowane, 1) < 1 % je�li od pocz�tku nie by�o desek, ktore nie miesci�y si� gdzie� 2 razy....
      posortowane(end+1, 1) = summary(1); %
      summary(1) = []; %
      kontrolka = 0; %
    else %
      index_3 = all_za_duze(1);
      posortowane(end+1, 1) = summary(index_3);
      summary(index_3) = [];
      kontrolka = 0;
    endif %
  endif
endwhile; clear summary; clear r; clear k; clear kontrolka; clear all_za_duze; clear dosc_mala_deska_index; clear index_3; clear index;
sorted = [];
for i = 1:size(posortowane, 1)
  wiersz = posortowane(i, :);
  wiersz = wiersz(wiersz>0);
  sorted(i, 1:numel(wiersz)) = wiersz;
endfor; clear i; clear wiersz; clear posortowane; clear Tl;