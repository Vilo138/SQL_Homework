
2.  Naplňte tabuľku údajmi:
        id=1, nazov=Plenárna prednáška
        id=2, nazov=Prednáška
        id=3, nazov=Poster
    
    Populate the table with data:
        id=1, name=Plenary Lecture
        id=2, name=Lecture
        id=3, name=Poster

INSERT INTO psa1_prezentacia (id, nazov)
VALUES (1, 'Plenárna prednáška'),
       (2, 'Prednáška'),
       (3, 'Poster');


3. Vypíšte všetky údaje o užívateľoch zoradených podľa abecedy (A > Z) (t.j. podľa priezviska a mena)
    Write all user data sorted alphabetically (A > Z) (i.e. by last name and first name)

select * from psa1_osoba order by priezvisko, meno;

4. Vypíšte zoznam užívateľov, ktorí pochádzajú zo Slovenska (Slovak Republic)
    Write a list of users who come from Slovakia (Slovak Republic)

select *  from psa1_osoba where stat = 'Slovak Republic' ;

5. Vypíšte počet užívateľov z Česka (Czech Republic) ako pocet_CR
    Write the number of users from the Czech Republic as pocet_CR

select count(*) as pocet_CR from psa1_osoba where stat = 'Czech Republic';

6. Vypíšte počet užívateľov z jednotlivých štátov
    Write the number of users from individual states

select count(*) as pocet_uzivatelov, stat from psa1_osoba group by stat;

7. Vypíšte meno a priezvisko posledne zaregistrovaného účastníka z Česka (Czech Republic)
    Write the first and last name of the last registered participant from the Czech Republic

select meno, priezvisko
from psa1_osoba
join psa1_registracia on psa1_osoba.id = psa1_registracia.osoba
where psa1_osoba.stat = 'Czech Republic'
order by psa1_registracia.datum_platby desc
limit 1;

8. Vypíšte zoznam krajín, z ktorých pochádzajú užívatelia
    Write a list of countries from which users come

select distinct stat as staty from psa1_osoba order by stat;

9. Vypíšte zoznam krajín, z ktorých pochádzajú aspoň 10 užívatelia
    Write a list of countries from which at least 10 users come

select stat from psa1_osoba group by stat having count(*) >= 10;

10.Vypíšte najčastejšie používané meno medzi účastníkmi
    Write the most commonly used name among participants

select meno from psa1_osoba group by meno order by count(*) desc limit 1;

11. Vypíšte názov článku, meno a priezvisko autora
    Write the title of the article, the first name and last name of the author

select psa1_clanok.nazov, psa1_osoba.meno, psa1_osoba.priezvisko
from psa1_clanok
join psa1_osoba on psa1_clanok.autor = psa1_osoba.id;

12. Vypíšte názov článku, priezvisko autora, názov sekcie a názov prezentácie zoradený podľa sekcie (abecedne A > Z) a následne podľa id prezentácie (v poradí 3 – 2 – 1)
    Write the title of the article, the authors last name, the section name, and the presentation name sorted by section (alphabetically A > Z) and then by presentation id (in order 3 - 2 - 1)

select psa1_clanok.nazov as nazov_clanku, psa1_osoba.priezvisko as priezvisko_autora, psa1_prezentacia.nazov as nazov_prezentacie, psa1_sekcia.nazov as nazov_sekcie from psa1_clanok
join psa1_osoba on psa1_clanok.autor = psa1_osoba.id
join psa1_prezentacia on psa1_clanok.prezentacia = psa1_prezentacia.id 
join psa1_sekcia on psa1_clanok.sekcia = psa1_sekcia.id
order by psa1_clanok.sekcia, psa1_prezentacia.id desc;

13. Vypíšte zoznam názvov prezentácií a k nim príslušné množstvo článkov
    Write a list of presentation names and the corresponding number of articles

select psa1_prezentacia.nazov as nazov_prezentacie, count(psa1_clanok.prezentacia) as mnozstvo_clankov
from psa1_clanok
join psa1_prezentacia on psa1_clanok.prezentacia = psa1_prezentacia.id
group by psa1_prezentacia.nazov;

14. Vypíšte zoznam názvov sekcií a k nim príslušné množstvo článkov
    Write a list of section names and the corresponding number of articles

select psa1_sekcia.nazov as nazov_sekcie, count(psa1_clanok.sekcia) as pocet_sekcii
from psa1_clanok
join psa1_sekcia on psa1_clanok.sekcia = psa1_sekcia.id
group by psa1_sekcia.nazov;

15. Vypíšte zoznam účastníkov, t.j. meno, priezvisko, registrácia a dátum platby. Dátum platby v tvare deň.mesiac.rok.
    Write a list of participants, i.e. name, surname, registration, and payment date. Payment date in the form day.month.year

select psa1_osoba.meno, psa1_osoba.priezvisko, psa1_registracia.registracia, DATE_FORMAT(psa1_registracia.datum_platby, '%d.%m.%Y') as datum_platby
from psa1_osoba
join psa1_registracia on psa1_osoba.id = psa1_registracia.osoba

16. Vypíšte koľkí účastníci majú zvolené vegetariánske jedlo
    Write how many participants have chosen vegetarian food

select count(psa1_registracia.vegetarian) as pocet_vegetarianov
from psa1_registracia
where psa1_registracia.vegetarian = 1
group by psa1_registracia.vegetarian;

17. Vypíšte koľkí účastníci majú zvolený autobus tam aj späť
    Write how many participants have chosen a bus there and back

select count(*) as pocet_autobus_tam_spat
from psa1_registracia
where psa1_registracia.autobus_tam = 1 and psa1_registracia.autobus_spat = 1;

18. Vypíšte meno a priezvisko účastníkov, ktorí sa prihlásili na workshop1
    Write the name and surname of the participants who signed up for workshop1

select psa1_osoba.meno, psa1_osoba.priezvisko
from psa1_osoba
join psa1_registracia on psa1_osoba.id = psa1_registracia.osoba
where psa1_registracia.workshop1 = 1;

19. Vypíšte meno a priezvisko účastníka, dátum jeho platby, názov článku, názov sekcie a názov prezentácie
    Write the name and surname of the participant, the date of his payment, the title of the article, the title of the section, and the title of the presentation

select psa1_osoba.meno, psa1_osoba.priezvisko, psa1_registracia.datum_platby, psa1_clanok.nazov as nazov_clanku, psa1_prezentacia.nazov as nazov_prezentacie, psa1_sekcia.nazov as nazov_sekcie
from psa1_osoba
join psa1_registracia on psa1_osoba.id = psa1_registracia.osoba
join psa1_clanok on psa1_osoba.id = psa1_clanok.autor
join psa1_prezentacia on psa1_clanok.prezentacia = psa1_prezentacia.id
join psa1_sekcia on psa1_clanok.sekcia = psa1_sekcia.id;

20. Vypíšte zoznam článkov, kde autor nezaplatil za registráciu (datum_platby je 0000-00-00)
    Write a list of articles where the author did not pay for registration (payment date is 0000-00-00)
    
select psa1_clanok.nazov as nazov_clanku
from psa1_clanok
join psa1_osoba on psa1_clanok.autor = psa1_osoba.id
join psa1_registracia on psa1_osoba.id = psa1_registracia.osoba
where psa1_registracia.datum_platby = '0000-00-00'

