%% Dane
l = load('l2.txt'); % d�ugo�ci desek
n = load('n2.txt'); % liczba desek dla ka�dej d�ugo�ci
Tl = 3000; 
all_deski = sum(n);

[l,idx] = sort(l,'descend');
n = n(idx);

%% Sortowanie 
indeksy_za_duzych = find(l*2>Tl); % indeksy tam gdzie 2 nie zmieszcz� si� w 1 kupce
init_number = sum(n(indeksy_za_duzych));
% tutaj wyznacza si� pocz�tkow� ilo�� kupek (desek 3m do kupienia)
posortowane = [];
for i = 1:numel(indeksy_za_duzych)% p�tla po indeksach
  for j = 1:n( indeksy_za_duzych(i) )% p�tla po liczbie desek dla tego indesu
      posortowane(end + 1, 1) = l( indeksy_za_duzych(i) );
  endfor
endfor
% czyszczenie ju� posortowanych
l(indeksy_za_duzych)= [];
n(indeksy_za_duzych)= [];
summary = [];
nums = 1;
for h = 1:numel(n)
  summary(nums:nums + n(h) - 1, 1) = ones(n(h), 1)*l(h);
  nums =  nums + n(h);
endfor
summary = sort(summary,'descend');
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
    index_3 = all_za_duze(1);
    posortowane(end+1, 1) = summary(index_3);
    summary(index_3) = [];
    kontrolka = 0;
  endif
endwhile


%%
sorted = [];
for i = 1:size(posortowane, 1)
  wiersz = posortowane(i, :);
  wiersz = wiersz(wiersz>0);
  sorted(i, 1:numel(wiersz)) = wiersz;
endfor

  

