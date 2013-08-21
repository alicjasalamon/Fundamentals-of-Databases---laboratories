/*Znajdz numer zam�wienia oraz identyfikator
klienta dla zam�wien z data wczesniejsza
niB 1 sierpien 1996 */
use northwind
select OrderID, CustomerID
from Orders
where OrderDate < '1996-08-01'

/**
1. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby w Londynie */

select CompanyName, Address
from Customers
where City like 'London'

/**
2. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby we Francji lub w
Hiszpanii */

select CompanyName, Address
from Customers
where Country like 'France' or Country like 'Spain'

/**
3. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20 a 30 */

select ProductName, UnitPrice
from Products
where UnitPrice between 20 and 30

/**
4. Wybierz nazwy i ceny produkt�w z kategorii �meat� */

select ProductName, UnitPrice
from Products
where CategoryID =(select CategoryID 
		from Categories
		where CategoryName like '%meat%'
		)

/**
5. Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w
dostarczanych przez firm� �Tokyo Traders� */

select ProductName, UnitsInStock
from Products
where SupplierID=(select SupplierID
					from Suppliers
					where CompanyName like '%tokyo%')

/**6. Wybierz nazwy produkt�w kt�rych nie ma w magazynie */

select ProductName 
from Products
where UnitsInStock =0

/**
1. Szukamy informacji o produktach sprzedawanych w
butelkach (�bottle�) */

select *
from Products
where QuantityPerUnit like '%bottle%'

/**
2. Wyszukaj informacje o stanowisku pracownik�w, kt�rych
nazwiska zaczynaj� si� na liter� z zakresu od B do L */

select *
from Employees
where LastName like '[b-l]%'

/** 
3. Wyszukaj informacje o stanowisku pracownik�w, kt�rych
nazwiska zaczynaj� si� na liter� B lub L */

select *
from Employees
where LastName like '[bl]%'

/** 
4. Znajd� nazwy kategorii, kt�re w opisie zawieraj� przecinek */

select CategoryName
from Categories
where Description like '%,%'

/**
5. Znajd� klient�w, kt�rzy w swojej nazwie maj� w kt�rym�
miejscu s�owo �Store� */

select CompanyName
from Customers
where CompanyName like '%Store%'

/**Wybierz nazwy i kraje wszystkich klient�w maj�cych
siedziby w Japonii (Japan) lub we W�oszech (Italy) */

select * 
from Customers
where Country like 'italy' or Country like 'japan'

/**1. Wybierz nazwy i kraje wszystkich klient�w, wyniki posortuj
wed�ug kraju, w ramach danego kraju nazwy firm posortuj
alfabetycznie */

select Country, CompanyName
from Customers
order by Country, CompanyName

/**2. Wybierz informacj� o produktach (grupa, nazwa, cena),
produkty posortuj wg grup a w grupach malej�co wg ceny */

select CategoryID, UnitPrice 
from Products
order by CategoryID, UnitPrice desc

/**3. Wybierz nazwy i kraje wszystkich klient�w maj�cych
siedziby w Wielkiej Brytanii (UK) lub we W�oszech (Italy),
wyniki posortuj tak jak w pkt 1 */

select Country, CompanyName
from Customers
where Country like 'UK' or Country like 'italy'
order by Country, CompanyName

/**3. Napisz polecenie, kt�re wybiera numer czytelnika i kar�
dla tych czytelnik�w, kt�rzy maj� kary mi�dzy $8 a $9 */

use library
select member_no, fine_assessed
from Loanhist
where fine_assessed between 8 and 9

/**4. Napisz polecenie select, za pomoc� kt�rego uzyskasz
numer ksi��ki i autora dla wszystkich ksi��ek, kt�rych
autorem jest Charles Dickens lub Jane Austen*/

use library
select title_no, title, author
from title
where author like '%Dickens%' or author like '%Austen%' 

/**6. Napisz polecenie, kt�re wybiera numer czytelnika, kar�
oraz zap�acon� kar� dla wszystkich, kt�rzy jeszcze nie
zap�acili. */

select member_no, fine_assessed, fine_paid, fine_waived 
from loanhist
where isnull(fine_assessed,0)-isnull(fine_paid,0)-isnull(fine_waived,0)>0

/**2. Napisz polecenie, kt�re:
 wybiera numer cz�onka biblioteki, isbn ksi��ki i warto��
naliczonej kary dla wszystkich wypo�ycze�, dla kt�rych
naliczono kar�
 stw�rz kolumn� wyliczeniow� zawieraj�c� podwojon� warto��
kolumny fine_assessed
 stw�rz alias �double fine� dla tej kolumny */

use library
select distinct member_no, isbn, fine_assessed, fine_assessed*2 as 'double_fine'
from loanhist
where fine_assessed>0

/**3. Napisz polecenie, kt�re
 generuje pojedyncz� kolumn�, kt�ra zawiera kolumny: imi�
cz�onka biblioteki, inicja� drugiego imienia i nazwisko dla
wszystkich cz�onk�w biblioteki, kt�rzy nazywaj� si� Anderson
 nazwij tak powsta�� kolumn� �email_name�
 zmodyfikuj polecenie, tak by zwr�ci�o �list� proponowanych
login�w e-mail� utworzonych przez po��czenie imienia cz�onka
biblioteki, z inicja�em drugiego imienia i pierwszymi dwoma
literami nazwiska (wszystko ma�ymi literami).
 wykorzystaj funkcj� SUBSTRING do uzyskania cz�ci kolumny
znakowej oraz LOWER do zwr�cenia wyniku ma�ymi literami
 wykorzystaj operator (+) do po��czenia string�w. **/

select lower(firstname + middleinitial + SUBSTRING(lastname, 0, 2) ) as 'email'
from member
where lastname like 'anderson'

/**
4. Napisz polecenie, kt�re wybiera title i title_no z tablicy
title.
 Wynikiem powinna by� pojedyncza kolumna o formacie jak w
przyk�adzie poni�ej:
The title is: Poems, title number 7
 Czyli zapytanie powinno zwraca� pojedyncz� kolumn� w oparciu
o wyra�enie, kt�re ��czy 4 elementy:
sta�a znakowa �The title is:�
warto�� kolumny title
sta�a znakowa �title number�
warto�� kolumny title_no */

select 'the tile: ' + title + ', numer ' + CONVERT(varchar, title_no)
from title

