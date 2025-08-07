# Bilješke za Bash komande i GNU/Linux sustav općenito

Reference:
	- [freecodecamp](https://www.freecodecamp.org/news/the-linux-commands-handbook).
	- [Linux Journey](https://linuxjourney.com)

Postoje neke uobičajene komande za sve shellove jer svi vjerojatno koriste *readline* editor za uređivanje teksta komandi (v. [Readlinr Cheat Sheet](https://readline.kablamo.org/emacs.html):
  + `<C-r>` će pretraživati po povijesti prije unesenih komandi
  + `<up>` će započeti listanje po prethodno unesenim komandama
    + `<C-M-y>` će vratiti samo prvu riječ zadnje komande ili tako nešto (možda bez parametara ili štoveć)
    + `!!` bi trebalo ibiti kratica za ponovno izvršavanje zadnje komande (ali čini se da u *fish*-u nije)
  + `<C-a>` i `<C-e>` su za skakanje na početak ili kraj retka
  + `<C-w>` je za brisanje cijele riječi unazad
  + `<M-t>` je za zamjenu mjesta zadnje dvije riječi prije kursora, a `<C-t>` bi trebao biti za zamjenu zadnja dva slova (no obično je prečac preuzet od *fd*-a)
  + `<C-u>` i `<C-k>` su za brisanje teksta od kursora do početka ili kraja linije
  + `<C-l>` "čisti" ekran starih komandi i izlaza 
  + `cd ~` ili samo `cd` su za skočiti u *home* direktorij
  + `cd -` je za skočiti na zadnju lokaciju gdje smo bili
  + kao i za većinu tvorničkih postavki, početne korisničke postavke za *readline* ili *shell* programe nalaze se u `/etc` direktoriju (vidi npr. `less /etc/inputrc`)
  + ==.profile== datoteka za osnovne postavke korisnik. Prva se automatski učitava od svih korisničkih postavki
  + ==.inputrc== je datoteka za unošenje početnih postavki za sve programe koje rabe *GNU readline library* (uključujući i *bash* i sl. *shell*-ove, ali i ==vim== i ==emacs== i sl. urednici), npr. `set expand-tilde on`
  + ==.bashrc== datoteka za osnovne postavke *bash* *shell*-a
	- ostali *shell* programi rabe druge datoteke za svoje temeljne postavke (npr. *fish* postavke očekuje u `~/.config/fish/config.fish`) 

## Za istraživača

### man, help, --help, whatis, apropos, tldr
  - pomoćne naredbe za dobivanje dodatnih informacija o dostupnim komandama
  - ==man== je skraćeno za ugrađeni *manual*
  - ==help== ili oznaka `--help` obično ispisuju ulomke iz *manpages*-a na ekranu (a ponekad to čini i ispisivanje same komande bez oznaka ili parametara)
  - ==whatis== ispisuje u nekoliko riječi o osnovnoj namjeni komande
  - ==apropos== slično kao `whatis` daje kratak opis komande, ali i popis povezanih komandi uz njihove opise
  - ==tldr== ne dolazi predinstaliran, ali na vrlo zgodan način opisuje poantu komandi i nudi popise primjera uobičajenih primjena

### pwd, whoami, cd, su, open, which 
  - ==pwd== jednostavno ispisuje direktorij u kojem se trenutno nalazimo
  - ==whoami== ispisuje ime korisnika (pogledaj dolje i `id`)
  - ==cd== je za promjenu direktorija `cd (<url-novog-direktorija>`)
  - ==open== je za otvaranje lokacije (datoteke ili direktorija) defaultnim programom
  - kako se ovdje radi gotovo isključivo o tekstovnim datotekama, linux dođe s (ili se mogu instalirati) brojnim tekst editorima: `vi`, `vim`, `nvim`, `nano`, `micro`, `kate`, `emacs`...
  - ==which== javlja adresu gdje je pohranjena datoteka komandi prisutnih u radnom okružju

### ls, stat, find, (fzf, rg)
  - ==ls== je za izlistavanje popisa direktorija. Osnovna sintaksa je `ls <dir/dat>`, a dodatne oznake su: 
    - `-a` za prikaz skrivenih datoteka
    - `-l` za prikaz više podataka u obliku tablice, a tu onda se mogu dodati
      - `-h` za prikaz veličine datoteka na razumljiv način
      - `-i` za prikaz identifikacijskog (*inode UUID*) broja datoteka i direktorija
  - ==stat== je komanda koja daje još više podataka o određenoj datoteci
  - ==find== je za pronalaženje datoteka u direktorijima
    - npr. `find . -name "*.md"` ili `find . -type d -iname src`, a moze se istovremeno traziti na vise lokacija `find loc1 loc2 -type l -iname banan*.md`
    - tu gore su onda tipovi stvari za traziti `d` (direktorij), `f` (file) i `l` (link), a oznaka `-iname` je za trazenje bez obzira na velika/mala slova
    - mogu se koristiti i logicki operatori `-or` ili `-not`, npr. `find ~/docs -type f -name "*.md" -or "*.txt" -not -path "*/private/"`
    - postoje još oznake `-size` (za max velicinu datoteke), `-mtime` (za filter po datumu izrade, npr. +3 za "barem 3 dana staro")
    - možda najpotentnije je `-exec` za primjenu komande po svakom rezultatu, npr. `find . -type f -exec cat {} \;` 

### head, tail, cat, more/less, sort, uniq, grep, cut, paste
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
      - `<C-c>` ili `:q`  je za izlaz, a `:n` i `:p` za otvaranje prethodnih, idućih datoteka, kada ih je otvoreno više odjednom
  - `sort` omogućuje promjenu redoslijeda redaka iznosa neke komande
	- `-r` je oznaka za obrnut redoslijed
	- `-n` je oznaka za poredavanje po "numeričkoj vrijednosti" (?)
  - `uniq` je komanda za filtriranje ulaznih redaka i ispisivanje samo onih koji se u iznosu još nisu pojavili
	- `-c` je oznaka za dodavanje izbroja ponavljanja pojedine jedinstvene vrijednosti u iznosu
	- `-u` je oznaka za iznos samo onih koji se ne ponavljaju kroz retke unosa
	- `-d` je oznaka za iznos samo onih koji se ponavljaju kroz retke unosa
  - `grep` je vjerojatno najmočnija komanda za baratanje s tekstom, a omogućava pretraživanje i filtriranje teksta pomoću *regex* izraza, npr. `grep [0-9] file1.txt` će ispisati samo one retke u *file1.txt*-a koji sadrže brojčanu vrijednost
	- `-i` je oznaka za ignoriranje razlike između velikih i malih slova

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
    - oznaka `-s` znači da želimo stvoriti *simboličku* ili *soft* poveznicu koja je nova datoteka i novo mjesto u memoriji koje sadrži samo podatke o referenci na naziv datoteke koju želimo povezati. Ako se datoteka na koju želimo povezati izbriše, poveznica više ne upućuje ninašto

### gzip, gunzip i tar
  - ==gzip== je za zipanje datoteka (po defaultu izbriše original i stvori datoteku s istim imenom i ekstenzijom .gz)
    - oznaka `-c` je za mijenjanje gornjeg ponašanja i preusmjeravanje izlaza u datoteku drugog naziva `gzip -c file1 > file2.gz`, a i `-k` je za tako nešto (?)
    - `-(1-9)` je za stupanj kompresije, gdje je je 1 najniži stupanj (najbrži, najmanje kompresije), a 9 najviši (najsporiji, najbolja kompresija)
    - može se, naravno, više datoteka odjednom komprimirati (`gzip file1 file2 file3 ...`) ili rekurzivno (`gzip -r dir/`)
    - oznaka `-d` je za dekompresiju
  - ==gunzip== je obrnuto od gzip-a, jedino se razlikuje po tome što nema nema opciju `-d` i ne može komprimirati :)
  - ==tar== je za udruzivanje hrpe datoteka u jednu `tar -cf arhiva.tar file1 file2...`, ali defaultno bez kompresije, no također ima svoj način dodavanja kompresije
    - `-c` je za pakiranje u tar paket (*create*), 
    - `-x` je za raspakiravanje iz tar paketa (*extract*), dakle `tar -xf arhiva.tar -C dir/` je za otpakiravanje arhive u neki direktorij
	- `-v` je oznaka za detaljnije ispisivanje toga što se radi (*verbose*)
    - `-z` je za dodavanje kompresije (kada je upareno sa `-c` oznakom) ili pak odkomprimiravanje (kada je upareno sa `-x` oznakom), dakle `tar -czf arhiva.tar.gz dir/*` će sve datoteke iz direktorija *dir* zapakirati u komprimiranu tar arhivu *arhiva.tar.gz*, a `tar -xzf arhiva.tar.gz` će istu arhivu raspakirati u *dir/* direktorij (ako je tako originalno zapakirano gornjom komandom)
	- `-v` se može dodati kako bi se dobio jasniji uvid u to što se događa tijekom zapakiravanja ili otpakiravanja tar ili gzip datoteka (*verbose*)
	- `-f` je za davanje imena arhivskoj datoteci koju se stvara ili iz koje se raspakirava (*write to file*)
    - s oznakom `-tf` je kao `ls`, ali za .tar datoteke
    - za dodatne informacije i funkcije za raspakiravanje različitih arhiva pogledati [xvoland/Extract](https://github.com/xvoland/Extract)

### dd
  - `dd` je komanda za kopiranje datoteka ili izrade backupa npr. `dd if=/dev/sda of=sda-backup.img bs=1M` će napraviti ==.img== backup kopiju cijelog prvog HDD-a.

### env
	- ==env== je popis varijabli dostupnih programima u trenutnom radnom okružju 
		- znak `$` ispred imena varijable znači da želimo dohvatiti njezinu vrijednost, a bez tog znaka predstavlja naziv varijable (odnosno njezinu "adresu", pa tako možemo mijenjati i vrijednosti varijabli, npr. komanda `PATH=/home/user/.local/bin:$PATH` znači da varijabli path želimo unijeti na prvo mjesto pretraživanja direktorij `~/.local/bin/` i nakon toga nanizati sve do sada spremljene lokacije u varijabli PATH. Ovo je pisanje privremeno, do trenutka idućeg boot-a, pa da bi neku lokaciju trajno učinili dostupnom sustavu, potrebno je komandu dodati u `.bashrc` ili sličnu datoteku
		- `$HOME` je adresa `~` repozitorija ulogiranog korisnika, kao što je `$USER` njegovo ime, a `$PWD` njegova trenutna lokacija
		- `$PATH` je jedna od najvažnijih varijabli jer sadrži popis (podijeljen dvotočkama) lokacija svih izvršnih datoteka koje želimo moći pozvati kao komande. Ako se datoteka neke komande ne nalazi u $PATH varijabli, možemo ju pozvati jedino izričitim navođenjem adrese te datoteke, a ako se nalazi, računalo će to automatski provesti

### upravljanje diskovima i filesystemi, mkfs, blkid, mount, umount, df, du
  - diskovi se dijele u particije i svaka particija se dijeli na blokove. Osnovni blokovi svake particije su:
	  - ==boot block== pohranjuje datoteke za podozanje oprativnog sustava, zbog čega su uglavnom neiskorišteni na nesistemskim particijama
	  - ==super block== pohranjuje podatke o *filesystem*-u, poput veličina i lokacija ostalih blokova (u pravilu, uvijek slijedi *boot block*)
	  - ==inode block== (*index node*) je blok s tablicama i popisima svih pohranjenih datoteka i njihovih lokacija
	  - ==data block== je blok u kojem se nalazi ono što spremamo na diskove, tu se nalazi ono što se kolokvijalno naziva *filesystem*-om
  - postoji nekoliko vrsta *filesystem*-a:
	  - ==ext4== je standardni oblik trenutno defaultni sustav za pohranu datoteka u Linuxu 
	  - ==btrfs== je navodno brži i fleksibilniji sustav od *ext4* koji omogućuje snimanje *snapshot*-ova cijelog sustava i oporavljanje nakon grješki, ali trenutno još nije stabilan (a što sam iskusio na svojoj CachyOS particiji)
	  - ==fat== i ==ntfs== su Windows-ov sustavi za pohranu podataka
	  - ==hfs'== je MacOS-ov sustav za pohranu podataka
	  - ==xfs==, ==zfs==, ==jfs== itd. su dodatni sustavi za pohrane podataka sa naprednim opcijama za backupiranje i oporavljanje, najčešće rabljeni u kontekstu file servera ili cloud sustava
	  - ==swap== je posebna vrst particije kakva se u Linux sustavu rabi kao dodatna radna memorija (==!== Po pravilu bi morala biti dvostruko veća od dostupne RAM memorije instalirane na računalo!).
  - postoji nekoliko načina organizacije i praćenja podjele diskova na particije:
	  - ==mbr== je stari način koji koristi *primarne particije*, *extended particije* i unutar njih *logične particije*
		- upravlja se s njime pomoću `fdisk`, `parted` ili `gparted` programima
	  - ==gpt== je noviji sustav koji pruža više fleksibilnosti u baratanju s particijama
		- upravlja se s njime pomoću `gdisk`, `parted` ili `gparted` programima
	- `mkfs` je komanda za kreiranje *filesystem*-a iz prazne particije, npr. `sudo mkfs -t ext4 /dev/sdb2` će napraviti *ext4* particiju iz block uređaja (particije) učitanog kao */dev/sdb2*
	- `fsck` je komanda za pokušaj popravka korumpirane particije ili diska (bitno je da se to slučajno ne pokuša za aktivnu sistemsku particiju jer bi se postupak mogao na pola prekinuti i sve ostati zblokirano, tj. sistemske particije jednog sustava se popravljaju podižući neki drugi sustav sa neke druge particije)
	- `mount` je komanda za podizanje (*mount*) *filesystem*-a neke particije (npr. `sudo mount -t ext4 /dev/sdb2 /mydrive`), a `umount` za "otkačivanje" te particije (npr. `sudo umount /dev/sdb2` ili `sudo umount /mydrive`)
	- `blkid` je komanda za ispisivanje svih podignutih diskova popratno s njihovim **UUID** ovima - praktički ispisuje sadržaj datoteke ==/etc/fstab== (koju se može i direktno uređivati ako se zna što se radi)
	- `du` i `df` su komande za dohvaćanje informacija o iskorištenosti, odnosno slobodnosti dostupnih memorijskih blokova
		- `-h` je oznaka za ispis memorijskih veličina u ljudima razumljivom formatu
  - *filesystem*-om se naziva organizacija direktorija, poddirektorija i datoteka u nekom računalnom sustavu. Linux distribucije se donekle drže standardne organizacije datoteka:
	  - `/` je oznaka/naziv temeljnog (*root*) direktorija sustava. U njemu se sve nalazi kao poddirektorij
	  - `/bin` je direktorij koji sadrži praktički sve instalirane izvršne datoteke (programe; *binaries*)
		- `/usr` je direktorij za pohranu programa specifično instaliranih od strane ulogiranog korisnika (?)
		- `~/bin`, odnosno radije `~/.local/bin` su uobičajena mjesta za pohranu korisničkih komandi u obliku datoteka
	  - `/sbin` je direktorij koji sadrži sve sistemske izvršne datoteke
	  - `/boot` je direktorij koji pohranjuje datoteke za *kernel*-ov *bootloader*
	  - `/dev` i `/sys` direktoriji služe za pohranu datoteka o spojenim uređajima na računalo (što je ovdje opisano u komandama za strojara)
	  - `/etc` direktorij je namijenjen za pohranu sistemskih postavki 
	  - `/home` direktorij sadrži kao svoje poddirektorije direktorije svih korisnika
	  - `/lib` je direktorij za pohranu knjižnica komandi (*library*-ja) koje rabe programi sustava
	  - `/media` je direktorij gdje je predviđeno pričvršćivanje (*attach*) odstranjivih medija poput USB-a
	  - `/mnt` je direktorij gdje je predviđeno pričvršćivanje podigunutih (*mount*) *filesystem*-a
	  - `/proc` je direktorij za pohranjivanje informacija o aktivnim procesima
	  - `/tmp` je direktorij za pohranjivanje privremenih datoteka koje aktivni programi rabe za praćenje svog rada
	  - `/run` je direktorij za pohranu informacija o radu sustava od zadnjeg paljenja
	  - `/var` je direktorij za pohranu podataka koji se stalno mijenjaju ili nadopunjuju poput *log*-ova sustava ili *cache*-a

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
	  - `usermod` za svoj rad iščitava i upisuje u slijedeće datoteke:
		  - /etc/group    -  Group account information.
		  - /etc/gshadow  - Secure group account information.
		  - /etc/login.defs - Shadow password suite configuration.
		  - /etc/passwd   - User account information.
		  - /etc/shadow   - Secure user account information.

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

### boot
  - pri paljenju stroja, stvari se pokreću ovim redom:
	1) ==BIOS== se prvi pokreće sa posebne *boot* memorije matične ploče, provjerava integritet i pali sve *hardware*-ske komponente, provjerava `POST` test (*power-on self*) i, glavni zadatak, podiže pronalazi dostupan ispunjen *boot block* na diskovima i pokreće *bootloader*. Obično je opremljen grafičkim sučeljem za unošenje osnovnih postavki poput redoslijeda učitavanja diskova, postavke sistemskog vremena računala ili MAC adrese.
		- novija alternativa *BIOS*-u je ==UEFI== prisutna u većini suvremenih računala i sve svoje postavke sprema u `.efi` datoteku pohranjenu na posebnoj *EFI* particiji na harddisku
	2) ==Bootloader== je program koji podiže *kernel* željenog operativnog sustava zajedno sa željenim parametrima za podizanje *kernela*. Jedan od poznatijih *bootloader*-a je ==GRUB== i njegove su postavke (ono što će se proslijediti kao parametri kernelu) dostupne pritiskom tipke `e` tijekom prikaza *GRUB*-ova popisa dostupnih operativnih sustava/njihovih postavki.
		- uobičajene postavke za proslijediti kao parametre *kernel*-u su: `initrd` - lokacija RAM diskova za privremeno podizanje sustava i drivera prije učitavanja pravog *root* direktorija (nije potrebno za suvremene `initramfs` sustave koji sadrže privremeni *root* u *BOOT_IMAGE*-u); `BOOT_IMAGE` - lokacija kernelovog *image*-a; `root` - lokacija root direktorija; `ro` - podizanje sustava u *read only* modu; `quiet` i `splash` - za isključivanje ispisa "boot podataka" na ekranu i prikaz "splash" ekrana pri bootanju. 
	3) ==Kernel== je program koji priprema sve za podizanje operativnog sustava: inicijalizira (rezervira) uređaje i druge resurse, te pokreće *init* proces
		- nakon podizanja operativnog sustava, *kernel* ostaje zadužen za upravljanje procesima i memorijom, komunikacijom između uređaja, baratanje sistemskim komandama (*syscall*), postavljanjem *filesystem*-a, itd.
		- aktivni kernel sa informacijama o verziji i sl. se mogu dobiti komandom `uname -r` 
		- novi (dodatni) kerneli se na računalo mogu instalirati komandama poput `sudo apt install linux-generic-lts-vivid` uz instalaciju paketa ==linux-headers==, ==linux-image-generic== i sl.
		- aktivni kernel se može ažurirati komandom `sudo apt dist-upgrade`
		- kernel koristi modulrni sustav učitavanja drivera i sl. zvanih modulima, oni se mogu pregledavati komandom `lsmod`, privremeno učitavati sa npr. `sudo modprobe bluetooth`, isključivati s `sudo modprobe -r bluetooth` ili pak "trajno" učiniti dostupnima (ili nedostupnima s `blacklist`) dodavanjem konfiguracijskih datoteka za podizanje u `/etc/modprobe.d/[uređaj].conf` direktorij 
	4) ==Init== je proces koji pokreće i postavlja oprativni sustav učitavajući u radnu memoriju sve potrebne upute za rad oprativnog sustava, paljenje i gašenje servisa...
		- postoje tri glavne vrste *Init* procesa rabljenih u Linux distribucijama: 
			1. ==sysv== (System V init) je tradicionalni *init* sustav koji se vrti po predodređenoj skripti
			2. ==Upstart== je nešto noviji sustav koji pokreće *job*-ove prema *event*-ima
			3. ==systemd== je najnoviji sustav opće-prisutan u svim suvremenim Linux distribucijama i usmjereno je na postizanje određenih ciljeva (pokretanje i učitavanje svih zavisnih programa i knjižnica potrebnih za zadatak) 
			4. za više mogućnosti vidi [Gentoo wiki](https://wiki.gentoo.org/wiki/Comparison_of_init_systems)

### chsh
  - ==chsh== je za mijenjanje defaultnog shella nekog korisnika: `chsh -s <url-do-shella> [<korisnik>]` (da bi se moglo primijeniti shell mora biti unesen i u popis pouzdanih shellova u ==/etc/shells== datoteci i onda unesen sa korisnika kao njegov defaultni shell u ==/etc/passwd/== datoteku), a oznaka `-s` je tu da da uputu kako se mijenja "login shell"

### alias
	- `alias` je komanda za prenazivanje komandi ili grupiranje komandi s nizom oznaka u jednu novu (npr. `alias ll='ls -lahF'`). Kako bi imalo trajan učinak, `alias` naredbe se dodaju u ==.bashrc== datoteku ili na slično mjesto učitano pri boot-u
	  - `abbr` je specifična za ==fish== shell i služi kao `alias` ali koji ne skriva svoje stvarne naredbe u *history*-ju, već se niz komandi skrivenih unutar *kratice* raspišu same od sebe čim se doda razmak nakon kratice
   
### dpkg (+rpm) i make
  - `dpkg` je komanda za instaliranje ==.deb== paketa na računalo (a `rpm` za ==.rpm== paketa u Red Hat distribucijama)
	- `-i` je oznaka za instaliranje (`dpkg -i nekipaket.deb`) i ne instalira pakete o kojima dotični zavisi (*dependencies*)
	- `-r` je za odinstaliravanje (*remove*) (na Red Hat-u je `-e` (*erase*)), npr. (`dpkg -r nekipaket.deb` - što znači da treba čuvati originalne .deb pakete)
	- `-l` je oznaka za izlistavanje instaliranih paketa (`-qa` na Red Hat-u) - `dpkg -l`
  - **Ručna instalacija programa**
	- ==build-essential== je programski paket koji omogućava *ručno* instaliranje programa (preduvijet): `sudo apt install build-essential`
	- prvi korak je preuzeti paket u ==.tar.gz== arhivi i raskpakirati ga na računalu: `tar -xzvf [package].tar.gz`
	- drugi korak je pročitati README i/ili INSALL tekstualnu datoteku sa uputama: `less README`
		- najčešće se tamo nađe ==configure== skripta za provjeru zadovoljenosti uvijeta za instalaciju programa i instalaciju zavisnosti: `./configure` 
	- treći korak je instalacija programa (kada je prisutna MAKE datoteka): `sudo make install`
	- i to je to! Četvrti opcionalan korak je deinstalacija programa: `sudo make uninstall` (što znači da se mora čuvati originalan repozitorij po kojem je program instaliran)
	- ==!!!== koji put čak ni `uninstall` ne deinstalira sve što bi trebalo, stoga je naboji način za instalaciju upotrijebiti komandu Debianovu ugrađenu komandu `checkinstall` koja prema MAKE datoteci izgradi ==.deb== paket pa se sve može lako instalirati i deinstalirati (i po tome je potrebno sačuvati ==.deb== datoteku, a ne više cijeli repozitorij): `sudo checkinstall & sudo dpkg -i [paket].deb`

### apt, apt-get, nala, apk, brew, aur, dnf, yum, pacman, yay
	- `apt` i `apt-get` su defaultni *package manageri* u Debian distribucijama. (nisam siguran u čemu im je razlika) 
		- `install` je `apt`-ova oznaka za instaliranje paketa sa svim njegovim zavisnostima (samo treba dodati ime paketa koji se želi instalirati)
		- `remove` je oznaka za deinstaliranje paketa
		- `show` je komanda za ispisivanje informacija o određenom paketu
		- `search` je komanda za pretraživanje paketa u repozitoriju po nekoj kuljučnoj riječi (dobije se popis svih paketa relevantnih traženom izrazu)
		- `update` je komanda za dohvaćanje najnovije liste paketa u ==apt== repozitoriju
		- `upgrade` je komanda za ažuriranje nekog (ako se doda ime) ili svih paketa u sustavu (ako se ne naznače imena specifičnih paketa koje se želi ažurirati)
		- `nala` je *wrapper* oko `apt` PM-a, pisan u Python-u, koji stvar čini jednostavnijom i čitkijom
	- `yum` je *package manager* u Red Hat-ovim distribucijama
	- `pacman` je *package manager* u Arch Linux distribucijama
		- `yay` je *wrapper* oko `pacman` PM-a, pisan u Rust-u, koji stvar čini jednostavnijom i čitkijom
	- `apk` je *package manager* u Alpine Linux distribucijama
	- `brew` je *package manager* originalno napravljen za MacOs distribucije, ali za koji je izrađena i Linux distribucija

### ps, kill, top, (atop, htop, btop,) jobs, fg, bg, strace
	- `ps` je komanda za ispis aktivnih procesa
		- `a` je oznaka za ispis procesa svih korisnika
		- `u` je oznaka za ispis ...
		- `x` je oznaka za ispis ...
	- `kill` je komanda za gašanje procesa prema njegovom ID-u
	- `jobs` komanda je za ispis procesa koji se vrte u pozadini
	- `fg` je komanda za podizanje procesa po njegovom ID-u iz pozadine u prvi plan
	- `strace` je komanda za praćenje *syscall* poziva neke "korisničke" komande (poput svih onih nabrajanih u ovom dokumentu) - korisno možda pri *debug*-iranju programa (?)
	
### |, tee i <, >, >>, 1>, 2> 
  - `|` je komanda za proslijeđivanje iznosa (*stdout*) iz jedne komande u unos iduće (*stdin*); npr. `ls -lah / | less` će omogućiti lakši pregled iznosa `ls` komande
  - `tee` je komanda za slanje iznosa na više izlaznih lokacija; npr. `echo "Ovo je novi tekst" | tee tekst.txt backup.txt`  će ispisati tekst i na ekranu (kako predviđeno), ali ga i spremiti u datoteke *tekst.txt* i *backup.txt*
  - `<` je komanda za isčitavanje datoteke ili nekog iznosa komande i njegovu upotrebu kao unosa u drugu komandu; npr. `cat < file1 > file2` će iščitati sadržaj *file1* datoteke i upisati ga u *file2* datoteku. Još nisam siguran koja je poanta te komande jer se isto dogodi i bez `<`, ali eto postoji
  - `>` je komanda za promjenu lokacije iznosa iz neke komande (npr. u datoteku: `ls -lah / > root.txt`), tako se stvara nova datoteka ili se gazi sadržaj postojeće. Ako se iznos želi pridodati sadržaju postojeće datoteke, tada se može upotrijebiti komanda `>>`, no tu treba uzeti u obzir da postoje dva moguća iznosa: ==stdout== i ==stderr== ovisno o tome je li prethodna komanda uspješno izvršena
	- `1>` je komanda za proslijeđivanje *stdout* iznosa i istovjetna je `>` komandi
	- `2>` je komanda za proslijeđivanje *stderr* iznosa u slučaju da komanda nije proizvela *stdout*
	- `&>` je komanda za proslijeđivanje oba izlaza, bez obzira na to koji se ostvario

### /dev, /sys, udev, lsusb, lspci, lsscsi
	- `/dev` i `/sys` direktoriji su root direktoriji naminjeni za upravljanje uređajima (*devices*) na računalu, gdje je `/dev` stariji i izlistava sve uređaje (*drivere*) direktno, a `/sys` direktorij je prije namijenjen za upravljanje uređajima na jasniji i intuitivniji način - ==sysfs== je naziv tog sustava.
		- inače je način nazivanja uređaja standardan, npr. za harddiskove, tj. tzv. SCSI uređaje, se rabe imena `/dev/sda` za prvi harddisk, `/dev/sdb` je za drugi, `/dev/sda2` za treću particiju na prvom harddisku, itd.
	- ==udev== je sustav za automatsko upravljanje uređajima, njihovom uključivanju i isključivanju, te ažuriranju
		- ==udevd== je deamon koji u pozadini osluškuje upite o uređajima
		- `udevadm` je komanda za dobivanje informacija o uređajima, npr. `udevadm info --query=all --name=/dev/sda` će dohvatiti sve informacije o prvom harddisk uređaju na računalu
		- komande `lsusb`, `lspci` i `lsscsi` ispisuju sve *USB*, *PCI* i *block* (disk) uređaje na računalu

## Za urednika

### wc, cut, paste, join, split, tr, expand, unexpand 
  - `wc` je komanda za brojanje riječi u tekstu ili datoteci
  - `cut` je komanda za ispisivanje samo dijela svakog retka neke datoteke, npr. `cut -c 5 'neki tekst'` će ispisati prvih 5 slovnih znakova svakog retka, no prava snaga komande dolazi do izražaja pri baratanju sa .tsv ili .csv datotekama
	- `-c` je oznaka za ispis po broju znakova po retku
	- `-f` je oznaka za ispis vrijednosti u određenoj kolumni svakog retka
	  - `-d` je oznaka koja čini `-f` oznaku upotrebljivom, a služi za određivanje razdjelinika kolumni, npr. `cut -f 2 -d ";" file1.csv` će ispisati drugu kolumnu u .csv datoteci kojoj je zadani razdjelink znak ";"
    - ==!== sve vrijednosti za `-c` i `-f` se mogu davati kao broj, zatvoreni ili otvoreni raspon: `2` znači drugi, `2-4` znači od drugog do četvrtog (uključno), `-3` znači "do trećeg", a `2-` znači "od drugog"
  - `join` je za spajanje više datoteka u jedno (npr. `join file1.txt file2.txt`), ali mogu i znatno više sa .tsv ili .csv datotekama (npr. `join -1 2 -2 1 file1.txt file2.txt`) će uzeti prvo drugu kolumnju iz *file1.txt* i njoj pridodati prvu kolumnu iz *file2.txt*.
  - `paste` komanda omogućava spajanje redaka jednog ili više unosa (koji mogu biti tekstovne niske, pritoci ili datoteke). Po defaultu čita datoteke paralelno i spaja ih redak po redak, svaku u svoju kolumnu. 
	- `-s` je oznaka za *serial*, a znači da želimo čitati jednu po jednu datoteku i tako ih pripajati jednu za drugom (tako će se svi retci prve datoteke spojiti u prvi redak, svi retci druge u drugi, itd.)
	- `-d` je oznaka za određivanje razdjelnika pri spajanju
  - `split` razlama jedno datoteku u njih više, po defaultu po svakih 1000 redaka...
  - `tr` je komanda za "prevođenje", odnosno transformaciju teksta iz jednog obilka u drugi (npr. `tr a-z A-Z 'neki tekst'` će transformirati sva mala slova u velika) 
  - `expand` i `unexpand` su za ispisivanje datoteka, ali s time da se tabovi pretvore u četiri razmaka ili obrnuto

### tmux
  - ==tmux== je aplikacija koja treba posebnu instalaciju, ali je iznimno korisna za baratanje s terminalima i prozorima kada aplikacija terminala sama po sebi to ne rješava
    - prva komanda je uvijek `tmux new` (skraćeno za`new-session`) 
    - kada je sesija otvorena, rabe se tipkovničke komande. Prva je `<C-b>` jer je zadana kao defaultni okidač (prefiks) za sve tmux-ove komande
    - nakon toga treba zpamtiti barem `<C-?>` jer ona daje popis svih 68 dostupnih komandi (v. [github/tmux](https://github.com/tmux/tmux/wiki/Getting-Started))
    - ostale zgodne komande su:
      - `<C-b>"` ili `<C-b>%` za podjelu ekrana na područja
      - `<C-b>(←→↓↑)` za ulazak/izlazak iz određenog područja, a pored toga u istu svrhu su `<C-b>o` i `<C-b><M-o>` za ulazak u iduće/prethodno područje, ili pak <C-b>q za prikaz broja svakog područja te 
      - `<C-b>z` za zumiranje u i iz aktivnog  područja
      - `<C-b>x` za zatvaranje aktivnog područja
      - `<C-b><space>` ili `<C-b><C-o>` ili `<C-b><M-(1-5)>` za promjene rasporeda područja, a `<C-b><C-(←→↓↑)>` navodno za mijenjanje dimenzija podrčja (ali mi ne radi)
      - `<C-b>c` za stvaranje novog prozora (desktopa) i onda `<C-b>(0-9)` za biranje aktivnog prozora, a `<C-b>&` za zatvaranje prozora
