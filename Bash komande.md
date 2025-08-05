# Biljeske za bash komande

Uglavnom preuzeto iz [freecodecamp](https://www.freecodecamp.org/news/the-linux-commands-handbook).

Postoje neke uobičajene komande za sve shellove jer svi vjerojatno koriste *readline* editor za uređivanje teksta komandi (v. [Readlinr Cheat Sheet](https://readline.kablamo.org/emacs.html):
  + `<up>` će započeti listanje po prethodno unesenim komandama
    + `<C-M-y>` će vratiti samo prvu riječ zadnje komande ili tako nešto (možda bez parametara ili štoveć)
    + `!` bi trebalo ibiti kratica za ponovno izvršavanje zadnje komande (ali čini se da u *fish*-u nije)
  + `<C-r>` će pretraživati po povijesti prije unesenih komandi
  + `<C-a>` i `<C-e>` su za skakanje na početak ili kraj retka
  + `<C-w>` je za brisanje cijele riječi unazad
  + `<M-t>` je za zamjenu mjesta zadnje dvije riječi prije kursora, a `<C-t>` bi trebao biti za zamjenu zadnja dva slova (no obično je prečac preuzet od *fd*-a)
  + `<C-u>` i `<C-k>` su za brisanje teksta od kursora do početka ili kraja linije
  + `<C-l>` "čisti" ekran starih komandi i izlaza 
  + `cd ~` ili `cd` su za skočiti u *home* direktorij
  + `cd -` je za skočiti na zadnju lokaciju gdje smo bili
  + ==.inputrc== je datoteka za unošenje početnih postavki *readline*-a, npr. `set expand-tilde on`

## Za istraživača

### man, whatis, apropos, tldr
  - pomoćne naredbe za dobivanje dodatnih informacija o dostupnim komandama
  - ==man== je skraćeno za ugrađeni *manual*
  - ==whatis== ispisuje u nekoliko riječi osnovnu namjenu komande
  - ==apropos== slično kao `whatis` daje kratak opis komande, ali i popis povezanih komandi uz njihove opise
  - ==tldr== ne dolazi predinstaliran, ali na vrlo zgodan način opisuje poantu komandi i nudi popise primjera uobičajenih primjena

### pwd, whoami, cd, su, open, which 
  - ==pwd== jednostavno ispisuje direktorij u kojem se trenutno nalazimo
  - ==whoami== ispisuje ime korisnika (pogledaj dolje i `id`)
  - ==cd== je za promjenu direktorija `cd (<url-novog-direktorija>`)
  - ==open== je za otvaranje lokacije (datoteke ili direktorija) defaultnim programom
  - kako se ovdje radi gotovo isključivo o tekstovnim datotekama, linux dođe s (ili se mogu instalirati) brojnim tekst editorima: `vi`, `vim`, `nvim`, `nano`, `micro`, `kate`, `emacs`...
  - ==which== javlja adresu gdje je pohranjena datoteka komandi prisutnih u radnom okružju

### ls, find
  - ==ls== je za izlistavanje popisa direktorija. Osnovna sintaksa je `ls <dir/dat>`, a dodatne oznake su: 
    - `-a` za prikaz skrivenih datoteka
    - `-l` za prikaz više podataka u obliku tablice, a tu onda se mogu dodati
      - `-h` za prikaz veličine datoteka na razumljiv način
      - `-i` za prikaz identifikacijskog broja datoteka i direktorija
  - ==find== je za pronalaženje datoteka u direktorijima
    - npr. `find . -name "*.md"` ili `find . -type d -iname src`, a moze se istovremeno traziti na vise lokacija `find loc1 loc2 -type l -iname banan*.md`
    - tu gore su onda tipovi stvari za traziti `d` (direktorij), `f` (file) i `l` (link), a oznaka `-iname` je za trazenje bez obzira na velika/mala slova
    - mogu se koristiti i logicki operatori `-or` ili `-not`, npr. `find ~/docs -type f -name "*.md" -or "*.txt" -not -path "*/private/"`
    - postoje još oznake `-size` (za max velicinu datoteke), `-mtime` (za filter po datumu izrade, npr. +3 za "barem 3 dana staro")
    - možda najpotentnije je `-exec` za primjenu komande po svakom rezultatu, npr. `find . -type f -exec cat {} \;` 

### head, tail, more/less, cat, sort, uniq, grep, wc
  - ==head== i ==tail== ispisuju prvih i zadnjih *n* redaka iz datoteke ili stdout-a. Oznake koje rabe su
    - `-f` da im se kaže da će ulaz dobit iz datoteke
    - `-n` da im se kaže koliko redaka da učitaju (može se upisati konkretan broj redaka ili broj s prefiksom '+' što onda znači da se uputa odnosi na konkretni redak od kojeg želimo učitati raniji ili kasniji tekst)
  - ==cat== ima više funkcija:
    - iščitava sadržaj datoteke i ispisuje u teminal
    - iščitava stdin, pa ga može proslijediti. Npr. `cat >> input.txt` će držati file otvoren i upisivati u njega štogod istipkali u terminal
  - ==less== je pobiljšanje naredbe ==more==, a služi za lakše iščitavanje ispisanog sadržaja nego što to čini `cat` prikazujući ga kroz nekakav primitivan čitač. Osnovna sintaksa je `less <datoteka>`.
    - nema nikakvih oznaka koje se dodaju unaprijed u komandu, ali jednom kada se prikaže sadržaj mogu se rabiti *vimolike* komande za pregledavanje sadržaja:
      - `←`,`→`,`↓` i `↑` te <space> i `b`, `g` i `G` za navigaciju kroz sadržaj
      - `/` i `?` (valjda onda i `n` i `N`) za tražilicu unutar sadržaja
      - `v` za otvaranje sadržaja u uredniku poput vim-a
      - `F` za uklučivanje moda za praćenje izmjena uživo (npr. ako još tko uređuje sadržaj ili ako je stream-an)
      - <C-c> ili `:q`  je za izlaz, a `:n` i `:p` za otvaranje prethodnih, idućih datoteka, kada ih je otvoreno više odjednom

### tmux
  - ==tmux== je aplikacija koja treba posebnu instalaciju, ali je iznimno korisna za baratanje s terminalima i prozorima kada aplikacija terminala sama po sebi to ne rješava
    - prva komanda je uvijek `tmux new` (skraćeno za`new-session`) 
    - kada je sesija otvorena, rabe se tipkovničke komande. Prva je <C-b> jer je zadana kao defaultni okidač (prefiks) za sve tmux-ove komande
    - nakon toga treba zpamtiti barem <C-?> jer ona daje popis svih 68 dostupnih komandi (v. [github/tmux](https://github.com/tmux/tmux/wiki/Getting-Started))
    - ostale zgodne komande su:
      - <C-b>'' ili <C-b>% za podjelu ekrana na područja
      - <C-b>(←→↓↑) za ulazak/izlazak iz određenog područja, a pored toga u istu svrhu su <C-b>o i <C-b><M-o> za ulazak u iduće/prethodno područje, ili pak <C-b>q za prikaz broja svakog područja te 
      - <C-b>z za zumiranje u i iz aktivnog  područja
      - <C-b>x za zatvaranje aktivnog područja
      - <C-b><space> ili <C-b><C-o> ili <C-b><M-(1-5)> za promjene rasporeda područja, a <C-b><C-(←→↓↑)> navodno za mijenjanje dimenzija podrčja (ali mi ne radi)
      - <C-b>c za stvaranje novog prozora (desktopa) i onda <C-b>(0-9) za biranje aktivnog prozora, a <C-b>& za zatvaranje prozora

## Za domara

### mkdir, rmdir, touch, rm
  - ==mkdir== je za stvaranje direktorija
    - jedino zanimljivo je sto mu se moze dodati oznaka `-p` kako bi se mogli stvoriti ugnjezdjeni direktoriji
  - ==rmdir== je za brisanje praznog direktorija
  - ==touch== je za stvaranje datoteki
  - ==rm== je za brisanje datoteki, ali služi kao glavna direktiva za brisanje bilo čega
    - oznaka `-r` je za rekurzivno brisanje datoteka i direktorija
    - oznaka `-f` je za *force* 

### mv, cp, ln
  - ==mv== je za pomicanje datoteka ili direktorija
    - može se premještati više datoteka odjednom ako ih se sve seli u isti direktorij (`mv <dat1> <dat2> <dat3> <dir>`)
  - ==cp== je za kopiranje datoteka ili direktorija. Osnovna sintaksa je `cp <dat> <nova-dat>` (kopiraj što u što).
    - ako se želi kopirati direktorije, treba se rabiti zastavica `-r` za rekurzivno kopiranje sadržaja (`cp -r <dir> <novi-dir>`)
  - ==ln== je za stvaranje poveznica na datoteke ili direktorije
    - tu je zanimljivo što je početna postavka stvranje *hard* poveznice koja je zapravo (kao i sve datoteke) samo pointer na mjesto u memoriji, pa tako isti podatci u memoriji mogu biti referencirani od proizvoljnog broja datoteka proizvoljnih naziva. Mjesto u memoriji ostaje sačuvano dokle god ima datoteka (tvrdih poveznica) na nj.
    - oznaka `-s` znači da želimo stvoriti *simboličku* ili *soft* poveznicu koja je nova datoteka i novo mjesto u memoriji koje sadrži samo podatke o referenci na datoteku koju želimo povezati. Ako se datoteka na koju želimo povezati izbriše, poveznica više ne upućuje ninašto.

### gzipr, gunzip i tar
  - ==gzip== je za zipanje datoteka (po defaultu izbriše original i stvori datoteku s istim imenom i ekstenzijom .gz)
    - oznaka `-c` je za mijenjanje gornjeg ponašanja i preusmjeravanje izlaza u datoteku drugog naziva `gzip -c file1 > file2.gz`, a i `-k` je za tako nešto (?)
    - `-(1-9)` je za stupanj kompresije, gdje je je 1 najniži stupanj (najbrži, najmanje kompresije), a 9 najviši (najsporiji, najbolja kompresija)
    - može se, naravno, više datoteka odjednom komprimirati (`gzip file1 file2 file3 ...`) ili rekurzivno (`gzip -r dir/`)
    - oznaka `-d` je za dekompresiju
  - ==gunzip== je obrnuto od gzip-a, jedino nema opciju `-d` :)
  - ==tar== je za udruzivanje hrpe datoteka u jednu `tar -cf arhiva.tar file1 file2...`, ali nema kompresiju
    - `-c` je za pakiranje u tar paket (*create*), 
    - `-x` je za raspakiravanje iz tar paketa (*extract*), dakle `tar -xf arhiva.tar -C dir/` je za otpakiravanje arhive u neki direktorij
	- `-f` je za davanje imena arhivskoj datoteci koju se stvara ili iz koje se raspakirava (*write to file*)
	- `-v` se može dodati kako bi se dobio jasniji uvid u to što se događa tijekom zapakiravanja ili otpakiravanja tar ili gzip datoteka (*verbose*)
    - s oznakom `-tf` je kao `ls`, ali za .tar datoteke
    - `-z` je za dodavanje kompresije, dakle `tar -czf arhiva.tar.gz dir/*` će sve datoteke iz direktorija *dir* zapakirati u komprimiranu tar arhivu
    - za dodatne informacije i funkcije za raspakiravanje različitih arhiva pogledati [xvoland/Extract](https://github.com/xvoland/Extract)

## Za vratara

### useradd, userdel, usermod, groupadd, chsh, passwd, id
  - ==id== je za dobivanje identifikacijskog broja (ili imena) usera
    - oznaka `-n` je za dobivanje imena mjesto broja
  - ==useradd== stvara novog korsnika: `useradd <ime>` ili `useradd -D <ime>`
    - dodatne oznake su `-s` iliti `--shell` ya definiciju shella koji će user rabiti, `-d` ili ti `--home` za matični  direktorij, `-m` iliti `--create-home` za stvoriti direktorij ako ga nema (to je definirano i drugdje za sve usere), `-k` iliti `--skel` za template (skeleton) direktorij koji treba kopirati yajedno sa svim njegovim datotekama pri stvaranju $HOME direktorija za novog usera, `-g` za grupu ili `-G` za grupe kojima će pripadati, `-e` iliti `--expiredate` za definiranje isteka valjanosti računa, `-p` iliti `--password` za lozinku ??, ... 
  - ==usermod== je za promjenu grupe kojoj korisnik pripada: `sudo usermod -g <nova-login-grupa> <korisnik>`. Najčešće se radi kako bi se korisnika dodalo grupi "wheel" kojoj se daju administratorske ovlasti.
    - grupa kojoj korisnik pripada može se provjeriti s `id -g`za trenutnu grupu ili `id -G` za popis svih grupa kojima user pripada (`-n` je za dobivanje imena mjesto broja)
    - usermod ima nekoliko bitnih oznaka:
      - `-a` iliti `--append` kada se želi dodati grupa u popis korisnikovih grupa (mjesto samo zamijeniti grupu)
      - `-d` iliti `--home` da bi se odredio $HOME direktorij usera, a slično tome je `-m` iliti `--move-home` ako user već ima $HOME direktorij i želi ga se preseliti sa svim sadržajima u novi direktorij (`usermod -d <new-home> <user>`)
      - `-s` iliti `--shell` za definiranje korisnikovog login shella
      - `-u` iliti `--uid` za dodjeljivanje novog id broja
    - usermod makes use of the following files:
    /etc/group    -  Group account information.
    /etc/gshadow  - Secure group account information.
    /etc/login.defs - Shadow password suite configuration.
    /etc/passwd   - User account information.
    /etc/shadow   - Secure user account information.

### sudo, chmod, chown
  - ==sudo== je skraćeno za 'super user do' ili tako nešto i slično je alternativnoj komandi `doas`, a služi za privremeno dopuštanje useru ovlasti root-a
  - ==chmod== je za promjenu dozvola na datoteci: `sudo chmod <kako> <datoteka>` Zanimljiv je ovaj <kako> dio jer ima više načina kako se može unijeti:      | 4 2 1 |
    - svaka datoteka ima oznake pristupa | r w x | gdje je svakom stupnju dozvole dodjeljena određena vrijednost po tri puta (za korisnika, za grupu, za javnost). Tako da kada se brojevi zbroje, dobijemo npr. 644 (svi mogu čitati, ali samo korisnik može pisati) ili 755 (svi mogu čitati i izvršavati datoteke, ali samo korisnik može pisati)
  - ==chown== je za promjenu vlasnika. Sintaksa je `sudo chown <user>:<groupa> <datoteka>`, iako se može izostaviti ili korisnik ili grupa. Paralelna naredba chown-u je `chgrp`.
    - `-R` iliti `--recursive` je ako se želi promijeniti vlasništvo nad cijelim direktorijem i podmapama
    - `-H` i `-L` imaju slične uloge kao i `-R`, ali se odnose na simbolične poveznice i kažu da se naredba treba proslijediti i na simbolički povezane sadržaje. Oznaka `-P` to poništava i početna je postavka.
    - `--from <trenutni korisnik>:<trenutna grupa>` je opcija za filtriranje na što će se naredba promijeniti
    - `--reference <datoteka>` je način unošenja uputa u što se vlasnik mijenja ("isti kao u onoj tamo datoteci")
    - `-v` iliti `--verbose`, `-c` iliti `-changes`, `-f` iliti `--silent` ili `--quiet` su upute o tome kako izvješćivati o rezultatu komande

## Za strojara

### chsh
  - ==chsh== je za mijenjanje defaultnog shella nekog korisnika: `chsh -s <url-do-shella> [<korisnik>]` (da bi se moglo primijeniti shell mora biti unesen i u popis pouzdanih shellova u /etc/shells datoteci), a oznaka `-s` je tu da da uputu kako se mijenja "login shell"

### alias


### apk, apt, apt-get, brew, aur, dnf


### jobs, fg, bg, ps, kill, top, atop, htop, btop


