/** Napisz polecenie, które wyœwietla listê dzieci bêd¹cych
cz³onkami biblioteki. Interesuje nas imiê, nazwisko i data
urodzenia dziecka. */

use library
select member.firstname, member.lastname, juvenile.birth_date
from member
inner join
juvenile
on member.member_no = juvenile.member_no

/** Napisz polecenie, które podaje tytu³y aktualnie
wypo¿yczonych ksi¹¿ek */

select distinct title
from loan
inner join title
on loan.title_no = loan.title_no

/* Podaj informacje o karach zap³aconych za przetrzymywanie
ksi¹¿ki o tytule ‘Tao Teh King’. Interesuje nas data oddania
ksi¹¿ki, ile dni by³a przetrzymywana i jak¹ zap³acono karê */

select in_date, title, fine_paid, fine_assessed, datediff(d,in_date, due_date)
from loanhist
inner join title
on loanhist.title_no = title.title_no
where title like '%tao%' and due_date<in_date

/** Napisz polecenie które podaje listê ksi¹¿ek (numery ISBN)
zarezerwowanych przez osobê o nazwisku: Stephen A.
Graff */

select isbn 
from reservation
inner join member
on reservation.member_no = member.member_no
where lastname like 'graff' and firstname like 'stephen'

/*Wybierz nazwy i ceny produktów o cenie jednostkowej
pomiêdzy 20 a 30, dla ka¿dego produktu podaj dane
adresowe dostawcy */

use northwind
select ProductName, UnitPrice, Address
from Products
inner join Suppliers
on Products.SupplierID = Suppliers.SupplierID
where UnitPrice between 20 and 30

/*Wybierz nazwy i ceny produktów (baza northwind) o cenie
jednostkowej pomiêdzy 20 a 30, dla ka¿dego produktu
podaj dane adresowe dostawcy, interesuj¹ nas tylko
produkty z kategorii ‘Meat/Poultry’ */

use northwind
select ProductName, UnitPrice, Address, CategoryName
from Products
inner join Suppliers
on Products.SupplierID = Suppliers.SupplierID
inner join Categories
on Categories.CategoryID = Products.CategoryID
where UnitPrice between 20 and 30 and CategoryName like '%meat%'

/* Wybierz nazwy i ceny produktów z kategorii ‘Confections’
dla ka¿dego produktu podaj nazwê dostawcy. */

use northwind
select ProductName, UnitPrice, CompanyName
from Products
inner join Suppliers
on Products.SupplierID = Suppliers.SupplierID
inner join Categories
on Categories.CategoryID = Products.CategoryID
where CategoryName like '%confections%'

/* Wybierz nazwy i numery telefonów klientów , którym w
1997 roku przesy³ki dostarcza³a firma ‘United Package’ */

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

/*  Wybierz nazwy i numery telefonów klientów, którzy
kupowali produkty z kategorii ‘Confections’*/

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

/** Wybierz nazwy produktów oraz informacje o stanie
magazynu dla produktów dostarczanych przez firmê ‘Tokyo
Traders’ */

select Products.ProductName, UnitsInStock 
from Suppliers
inner join Products
on Suppliers.SupplierID = Products.SupplierID
where Suppliers.CompanyName like '%tokyo%'

/*  Czy s¹ jacyœ klienci którzy nie z³o¿yli ¿adnego zamówienia
w 1997 roku, jeœli tak to poka¿ ich dane adresowe */

select Address
from Customers
left outer join Orders
on Customers.CustomerID = Orders.CustomerID and YEAR(OrderDate) = 1997 
where OrderDate IS NULL


/** Wybierz nazwy i numery telefonów dostawców,
dostarczaj¹cych produkty, których aktualnie nie ma w
magazynie*/

select CompanyName, Phone
from Suppliers
inner join Products
on Suppliers.SupplierID = Products.SupplierID and UnitsInStock=0

/**Napisz polecenie, które wyœwietla listê dzieci bêd¹cych
cz³onkami biblioteki. Interesuje nas imiê, nazwisko, data
urodzenia dziecka, adres zamieszkania dziecka oraz imiê i
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

/** Napisz polecenie, które wyœwietla pracowników oraz ich
podw³adnych. */

use northwind
select pr.LastName, pod.LastName
from Employees as pr
left outer join Employees as pod
on pod.ReportsTo = pr.EmployeeID

/** Napisz polecenie, które wyœwietla pracowników, którzy nie
maj¹ podw³adnych. */

select pr.LastName, pod.LastName
from Employees as pr
left outer join Employees as pod
on pod.ReportsTo = pr.EmployeeID
where pod.LastName is NULL

/** Napisz polecenie, które wyœwietla adresy cz³onków
biblioteki, którzy maj¹ dzieci urodzone przed 1 stycznia
1996 */

use library
select distinct mem.lastname, mem.firstname, doro.street 
from member as mem
inner join juvenile as dzie
on dzie.adult_member_no = mem.member_no
inner join adult as doro
on doro.member_no = mem.member_no
where dzie.birth_date < '1996-01-01'

