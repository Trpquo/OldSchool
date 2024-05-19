# Modalni urednik

  - ==:help== je komanda za dobivanje informacija o bilo kakvoj komandi
    - osnovna sintaksa je `:help <prefiks><komanda>`, a prima prefikse: 
      - `:help <komanda>` za upute o komandama u normalnom modu
      - `:help v_<komanda>` za upute o komandama u vizualnom modu
      - `:help i_<komanda>` za upute o komandama u insert modu
      - `:help c_<komanda>` ili `:help :<komanda>` za upute o komandama u komandnom modu
      - `:help -<zastavica>` za upute o dodatnim oznakama komandama
      - `:help '<tekst>'` za upute o opcijama (?)
  - slična komanda je ==:helpgrep== koja izvlači iz dokumentacije mjesta koja spominju traženi pojam

  - Vim je modalni urednik, što znači da ima različite 'modove' rada:
    - **normal** - za istraživače (lutalice, planete) i za domare (omogućuje brze sitne prepravke)
      - to je početni mod i u njega se vraća (ako se izašlo) tipkom `<esc>`, `<C-c>` ili `<C-[>`
    - **search** - za istraživače i urednike (omogućuje brza skakanja s mjesta na mjesto i/ili izmjene sadržaja)
      - u njega se ulazi iz normalnog moda komandom `/`
      - ili iz komandnog moda naredbom `{+}s`, gdje {+} dio predstavlja određenje područja u kojem će se što tražiti
        - bez prefiksa će tražiti samo unutar aktivnog retka
        - prefiks `%` znači 'traži unutar cijelog dokumenta'
    - **insert** - za urednike (taj funkcionira uglavnom kao bilo kakav tekstovni urednik)
      - u njega se ulazi iz normalnog moda komandama:
        - `i` - insert pred trenutni položaj kursora
        - `I` - insert na početak retka
        - `a` - append nakon trenutnog položaja kursora
        - `A` - append na kraj retka
        - `gi` - vraća u insert mod na zadnje mjesto gdje smo iz njega izašli!!! (i stvarno radi)
        - `o` - upiši u redak ispod
        - `O` - upiši u redak iznad
        - `s` - izbriši znak i uđi u insert mode (kratica za `xi` ili `cl`)
        - `c<kretnja>` - izbriši što god je dohvaćeno <kretnjom> i uđi u insert mod
          - ima i oznaka `i` aka *inside* koji omogućuje selekciju i brisanje cijele neke cjeline unutar koje je bilogdje kursor smješten (npr. `ciw` je za mijenjanje cijele riječi, `ci(` je za zamjenu svega unutar zagrada)
          - oznaka `a` je slična kao `i`, ali stoji za 'around' te u selekciju uključuje rubne (granične) oznake
        - `r` je za zamjenu jednog slovnog znaka, a `R` je za ulazak u *-REPLACE-* mod (poput *insert* moda u Windowsima)
    - **visual** - za domare (omogućuje selekcije teksta)
      - u njega se ulazi iz normalnog moda komandom `v`
      - `<S-v>` je verzija *-VISUAL-* moda za selekciju redaka
      - `<C-v>` je verzija *-VISUAL-* moda zvana *visual block mode*
    - **command** iliti **execution mode** - za strojare (omogućuje unos komandi za automatizaciju)
      - u njega se ulazi iz normalnog ili vizualnog moda komandom `:`
    - **undo** i **redo** se pokreću komandama `u` i `<C-r>` iz normalnog moda
    - ==.== je komanda za ponavljanje zadnje akcije, ma što ona bila

## Za istraživače (normal mode)

