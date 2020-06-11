clear; clc; % doda³em te¿ ró¿ne clear() w kodzie by czyœci³o poszczególne
% nieu¿ywane zmienne bo robi¹ nam œmietnik w Workspace
%% dane
l = load('lengths.txt');
n = load('numbers.txt');
Tl = 3000;
%% sortowanie
[l,idx] = sort(l,'descend');
n = n(idx); clear idx;
indeksy_za_duzych = find(l*2>Tl); % indeksy tam gdzie 2 nie zmieszcz¹ siê w 1 kupce
 
posortowane = [];
if(length(indeksy_za_duzych)<1) % jeœli nie ma deski, ktora jest za duza aby wejsc do kupki 2 razy...
  for i = 1:numel(indeksy_za_duzych)% pêtla po indeksach
    for j = 1:n( indeksy_za_duzych(i) )% pêtla po liczbie desek dla tego indesu
        posortowane(end + 1, 1) = l( indeksy_za_duzych(i) );
    endfor
  endfor
  % czyszczenie ju¿ posortowanych
  l(indeksy_za_duzych)= [];
  n(indeksy_za_duzych)= [];
endif;clear i; clear j
% wiêc, jeœli nie ma tak duzych desek, to ten etap pomijamy, oraz...
% w pêtli while zostaje dodany jeden warunek if() wiêcej....
% i chyba ju¿ dzia³a. program nie zak³ada³ nieobecnoœci desek, które...
% nie mieœci³y siê w danej kupce dwa razy.
clear indeksy_za_duzych
summary = []; % wektor dla n z powtorkami, tzn.: 5,5,5,5,5,10,10,10 itd...
nums = 1; % ta zmienna pomaga nam indeksowaæ i dobrze wpisywac powtórki
for h = 1:numel(n) % tworzenie wektora z powtorkami
  summary(nums:nums + n(h) - 1, 1) = ones(n(h), 1)*l(h);
  nums =  nums + n(h);
endfor; clear nums; clear h; clear l; clear n;

summary = sort(summary,'descend');% sortujemy wektor z powtorkami...
while( numel(summary) > 0 )
  for k = 1:size(posortowane, 1) % pêtla po wierszach kupek
     dosc_mala_deska_index = find(summary+sum(posortowane(k, :)) <= Tl);
     if dosc_mala_deska_index % jeœli ma³ego cokolwiek znalaz³o to:
      index = dosc_mala_deska_index(1);
      posortowane(k, end+1) = summary(index);
      summary(index) = [];
     endif
  endfor
  kontrolka = 0;
  for r = 1:size(posortowane, 1) % upewnij sie ¿e dla ka¿dego s¹ za du¿e
    all_za_duze = find(summary+sum(posortowane(r, :)) > Tl);
    if all_za_duze 
      kontrolka = kontrolka + 1;
    endif
  endfor
  if kontrolka >= size(posortowane, 1) % jeœli nigdzie sie nie mieœci
    if size(posortowane, 1) < 1 % jeœli od pocz¹tku nie by³o desek, ktore nie miesci³y siê gdzieœ 2 razy....
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