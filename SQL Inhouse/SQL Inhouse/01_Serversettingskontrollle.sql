/*
Im setup 

HDD
Datenträgervolumwartungstask  (Dienste)

------------------------------------------
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
------------------------------------------

einem guten Admin ist das rel egal
weil dieser die Startgröße der DB deutlch größer setzt

Beim Restore allerdings wäre das auch schön.. :-)

Lok Sicherheitsrichtlinie -- Zuweisen von Benutzerrechten




Pfade für Tlog + Datendateien
TRenne Daten von den Logfiles pro DB 
physikalisch

#DB Pfade
----------------------
IST: c:\Program Files.... NULL Gedanken wg HDD.. Doch gterade hier kann man viel Performance gewinnen
WENN: D:\SQLDB
      D:\SQLDB ..bei einer HDD ..ok

WENN  D:\SQLDB
      E:\LOG ..wenn 2 HDDs dann ok.. ansonsten kein Mehrwert (bspw wg Partitionen)

Wenn man die Pfade ändert.. Neustart... 

Nach Neustart sind alle Messwerte weg, und wir wissen nicht mehr warum etwas langsam war..



SAN
IOPS SQLIO
Perfmon-- physik Datenträger --> durchschnittliche Wartenschlangenlänge




Arbeitsspeicher
MIN Ram Garantie dafür gilt erst ab belegt
MAX Ram  hier max Wert setzen (Gesamt - OS)

Perfmon-- SQLServer_memmory manager: freier Speicher MB




#RAM
----------------
8GB

MIN : 0
MAX : 2,1 PB.  kann sich holen was er will--> und gibts nicht mehr her

es sollte eine MAX Grenze angegeben werden, damit das OS weiter sauber arbeiten

aber das OS braucht auch was...(es existieren einige Formeln, Gefühlt zw 4 bis 10GB)

Faustregel: mind 4
---         10%  (1 TB)  100GB.. neee... bei viel nix gut
--         1-4GB= 1GB  4 bis 16GB pro 4 GB 1 GB  danach alle 16GB 1 GB
256GB=     1GB      12/4=3GB    240/16 + 15     ca 19GB   20

im Setup bei 12 GB 8800


Gesamt RAM minus OS


Min RAM: 0 (auch im Setup verbleibt die 0), jeder andere Wert muss erst erreicht werden, damit der fix gilt.
Also zunächst keine Auswirkung, wenn der Wert hher gesetzt wird.

aber bei Konkurrenz: 2te Instanz.. Idee einer bleibt bei 0 und der anderer Wichtigere bekommt min Wert
Tipp: Max Arbeitssatz im TaskManager (was war der Peakwert des SQL Servers seit Start)

Interess: 8,7GB MAX Arbeitssatz und akt. 6,1GB  entweder Absicht oder RAM Mangel


TaskManager: 1 Socket 8 CPUS

Achtung VM
Hardwaretopologie nachbilden
Affit. kann man gut so lassen wie sie sind: Autom


CPU
MAXDOP
Anzahl der Kerne max pro Abfrage
wobei: entweder wird  1 Kern verwendet oder MAXDOP Wert
Maxdop Wert = Anzahl der Kerne aber nicht mehr als 8
Kostenschwellenwert

Anzahl der CPUs die pro Abfrage max verwendet werden können
Normalerweise sind mehr CPU günstiger/schneller

Grundsätzlich kostet eine Abfrage mit 1 CPU weniger CPU Kosten  , als mit mehr CPUs


Früher vor 2019:
CPU: 0 .. alle Cpu machen mit. und zwar immer alle
Allerdings erst dann , wenn PlanKosten über 5 liegen


Faustregel: bei NICHT OLAP 25, bei OLTP 50
Anzahl CPU sollte = Anzahl der Kerne, aber max 8



TempDB
#t ##t
Zeilenversionierung
Indexwartung
Cursor
Auslagerungen






auch in TempDB eig HDDs und aufteilen der Daten  und Logdatei
auf verschied HDDs
so viele Datendateien wie Kerne (max 8)


-T1117 alle Dateien sollen imer gleich groß sein
--das klappt nur, wenn die DAteien autom. wachsen
--T1118 Blöcke sind UNIFORM.. also kein MIX von mehreren Tabellen
--Vermeidung von Latches







*/