/** Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych
cz�onkami biblioteki. Interesuje nas imi�, nazwisko i data
urodzenia dziecka. */

use library
select member.firstname, member.lastname, juvenile.birth_date
from member
inner join
juvenile
on member.member_no = juvenile.member_no

/** Napisz polecenie, kt�re podaje tytu�y aktualnie
wypo�yczonych ksi��ek */

select distinct title
from loan
inner join title
on loan.title_no = loan.title_no

/* Podaj informacje o karach zap�aconych za przetrzymywanie
ksi��ki o tytule �Tao Teh King�. Interesuje nas data oddania
ksi��ki, ile dni by�a przetrzymywana i jak� zap�acono kar� */

select in_date, title, fine_paid, fine_assessed, datediff(d,in_date, due_date)
from loanhist
inner join title
on loanhist.title_no = title.title_no
where title like '%tao%' and due_date<in_date

/** Napisz polecenie kt�re podaje list� ksi��ek (numery ISBN)
zarezerwowanych przez osob� o nazwisku: Stephen A.
Graff */

select isbn 
from reservation
inner join member
on reservation.member_no = member.member_no
where lastname like 'graff' and firstname like 'stephen'

/*Wybierz nazwy i ceny produkt�w o cenie jednostkowej
pomi�dzy 20 a 30, dla ka�dego produktu podaj dane
adresowe dostawcy */

use northwind
select ProductName, UnitPrice, Address
from Products
inner join Suppliers
on Products.SupplierID = Suppliers.SupplierID
where UnitPrice between 20 and 30

/*Wybierz nazwy i ceny produkt�w (baza northwind) o cenie
jednostkowej pomi�dzy 20 a 30, dla ka�dego produktu
podaj dane adresowe dostawcy, interesuj� nas tylko
produkty z kategorii �Meat/Poultry� */

use northwind
select ProductName, UnitPrice, Address, CategoryName
from Products
inner join Suppliers
on Products.SupplierID = Suppliers.SupplierID
inner join Categories
on Categories.CategoryID = Products.CategoryID
where UnitPrice between 20 and 30 and CategoryName like '%meat%'

/* Wybierz nazwy i ceny produkt�w z kategorii �Confections�
dla ka�dego produktu podaj nazw� dostawcy. */

use northwind
select ProductName, UnitPrice, CompanyName
from Products
inner join Suppliers
on Products.SupplierID = Suppliers.SupplierID
inner join Categories
on Categories.CategoryID = Products.CategoryID
where CategoryName like '%confections%'

/* Wybierz nazwy i numery telefon�w klient�w , kt�rym w
1997 roku przesy�ki dostarcza�a firma �United Package� */

select Customers.CompanyName, Customers.Phone, Suppliers.CompanyName, Orders.OrderDate
from Customers
inner join Orders
on Customers.CustomerID = Orders.CustomerID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
inner join Products
on Products.ProductID = [Order Details].ProductID
inner join Suppliers
on Suppliers.SupplierID = Products.SupplierID
where YEAR(Orders.OrderDate)=1997

/*  Wybierz nazwy i numery telefon�w klient�w, kt�rzy
kupowali produkty z kategorii �Confections�*/

select Customers.CompanyName, Customers.Phone, Categories.CategoryName
from Customers
inner join Orders
on Customers.CustomerID = Orders.CustomerID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
inner join Products
on Products.ProductID = [Order Details].ProductID
inner join Categories
on Categories.CategoryID= Products.CategoryID
where Categories.CategoryName like '%confections%'

/** Wybierz nazwy produkt�w oraz informacje o stanie
magazynu dla produkt�w dostarczanych przez firm� �Tokyo
Traders� */

select Products.ProductName, UnitsInStock 
from Suppliers
inner join Products
on Suppliers.SupplierID = Products.SupplierID
where Suppliers.CompanyName like '%tokyo%'

/*  Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia
w 1997 roku, je�li tak to poka� ich dane adresowe */

select Address
from Customers
left outer join Orders
on Customers.CustomerID = Orders.CustomerID and YEAR(OrderDate) = 1997 
where OrderDate IS NULL


/** Wybierz nazwy i numery telefon�w dostawc�w,
dostarczaj�cych produkty, kt�rych aktualnie nie ma w
magazynie*/

select CompanyName, Phone
from Suppliers
inner join Products
on Suppliers.SupplierID = Products.SupplierID and UnitsInStock=0

/**Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych
cz�onkami biblioteki. Interesuje nas imi�, nazwisko, data
urodzenia dziecka, adres zamieszkania dziecka oraz imi� i
nazwisko rodzica.*/

use library
select m1.firstname, m1.lastname, juvenile.birth_date,adult.street, m2.firstname, m2.lastname 
from juvenile
inner join member as m1
on m1.member_no = juvenile.member_no
inner join member as m2
on juvenile.adult_member_no = m2.member_no
inner join adult
on adult.member_no = m2.member_no

/** Napisz polecenie, kt�re wy�wietla pracownik�w oraz ich
podw�adnych. */

use northwind
select pr.LastName, pod.LastName
from Employees as pr
left outer join Employees as pod
on pod.ReportsTo = pr.EmployeeID

/** Napisz polecenie, kt�re wy�wietla pracownik�w, kt�rzy nie
maj� podw�adnych. */

select pr.LastName, pod.LastName
from Employees as pr
left outer join Employees as pod
on pod.ReportsTo = pr.EmployeeID
where pod.LastName is NULL