### h, j, k, l, <C-u>, <C-d>, <C-f>, <C-b>, H, M, L, <C-e>, <C-y>, zz, gg, G, <C-i>, <C-o>, m
  - ==h== (←), ==j== (↓), ==k== (↑) i ==l== (→) su za kretanje korak po korak; s time da `j` i `k` nastoje skakati po zadnjim mjestima gdje smo bili pozicionirani u retku
  - ==<C-d>== i ==<C-u>== su za skakanje po pola ekrana dolje-gore 
  - ==<C-f>== i ==<C-b>== su za skakanje po pola stranice dolje-gore 
  - ==M== je za smještanje kursora na pola ekrana, a ==H== i ==L== bi trebali biti za skakanje kursorom na vrh i dno ekrana (ali ti su ključevi u lazyvim-u prenamijenjeni za skakanje između buffera)
  - ==<C-e>== i ==<C-y>== su za *scroll*-anje ekrana gore/dolje, ==zz== je za /scroll/-anje tako da se kursor nađe usred ekrana
  - ==gg== i ==G== su za skakanje na sam početak ili sam kraj dokumenta
  - ==:<broj>== ili ==<broj>G== je komanda za skakanje na točno određenu liniju teksta po broju
  - =={broj}%== je za skakanje na određeni postotak dokumenta, ma koji to bio redak
  - ==<C-o>== i ==<C-i>== su iznimno korisne jer omogućuju skakanje na prethodne i "buduće" pozicije kursora (nešto kao undo i redo za poziciju kursora), a Vim ili Nvim će skakati čak i između dokumenata obrađivanih u zadnjoj sesiji
  - ==m<registar>== je za označivanje nekog mjesta kako bi se lako vratili na njega, a skače se nazad na označeni redak s komandom `'<registar>`