/** Napisz polecenie, które wyœwietla adresy cz³onków
biblioteki, którzy maj¹ dzieci urodzone przed 1 stycznia
1996. Interesuj¹ nas tylko adresy takich cz³onków biblioteki,
którzy aktualnie nie przetrzymuj¹ ksi¹¿ek.*/

select * 
from member as mem
inner join juvenile as dzie
on dzie.adult_member_no = mem.member_no
inner join adult as doro
on doro.member_no = mem.member_no
left outer join loan
on mem.member_no = loan.member_no
where loan.member_no is null and dzie.birth_date < '1996-01-01'

/**Napisz polecenie które zwraca imiê i nazwisko (jako
pojedyncz¹ kolumnê – name), oraz informacje o adresie:
ulica, miasto, stan kod (jako pojedyncz¹ kolumnê – address)
dla wszystkich doros³ych cz³onków biblioteki */

select member.firstname + member.lastname as 'name', adult.street + adult.state as 'adress'
from member
inner join adult
on adult.member_no = member.member_no

/**Napisz polecenie które zwraca informacjê o u¿ytkownikach
biblioteki o nr 250, 342, i 1675 (nr, imiê i nazwisko cz³onka
biblioteki) oraz informacje o zarezerwowanych ksi¹¿kach
(isbn, data)*/

select *
from member
left outer join reservation
on member.member_no = reservation.member_no
where member.member_no = 250  or member.member_no = 342 or member.member_no = 1675

/*  Podaj listê cz³onków biblioteki mieszkaj¹cych w Arizonie
(AZ), którzy maj¹ wiêcej ni¿ dwoje dzieci zapisanych do
biblioteki*/

select distinct COUNT(dzie.member_no)
from member as mem
left outer join juvenile as dzie
on dzie.adult_member_no = mem.member_no
left outer join adult as doro
on doro.member_no = mem.member_no and state like 'AZ'
group by mem.member_no
having COUNT(dzie.member_no)>2

/**Podaj listê cz³onków biblioteki mieszkaj¹cych w Arizonie
(AZ) którzy maj¹ wiêcej ni¿ dwoje dzieci zapisanych do
biblioteki oraz takich którzy mieszkaj¹ w Kaliforni i maj¹
wiêcej ni¿ troje dzieci zapisanych do biblioteki*/

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

/*1. Dla ka¿dej kategorii produktu (nazwa), podaj ³¹czn¹ liczbê
zamówionych przez klienta jednostek.*/

use northwind
select Categories.CategoryName, COUNT(*)
from categories
inner join Products
on Categories.CategoryID = Products.CategoryID
inner join [Order Details]
on [Order Details].ProductID = Products.ProductID
group by Categories.CategoryID, Categories.CategoryName


/**2. Dla ka¿dego zamówienia podaj ³¹czn¹ liczbê zamówionych jednostek
oraz nazwê klienta.**/

use northwind
select Customers.CompanyName, [Order Details].OrderID, SUM(quantity)
from [Order Details]
inner join Orders
on [Order Details].OrderID = Orders.OrderID
inner join Customers
on Customers.CustomerID = Orders.CustomerID
group by Customers.CompanyName, [Order Details].OrderID

/*3. Zmodyfikuj poprzedni przyk³ad, aby pokazaæ tylko takie zamówienia,
dla których ³¹czna liczba jednostek jest wiêksza ni¿ 250.*/

use northwind
select Customers.CompanyName, [Order Details].OrderID, SUM(quantity)
from [Order Details]
inner join Orders
on [Order Details].OrderID = Orders.OrderID
inner join Customers
on Customers.CustomerID = Orders.CustomerID
group by Customers.CompanyName, [Order Details].OrderID
having SUM(quantity)>250

/*4. Dla ka¿dego klienta (nazwa) podaj nazwy towarów, które zamówi³ */

select CompanyName, ProductName
from Customers
inner join Orders
on Customers.CustomerID = orders.CustomerID
inner join [Order Details] 
on Orders.OrderID = [Order Details].OrderID
inner join Products
on Products.ProductID = [Order Details].ProductID

/*5. Dla ka¿dego klienta (nazwa) podaj wartoœæ poszczególnych
zamówieñ. Gdy klient nic nie zamówi³ te¿ powinna pojawiæ siê
informacja. */

select CompanyName, SUM(Quantity*UnitPrice*(1-discount))
from Customers
inner join Orders
on Customers.CustomerID = orders.CustomerID
inner join [Order Details] 
on Orders.OrderID = [Order Details].OrderID
group by CompanyName

/*6. Podaj czytelników (imiê, nazwisko), którzy nigdy nie po¿yczyli ¿adnej
ksi¹¿ki.*/

use library
select distinct member.firstname + member.lastname, loan.isbn, loanhist.isbn
from member
left outer join loan
on member.member_no = loan.member_no 
left outer join loanhist
on member.member_no = loanhist.member_no
where loan.isbn is null and loanhist.isbn is null

/*88888888888888888888888888888888888888888888888888888888888888888888888888*/