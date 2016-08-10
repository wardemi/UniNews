# 1. AZ ELSŐ LÉPÉSEK


###Kik vagyunk mi, avagy bemutatkoznak az előadók

- Honnan jöttünk?
- Mióta foglalkozunk iOS fejlesztéssel?
- Mely appokat készítettük mi?

###Kik vagytok ti, avagy bemutatkoznak a diákok

- Mit tanulsz?
- Mi a célod ezzel a tárggyal?
- Miért ezt a tárgyat választottad?


###Mi az oktatás célja?

- Gyakorlatias tudást akarunk átadni nektek, minimális elmélet lesz, sokat fogunk kódolni
- Úgy gyűjtöttük össze a témákat, hogy a mindennapi munkában előforduló technikákat vagy mondjuk egy interjún feljövő kérdések végig legyenek véve
- Gyakorlatias, mert a végén képesek lesztek alap appok összerakására

###Tematika

1. Alapozó első alkalom
2. Layout építés vizuálisan
3. Swift
4. Az architektúra kiválasztása
5. Navigáció, application lifecycle
6. Adatok előkészítése
7. Szálés hálózat kezelés
8. Hibakezelés
9. Multimédiás funkciók
10. Adatok feltöltése a szerverre
11. Több eszközre optimalizálás
12. Legjobb megoldások
13. Feltöltés az App Storeba
14. Utolsó alkalom

Az egész oktatás interaktív, bármikor lehet kérdezni, akármit, csak az a hülye kérdés, amit nem teszel fel, rágódsz rajta és elakadsz

###Sok kis apró példa lesz, de folyamatosan építünk egy nagyobb appot lépésről-lépésre

- Egyetemi Hírolvasó Alkalmazás
- Üzenetküldő fal, feltöltheti mi történt az egyetemen, előbb szöveggel, majd képpel
- Elérhető GitHub-on, az összes lépés külön commit, így jól végig lehet követni

###Lesz a végén számonkérés is, de nem szokványos...

- az utolsó alkalom során egy alkalmazást fogtok nekünk pár percben pitch szerűen bemutatni, ami lehet a nagy alkalmazás továbbfejlesztése, vagy bármi más is, amit Ti találtok ki
- természetesen a kódokat is meg fogjuk nézni

###Elérkeztünk a mostani alkalomhoz, a következőkről lesz szó:

- Mac gyorstalpaló
- XCode telepítés, beállítás és alapozó
- XCode plugin manager és pluginok
- Cocoapods alapok
- Account beállítása
- A nagy app storyboardjának összerakása PDF-ek és PNG-k alapján
- Tanuláshoz ajánló

Van olyan, aki nem tapasztalt a Mac használattal?

###Látom igen, semmi gond, ezért itt van néhány hasznos magyar nyelvű videó:

- https://vimeo.com/95758208
- https://vimeo.com/96569064
- https://vimeo.com/76763674
- https://vimeo.com/96055554
- https://vimeo.com/77548118
- https://vimeo.com/77059891
- https://vimeo.com/77044141

###A rendszer legfontosabb részeinek bemutatása

- Alap felépítés: az alkalmazás menü mindig fent van, Dock lent
- Dock: a tálca
- Spotlight: ezzel érdemes keresni, bitang gyors
- Finder: a helyi fájlkezelő
- Lunchpad: alkalmazások indítása innen
- Spaces: több asztal rugalmasan,
- Expose: ablakok áttekintése

###Fontos billentyűzet kombinációk

- Cmd+C / Cmd+V: Copy / paste
- Cmd+Tab: App váltás
- Alt+Tab: Ablak / tab váltás
- Cmd+W: Ablak / tab bezárása
- Cmd+Q: App bezárása
- Cmd+F: Kereső
- Cmd+Space: Finder
- F3: Expose
- F4: Lunchpad

###Fontos gesztusok

- Két ujjas tap a jobb klikk helyett
- Space váltás, négy ujj jobbra / balra
- Lunchpad, öt ujj összehúz
- Expose, négy ujj középről fel húz

###Térjünk át az XCode témára, de ehhez először ismerkedjünk meg az App Storeval

- Felül kategóriák
- Felül van az Update is
- Jobb felül pedig Search
- Keressünk rá az XCode-ra, egyelőre 7-es verzió
- Install, ez el fog tartani egy darabig
- Miután települt szükség lesz még a help telepítésére is, ez is eltart egy darabig
- Nektek már előre telepítve van

###XCode felépítésének bemutatása

- Első indítás, menü bemutatása
- Indítsunk új projketet, a feljövő képernyők elmagyarázása, statupolni egy alap projektet
- Végig megyünk mit tud az előttünk lévő képernyő
- A bal oldali navigációs menük bemutatása
- A jobb felső oldali inspector menük bemutatása
- A jobb alsó library menük bemutatása
- Az elsó debug menü bemutatása
- A középső rész bemutatása, kód, layout és konfiguráció editorok bemutatása
- App indítása
- Szimulátor bemutatása

###XCode plugin manager

- Egyelőre [alcatraz](http://alcatraz.io/), de rövidesen az XCode maga is tudni fogja
- XCode 7+!!!
- XCode Commandline Editor innen telepíthető: Preferences > Downloads
- Telepítés: curl -fsSL https://raw.github.com/alcatraz/Alcatraz/master/Scripts/install.sh | sh Restart
- Hogyan telepíthetek plugineket? Felső menü, Window / Package Manager. Innen lehet válogatni. Minden plugin telepítése után újra kell indítani az XCode-ot.

###CocoaPods alapozó

- Dependency manager Swift és ObjC projektekhez
- 3rd party libeket lehet vele nagyon könnyen behúzni
- Ezt az oldalt nézd: https://cocoapods.org
- Telepítés, terminálból: sudo gem install cocoapods
- Majd készítsd fel a projekted: https://guides.cocoapods.org/using/using-cocoapods.html
- Néhány lépés az egész, kell egy Podfile, azt megfelelően felépíteni, pod install, ha nem volt semmi hiba megnyitni a .xcworkspace filet, és már kész is vagy
- Figyelem, net kapcsolat nélkül ez nem fog menni

###A nagy app storyboardjának összerakása PDF-ek és PNG-k alapján

- Kicsit jobban megismerkedünk a storyboardok lelki világával

###Néhány anyag, amit érdemes forgatni (ingyenes, fizetős vegyesen):

- [designcode.io](https://designcode.io/)
- [raywenderlich.com](https://www.raywenderlich.com/)
- [iOS Programming: The Big Nerd Ranch Guide](https://www.amazon.com/iOS-Programming-Ranch-Guide-Guides/dp/0134390733/ref=sr_1_1?s=books&ie=UTF8&qid=1468314892&sr=1-1&keywords=ios+book)
- [Programming iOS 9: Dive Deep into Views, View Controllers, and Frameworks](https://www.amazon.com/Programming-iOS-Views-Controllers-Frameworks/dp/1491936851/ref=sr_1_2?s=books&ie=UTF8&qid=1468314892&sr=1-2&keywords=ios+book)



###Mi várható a következőben?
- TODO
