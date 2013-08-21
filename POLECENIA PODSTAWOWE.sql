/*Znajdz numer zamówienia oraz identyfikator
klienta dla zamówien z data wczesniejsza
niB 1 sierpien 1996 */
use northwind
select OrderID, CustomerID
from Orders
where OrderDate < '1996-08-01'

/**
1. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby w Londynie */

select CompanyName, Address
from Customers
where City like 'London'

/**
2. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby we Francji lub w
Hiszpanii */

select CompanyName, Address
from Customers
where Country like 'France' or Country like 'Spain'

/**
3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20 a 30 */

select ProductName, UnitPrice
from Products
where UnitPrice between 20 and 30

/**
4. Wybierz nazwy i ceny produktów z kategorii ‘meat’ */

select ProductName, UnitPrice
from Products
where CategoryID =(select CategoryID 
		from Categories
		where CategoryName like '%meat%'
		)

/**
5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów
dostarczanych przez firmê ‘Tokyo Traders’ */

select ProductName, UnitsInStock
from Products
where SupplierID=(select SupplierID
					from Suppliers
					where CompanyName like '%tokyo%')

/**6. Wybierz nazwy produktów których nie ma w magazynie */

select ProductName 
from Products
where UnitsInStock =0

/**
1. Szukamy informacji o produktach sprzedawanych w
butelkach (‘bottle’) */

select *
from Products
where QuantityPerUnit like '%bottle%'

/**
2. Wyszukaj informacje o stanowisku pracowników, których
nazwiska zaczynaj¹ siê na literê z zakresu od B do L */

select *
from Employees
where LastName like '[b-l]%'

/** 
3. Wyszukaj informacje o stanowisku pracowników, których
nazwiska zaczynaj¹ siê na literê B lub L */

select *
from Employees
where LastName like '[bl]%'

/** 
4. ZnajdŸ nazwy kategorii, które w opisie zawieraj¹ przecinek */

select CategoryName
from Categories
where Description like '%,%'

/**
5. ZnajdŸ klientów, którzy w swojej nazwie maj¹ w którymœ
miejscu s³owo ‘Store’ */

select CompanyName
from Customers
where CompanyName like '%Store%'

/**Wybierz nazwy i kraje wszystkich klientów maj¹cych
siedziby w Japonii (Japan) lub we W³oszech (Italy) */

select * 
from Customers
where Country like 'italy' or Country like 'japan'

/**1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj
wed³ug kraju, w ramach danego kraju nazwy firm posortuj
alfabetycznie */

select Country, CompanyName
from Customers
order by Country, CompanyName

/**2. Wybierz informacjê o produktach (grupa, nazwa, cena),
produkty posortuj wg grup a w grupach malej¹co wg ceny */

select CategoryID, UnitPrice 
from Products
order by CategoryID, UnitPrice desc

/**3. Wybierz nazwy i kraje wszystkich klientów maj¹cych
siedziby w Wielkiej Brytanii (UK) lub we W³oszech (Italy),
wyniki posortuj tak jak w pkt 1 */

select Country, CompanyName
from Customers
where Country like 'UK' or Country like 'italy'
order by Country, CompanyName

/**3. Napisz polecenie, które wybiera numer czytelnika i karê
dla tych czytelników, którzy maj¹ kary miêdzy $8 a $9 */

use library
select member_no, fine_assessed
from Loanhist
where fine_assessed between 8 and 9

/**4. Napisz polecenie select, za pomoc¹ którego uzyskasz
numer ksi¹¿ki i autora dla wszystkich ksi¹¿ek, których
autorem jest Charles Dickens lub Jane Austen*/

use library
select title_no, title, author
from title
where author like '%Dickens%' or author like '%Austen%' 

/**6. Napisz polecenie, które wybiera numer czytelnika, karê
oraz zap³acon¹ karê dla wszystkich, którzy jeszcze nie
zap³acili. */

select member_no, fine_assessed, fine_paid, fine_waived 
from loanhist
where isnull(fine_assessed,0)-isnull(fine_paid,0)-isnull(fine_waived,0)>0

/**2. Napisz polecenie, które:
 wybiera numer cz³onka biblioteki, isbn ksi¹¿ki i wartoœæ
naliczonej kary dla wszystkich wypo¿yczeñ, dla których
naliczono karê
 stwórz kolumnê wyliczeniow¹ zawieraj¹c¹ podwojon¹ wartoœæ
kolumny fine_assessed
 stwórz alias ‘double fine’ dla tej kolumny */

use library
select distinct member_no, isbn, fine_assessed, fine_assessed*2 as 'double_fine'
from loanhist
where fine_assessed>0

/**3. Napisz polecenie, które
 generuje pojedyncz¹ kolumnê, która zawiera kolumny: imiê
cz³onka biblioteki, inicja³ drugiego imienia i nazwisko dla
wszystkich cz³onków biblioteki, którzy nazywaj¹ siê Anderson
 nazwij tak powsta³¹ kolumnê „email_name”
 zmodyfikuj polecenie, tak by zwróci³o „listê proponowanych
loginów e-mail” utworzonych przez po³¹czenie imienia cz³onka
biblioteki, z inicja³em drugiego imienia i pierwszymi dwoma
literami nazwiska (wszystko ma³ymi literami).
 wykorzystaj funkcjê SUBSTRING do uzyskania czêœci kolumny
znakowej oraz LOWER do zwrócenia wyniku ma³ymi literami
 wykorzystaj operator (+) do po³¹czenia stringów. **/

select lower(firstname + middleinitial + SUBSTRING(lastname, 0, 2) ) as 'email'
from member
where lastname like 'anderson'

/**
4. Napisz polecenie, które wybiera title i title_no z tablicy
title.
 Wynikiem powinna byæ pojedyncza kolumna o formacie jak w
przyk³adzie poni¿ej:
The title is: Poems, title number 7
 Czyli zapytanie powinno zwracaæ pojedyncz¹ kolumnê w oparciu
o wyra¿enie, które ³¹czy 4 elementy:
sta³a znakowa ‘The title is:’
wartoœæ kolumny title
sta³a znakowa ‘title number’
wartoœæ kolumny title_no */

select 'the tile: ' + title + ', numer ' + CONVERT(varchar, title_no)
from title