/** Napisz polecenie, kt�re wy�wietla adresy cz�onk�w
biblioteki, kt�rzy maj� dzieci urodzone przed 1 stycznia
1996 */

use library
select distinct mem.lastname, mem.firstname, doro.street 
from member as mem
inner join juvenile as dzie
on dzie.adult_member_no = mem.member_no
inner join adult as doro
on doro.member_no = mem.member_no
where dzie.birth_date < '1996-01-01'

/** Napisz polecenie, kt�re wy�wietla adresy cz�onk�w
biblioteki, kt�rzy maj� dzieci urodzone przed 1 stycznia
1996. Interesuj� nas tylko adresy takich cz�onk�w biblioteki,
kt�rzy aktualnie nie przetrzymuj� ksi��ek.*/

select * 
from member as mem
inner join juvenile as dzie
on dzie.adult_member_no = mem.member_no
inner join adult as doro
on doro.member_no = mem.member_no
left outer join loan
on mem.member_no = loan.member_no
where loan.member_no is null and dzie.birth_date < '1996-01-01'

/**Napisz polecenie kt�re zwraca imi� i nazwisko (jako
pojedyncz� kolumn� � name), oraz informacje o adresie:
ulica, miasto, stan kod (jako pojedyncz� kolumn� � address)
dla wszystkich doros�ych cz�onk�w biblioteki */

select member.firstname + member.lastname as 'name', adult.street + adult.state as 'adress'
from member
inner join adult
on adult.member_no = member.member_no

/**Napisz polecenie kt�re zwraca informacj� o u�ytkownikach
biblioteki o nr 250, 342, i 1675 (nr, imi� i nazwisko cz�onka
biblioteki) oraz informacje o zarezerwowanych ksi��kach
(isbn, data)*/

select *
from member
left outer join reservation
on member.member_no = reservation.member_no
where member.member_no = 250  or member.member_no = 342 or member.member_no = 1675

/*  Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie
(AZ), kt�rzy maj� wi�cej ni� dwoje dzieci zapisanych do
biblioteki*/

select distinct COUNT(dzie.member_no)
from member as mem
left outer join juvenile as dzie
on dzie.adult_member_no = mem.member_no
left outer join adult as doro
on doro.member_no = mem.member_no and state like 'AZ'
group by mem.member_no
having COUNT(dzie.member_no)>2

/**Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie
(AZ) kt�rzy maj� wi�cej ni� dwoje dzieci zapisanych do
biblioteki oraz takich kt�rzy mieszkaj� w Kaliforni i maj�
wi�cej ni� troje dzieci zapisanych do biblioteki*/

select distinct mem.member_no
from member as mem
left outer join juvenile as dzie
on dzie.adult_member_no = mem.member_no
left outer join adult as doro
on doro.member_no = mem.member_no and state like 'AZ'
group by mem.member_no
having COUNT(dzie.member_no)>2
union
select distinct mem.member_no
from member as mem
left outer join juvenile as dzie
on dzie.adult_member_no = mem.member_no
left outer join adult as doro
on doro.member_no = mem.member_no and state like 'CA'
group by mem.member_no
having COUNT(dzie.member_no)>3

/*1. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb�
zam�wionych przez klienta jednostek.*/

use northwind
select Categories.CategoryName, COUNT(*)
from categories
inner join Products
on Categories.CategoryID = Products.CategoryID
inner join [Order Details]
on [Order Details].ProductID = Products.ProductID
group by Categories.CategoryID, Categories.CategoryName


/**2. Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek
oraz nazw� klienta.**/

use northwind
select Customers.CompanyName, [Order Details].OrderID, SUM(quantity)
from [Order Details]
inner join Orders
on [Order Details].OrderID = Orders.OrderID
inner join Customers
on Customers.CustomerID = Orders.CustomerID
group by Customers.CompanyName, [Order Details].OrderID

/*3. Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia,
dla kt�rych ��czna liczba jednostek jest wi�ksza ni� 250.*/

use northwind
select Customers.CompanyName, [Order Details].OrderID, SUM(quantity)
from [Order Details]
inner join Orders
on [Order Details].OrderID = Orders.OrderID
inner join Customers
on Customers.CustomerID = Orders.CustomerID
group by Customers.CompanyName, [Order Details].OrderID
having SUM(quantity)>250

/*4. Dla ka�dego klienta (nazwa) podaj nazwy towar�w, kt�re zam�wi� */

select CompanyName, ProductName
from Customers
inner join Orders
on Customers.CustomerID = orders.CustomerID
inner join [Order Details] 
on Orders.OrderID = [Order Details].OrderID
inner join Products
on Products.ProductID = [Order Details].ProductID

/*5. Dla ka�dego klienta (nazwa) podaj warto�� poszczeg�lnych
zam�wie�. Gdy klient nic nie zam�wi� te� powinna pojawi� si�
informacja. */

select CompanyName, SUM(Quantity*UnitPrice*(1-discount))
from Customers
inner join Orders
on Customers.CustomerID = orders.CustomerID
inner join [Order Details] 
on Orders.OrderID = [Order Details].OrderID
group by CompanyName

/*6. Podaj czytelnik�w (imi�, nazwisko), kt�rzy nigdy nie po�yczyli �adnej
ksi��ki.*/

use library
select distinct member.firstname + member.lastname, loan.isbn, loanhist.isbn
from member
left outer join loan
on member.member_no = loan.member_no 
left outer join loanhist
on member.member_no = loanhist.member_no
where loan.isbn is null and loanhist.isbn is null

/*88888888888888888888888888888888888888888888888888888888888888888888888888*/