### w, W, e, E, b, B, ge, gE, (, ), {, }, 0, `$`, ^, g_
  - ==w== i ==W== su za skakanje od riječi do riječi (gdje `W` pod riječ podrazumijeva sve između razmaka (\s,\n,\t ili \r )), a ==e== je slično tome samo smješta kursor pred razmak i ==E== prepoznaje riječi kao i `W`
  - ==b== i ==B== su isto kao i `w` i `W`, ali skaču u suprotnom smjeru, a ==ge== i ==gE== su isto što i `e` i `E`, ali unazad
  - ==0== i ==$== ili ==<M-a>== i ==<M-e>== su za skakanje na početak ili kraj retka (u *evil-mode*-u se isto može postići i sa `<C-a>` i `<C-e>`)
  - ==^== i ==g_== su za skakanje na prvi ili zadnji (ne prazni) znak u retku
  - ==(== i ==)== su za skakanje od rečenice do rečenice (izgleda da traže interpunkcijski znak)
  - =={== i ==}== su za skakanje od odlomka do odlomka (izgleda da traže prazan redak)
  - ==[[== i ==]]== su za skakanje naprijed-nazad po početcima sekcija, a ==[]== i ==][== su za skakanje po krajevima sekcija 

### f, F, t, T, s, ';' i ',', %, g- (za traženje znakova)
  - ==f== i ==t== su vrhunske komande za skakanje do idućeg proizvoljnog znaka. Sintaksa je `f<znak> ` ili `t<znak>`, a razlika je u tome što će `f` skočiti na znak, a `t` će skočiti do odmah do znaka
  - ==F== i ==T== su isto što i `f` i `t`, ali skaču u suprotnom smjeru (traže prethodno)
    - `;` traži iduće podudaranje zadnjeg traženog znaka unutar retka sa slovom ispod kursora, a `,`  prethodno
  - ==%== je komanda za skakanje do para dvodijelnog interpunkcijskog znaka ispod kursora, poput (), [], {}, <> itd. (a u slučaju da takav znak nije smješten pod kursor, skočit će do prvog znaka koji zadovoljava taj kriterij)
  - `g-` će skočiti do prve brojke u retku
  - ==s== je u *lazyvim*-u namješten kao prečac za `flash` (nešto kao slabiji `snipe` ili `aye` u Emacsu), a ==vR== otvara `Treesitter search` koji još pametnije omogućuje automatsku selekciju teksta odmah po skakanju. (==vS== je za `Treesitter flash` koji omogućuje selekciju od točke kursora do rezultata pretrage)

### /, ?, *, #, vS, vR, gd, gf i K  (za traženje izraza)
  - ==/== i ==?== su za traženje određenih riječi direktno u tekstu
    - oznake `n` i `N` su za skakanja na iduća i prethodna podudaranja, a `<enter>` je za ulazak u tekst
    - `gn` i `gN` su posebne oznake za iduće ili prethodno podudaranje koje se mogu uparivati sa operaterima, npr. `dgn` će izbrisati iduće podudarajuće mjesto iz teksta, a jednom kada je izvršeno `.` može nadalje zamijeniti cijeli `dgn` 
  - `*` i ==#== su za olakšano pretraživanje unaprijed i unazad jer se za unos traženog pojma odmah uzima riječ ispod kursora
  - ==gd== i ==gf== su napredne funkcije za programiranje koje skaču na mjesta definicija i otvaraju uvezene datoteke
  - ==K== je komanda za otvaranje *man* dokumentacije za riječ ispod kursora 

## Za pisca (insert mod)
- tu se nama puno za reći što nije uobičajeno u ostalim tekstovnim urednicima, ali je potrebno brzo i lako skakati iz moda u mod, uvijek prvo u normalni, pa dalje kako treba (pisac + istraživač = urednik, pisac + domar = kompozitor, pisac + strojar = redaktor)
- svejedno, ima i tu prečaca koji su korisni:
  + ==<C-h>== je backspace
  + ==<C-w>== je backspace ali za cijelu riječ
  + ==<C-u>== je backspace, ali za cijeli red
  + ==<C-r><ime-registra>== će biti za paste-anje iz registra (v. dolje)
  + ==<C-r>.== je za posebni registar u kojem je spremljeno štogod je zadnje utipkano u *insert* modu, a ==<lC-a>== je prečac za to (ali ne u *evil-modu* jer je u Emacsu to prečac za skok na početak reda) 
  + ==<C-c>==, ==<C-x>== i  ==<C-v>== će vjerojatno u svim Vimovima raditi kako i očekivano kada u insert modu
  + ==<C-p>== i ==<C-n>== su za pokretanje *autocomplete*-a (s `p` je za pretragu sličnih riječi unazad unutar dokumenta, a s `n` je za pronalaženje sličnih riječi unaprijed, ali obje komande pretržuju cijeli dokument)
  + ==<C-x>== je za ulazak u mod za *autocomplete* sa lokalnim kontekstom (ponovno ne u *evil-modu* jer emacs ima jasnu prednost za `<C-x>` Emacsu)
    + to se može nastaviti s `<C-n>` ili `<C-p>` kako bi se listalo kroz ponuđene prijedloge
    + s dodatkom `f` Vim će zanti da želimo unijeti ime datoteke, pa će to za dovršetke nuditi URL-ove 
    + s `<C-x><C-o>` se ulazi u *omnicomplete* mod koji je prema ekstenziji datoteke prilagođen programskom jeziku kojeg se rabi (?)
  + kada god poželimo, uvijek možemo dok smo u insert modu lupiti `<C-o>` i nakon toga unijeti koju god komandu iz normal moda želimo (bez da zapravo izađemo iz insert moda)
- ==gq== je prečac za formatiranje teksta (npr. `gqap` je za formatiranje aktivnog odlomka), a druga opcija za isti efekt je selektirati tekst koji želimo formatirati i onda lupiti `=`
- Vim ima nazive za razne semantičke cjeline koje se onda može rabiti za selekciju s prefiksima `i` (in) i `a` (around):
  - `w` je za ==riječ==
  - `s` je za ==rečenicu==
  - `p` je za ==odlomak==
  - `b` je za ==blok== (unutar zagrada, vitica, čeggod što određuje blok koda)
  - `t` je za ==tag==
  - a cjeline se mogu identificirati i eksplicitno s svim vrstama navodinka ili zagrada
    - a selektiranje se može prošitriti s unošenjem brojeva, npr. `d2i(` će izbrisati sve unutar drugog reda zagrada gledajući s pozicije kursora
    
### Pisci u vizualnom modu
  + `zc` i `zo` su za *foldanje* i *unfoldanje* pojedinačnih odlomaka, funkcija.... 
    + `zM` i `zR` su za *foldanje* i *unfoldanje* svih odlomaka, funkcija.... odjednom
  + `>>`, `<<` i `==` su za uvlake: uvlačenje za jednu mjeru, izvlačenje za jednu mjeru i izvlačenje retka na početak linije
  + `<C-a>` i `<C-x>` su za povećavanje za 1 ili smanjivanje bilokakve brojke u aktivnom retku (ili ispod kursora) (ne u *evil-mode*-u)

### Pisci u komandnom modu
  + `:read <url-datoteke>` je komanda za učitati sadržaj neke vanjske datoteke na mjesto kursora
    + `:read !ls <url>` ovo je samo primjer kako se može dohvatiti bilokakav izlaz shell komande i ispisati ga na mjestu kursora 
    + `:read !jq.<svojstvo> <url-datoteke>` je za učitavanje vrijednosti nekog svojstva iz *.json* datoteke (uz pretpostavku da je u radnom okružju instaliran alat *jq*) i ispisivanje ga na mjesto kursora
    + `'<,'>!jq.<svojstvo>` je za učitavanje nekog svojstva iz selektiranog objekta u tekstu otvorenog dokumenta i ispisivanje ga namjesto selektiranog teksta (?)
  + `:sort` je za sortiranje svih linija u dokumentu (?), a `:sort u` za sortiranje i zadržavanje jedinstvenih redaka (?), a `:sort!` je za obrtanje redoslijeda
  + `:%s/<traženi-uzorak>/<zamjena>/<zastavice>` je komanda za *find/change*, a zastavice mogu biti `g` za golobalno, `r` za pitati prije zamjene, `u` za neosjetljivu pretragu po veličini slova #provjeriti
    + ovo je vrlo moćan alat jer omogućuje porabu svih alata *regex*-a, npr. `:%s/\(.*\),\(.*\),\(.*\)/\2,\1,\3/g` će zamijeniti prvi i drugu kolumnu u *.csv*-u
  + `:g/<uzorak>/d` je za izbrisati sve retke koji počinju s određenim uzorkom teksta, a `:v/<uzorak>/d` za brisanje svih redaka koji ne započinju uzorkom teksta

## Za domara (vizualni mod)

### v, V, <C-v>
  - ==v== je za uobičajen ulazak u mod za selektiranje
  - ==V== je za ulazak u mod selekcije cijelih redaka
  - ==<C-v>== je za ulazak u mod *blok selekcije*, a taj je pak pogodan za multi-cursor mod ili sl.

### (v,) d, c, y, =, g~ (gu, gU), p (aka. operatori)

  - operatori su posebne komande koje zahtijevaju daljnje upute. Najjednostavniji (i ne potpuno primjeren) primjer je komanda ==v== koja nas ubacuje u vizualni mod, a zbog naravi vizualnog moda funkcionira kao operater. Komanda `vw`, npr., selektira tekst do kraja riječi.
    1) uobičajeni oblik unošenja komandi s operaterima u normalnom modu je `<operater><broj><kretnja>`
      - npr. `d5w` briše pet riječi, a `y2k` kopira aktivni i prethodna dva retka
    2) drugi format unošenja komandi s operaterima je `<operator><potraga>`
      - npr. `df"` briše sve do idućih navodnika, a `c/return` briše sve do naredbe 'return', a tako bi `ggdG` izbrisalo cijeli dokument.
    3) treći način porabe operatera je s porabom selektora i identifikatora *tekstovnih objekata*, a ti su:
      - **selektori** - ==i== i ==a== kao sinonimi za 'cijele riječi' i 'riječi i sve okolo'
      - **identifikatori** - ==w== (riječ), ==s== (rečenica), ==p== (odlomak), ==b== ili ==(== (ono unutar zagrada), ==B== ili =={== (ono unutar vitica), ==t== za HTML ili XML tag (!), te =="== ili =='== (ono unutar navodnika), a opcije su još ==<== i ==[== i svi obrnuti parovi dvodjelnih interpunkcija
    4) u vizualnom modu, operacija je obrnuta nego u normalnom (1), a ta je `v<kretnja><operator>`. Vizualni je mod nešto sporiji, ali daje vizualne naznake o tome što će se odviti kada izvršimo komandu

#### Operatori
  - ==d== je operater za brisanje
    - ima dvije kratice `D` za brisanje sveg do kraja retka i `dd` za brisanje cijelog retka
  - ==c== je oprater za izmjenu (kombinacija `d` i `i`)
    - također ima dvije jednake kratice `C` i `cc` za izmjenu teksta do kraja i cijeli redak
  - ==y== je operater za kopiranje
    - prečaci `yy` i `Y` rade isto i kopiraju cijeli redak
  - ==p== je za "put", odnosno paste-anje
    - ima prečac `P` za pastanje prije kursora, a jedina funkcija koju sam skužio je kad imam iskopiran cijeli redak, mogu ga pasteati prije retka u kojem se nalazim
    - ==<C-r><ime-registra>== kada u *insert modu* nije za redo, već za pasteanje
  - =='='== je za formatiranje koda, ali moram biti u datoteci s ekstenzijom
  - ==g~== je za izmjenu VELIKIH/malih slova (`gu` za mala, `gU` za velika, `g~` za obrtanje)

#### Prečci
  - ==x== za brisanje slova (`dl`, a radi kao <\DEL>)
  - ==X== za brisanje slova u nazad (`dh`, a radi kao <\BKSP>)
  - ==s== za brisanje slova i ulazak u insert mod (`cl`, `dli`)
  - ==r== za zamjenu jednog slovnog znaka "bez ulaska u insert mod" (`cl{}<esc>`)
  - ==~== za promjenu VEL/mal jednog slovnog znaka (`g~l`)
    - `~~` je za obrtanje slovnog znaka i selektiranje idućeg, a `g~~` je za obrtanje svih znakova u retku

#### Registri
  - Registri su clipboardi. Vim ima puuno registara i trikova s njima. 
    - =="== je bezimeni registar u koji se sprema sve ako nije rečeno drukčije
    - ==0== je registar gdje se sprema sve kopirano (`y`)
    - ==(1-9)== su registri u koje se redom pohranjuje sve što smo izrezali s `d` ili `c`
    - ==(a-z)== su slobodni registri u koje možemo pohranjivati po volji
      - ==(A-Z)== su ponovljeni nazivi za gornje registre, ali kada ne želimo zamijeniti pohranjeni sadržaj, već želimo nadodati u njega. 
    - ==\*== i ==+== znam da postoje i tiču se nečega kao dijeljenog registra između različitih buffera, ali ne znam #provjeriti
      - npr., ==`*`== je registar za clipboard od Windowsa kada u WSL-u (a možda i gdje drugdje)
    - popis registara i njihovih sadržaja se može pregledati komandom `:reg` ili `:reg <ime-registra>` ako se želi pregledati sadržaj specifičnog registra

### Plugini
  - *surround* plugin je za baratanje uparenim (dvodjelnim) interpunkcijskim znakovima
    - ==ds== za brisanje okolnih interpunkcija, npr. `ds"` je za brisanje navodnika
    - ==cs== za zamjenu okolnih interpunkcija, npr. `cs[{` je za zamjenu uglatih s vitičastim zagradama
    - ==ys== za dodavanje okolne interpunkcije, npr. `ysaptli>` stavlja tag '<li>' oko odlomka (`ys<kretnja><znak>`)
    - sve surround izmjene se mogu onda ponavljati s komandom `.`

## Za strojara (komandni mod)

### u, <C-r>
  - ==u== i ==<C-r>== su za 'undo' i 'redo' u normalnom modu
    - u komandnom modu su `:u` ili `:undo` te `:redo` ekvivalentni gornjima
  
### <broj>, ., q, :g
  - ==<broj>== može prethoditi svakoj komandi i toliko će se puta komanda ponoviti
  - ==.== - operater `.` je univerzalna komanda za ponavljanje zadnje komande!!!
  - ==q<ime-registra>== je naredba za početak snimanja *makro komande* iz normalnog moda
    - ponovno stiskanje komande `q` u normalnom modu znači kraj snimanja makro naredbe
    - `@<ime-registra>` je za izvršavanje snimljene makro naredbe, a ponaša se kao operater, tako da se s njome može baratati kao i sa svim drugim operaterima (npr.`3@a` će triput izvršiti makro naredbu 'a')
    - ==:g== iliti ==:global== je globalna komanda za izvršavanje neke komande na svom tekstu koji odgovara nekom uzorku. Osnovna sintaksa je `<raspon>g/<uzorak>/<naredba>` 
      - `<raspon>` dio je ovdje jednako definiran kao i kod `:{}s` komande (% ili 4,10 ili '<,'>)
      - `<uzorak>` je bilo kakav regex uzorak
      - `<naredba>` je bilo kakva 'ex' naredba, a postoji i posebna naredba `normal <komanda>` gdje se pod <komanda> može unijeti bilo koji niz slovnih naredbi koji bi se unio u normanom modu
      - ==:v== je obrnuto izvrnuti `:g`

### Komande za baratanje sadržajem

  - ==@:== je komanda za ponavljanje zadnje komande, a ==@@== za ponavljanje ponovljene komande
  - ==:y== iliti ==:yank==
  - ==:p== iliti ==:put==
  - ==:copy==
  - ==:move==
  - ==:s== iliti ==:substitute== je find/replace komanda sintakse `<raspon>s/<traženi-pojam>/<novi-pojam>/<zastavice>` 
    - prefiksi za raspon mogu biti `` (aktivni redak) i `%` (cijeli dokument); (a valjda mogu biti i raspon i selekcija ???)
    - zastavice mogu biti ==g== (global), ==i== (case insensitive) i ==c== (confirm all changes)
    - `:s` čita argumente kao regex, tako da se tu svašto može
  - ==:[raspon-redaka]<komanda> [opcije]== - standardni oblik komandi
    - npr. `10,12d a` briše retke 10-12 i sprema ih u registar 'a'
      - `:%d` briše sav sadržaj datoteke
      - `:.,+6d` briše šest redaka od onog aktivnog
      - `:'<,'>d` briše sve unutar selekcije

### Komande za baratanje dokumentima i prozorima
- ==:w== iliti ==:write== - spremanje, a može primiti i argument imena datoteke (`:w nova-datoteka.md`)
    - ==:wa== iliti ==:wall== - pohranjuje sve otvorene datoteke
    - sufiks `!` znači da se komanda treba izvršiti makar ju nešto blokira
  - ==:e== iliti ==:edit== - otvaranje postojeće datoteke ili stvaranej nove (`:e ime-datoteke.md`)
    - sufiks `!` znači da se komanda treba izvršiti makar ju nešto blokira
    - ==:sp== i ==:vsp== su isto što i `:e`, ali dijele ekran u dva panela (split)
      - dulji način za postizanje istog efekta je `<C-w>s` ili `<C-w>v` sljeđen s `:e <ime-datoteke>`
      - kretanje između panela se obavlja s pomoću komandi `<C-w>(h,j,k ili l)` 
      - alternativa panelima (*panes*) su ploče (*tabs*), a njih se otvara komandom `:tabnew`
        - za navigaciju među pločama rabe se `:tabn` iliti `:tabnext`, `:tabp` iliti `:tabprevious` i `:tabo` iliga `:tabonly` (za zatvaranje svih tabova osim aktivnog)
  - ==:q== iliti ==:quit== - zatvaranje aktivne datoteke
    - ==:qa== iliti ==:qall== - zatvaranje svih otvorenih datoteka
    - sufiks `!` znači da se komanda treba izvršiti makar ju nešto blokira

### Vimscript i .vimrc
  - naravno da Vim ima svoj skriptni jezik: [learnvimscriptthehardway](https://learnvimscriptthehardway.stevelosh.com/)
  - to je najočitije korisno u organizaciji *.vimrc*-a
  - postoje tri vrste varijabli:
    - obične (*options*)
      - `set var=30 | echo &var`
    - key-bindings (*mappings*)
      - kratice na tipkovnici (npr. `nnoremap <kombinacija-tipki> <kombinacija-komandi>`)
    - kratice (*abbreviations*)
      - kratice u tekstu (`iabbrev <kratica> <tekst-za-ispisati>`)
