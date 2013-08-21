/*1. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb� 
zam�wionych przez klienta jednostek.
tu przyj�am, �e chodzi o wszystkich klientow w ogolnosci*/
use northwind
select CategoryName, SUM(quantity) as 'ilosc wszystkich jednostek'
from [Order Details]
inner join Products
on Products.ProductID = [Order Details].ProductID
inner join Categories
on Categories.CategoryID = Products.CategoryID
group by CategoryName

/*2. Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek
oraz nazw� klienta.*/
use northwind
select [Order Details].OrderID, CompanyName, sum(Quantity) as 'ilosc zamowionych jednostek'
from [Order Details]
inner join Orders
on [Order Details].OrderID = Orders.OrderID
inner join Customers
on Customers.CustomerID = Orders.CustomerID
group by [Order Details].OrderID, CompanyName
order by [Order Details].OrderID

/*3. Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia,
dla kt�rych ��czna liczba jednostek jest wi�ksza ni� 250. */
use northwind
select [Order Details].OrderID, CompanyName, sum(Quantity) as 'ilosc zamowionych jednostek'
from [Order Details]
inner join Orders
on [Order Details].OrderID = Orders.OrderID
inner join Customers
on Customers.CustomerID = Orders.CustomerID
group by [Order Details].OrderID, CompanyName
having sum(Quantity)>250 

/*4. Dla ka�dego klienta (nazwa) podaj nazwy towar�w, kt�re zam�wi�*/
use northwind
select distinct CompanyName, ProductName
from Customers
inner join Orders
on Customers.CustomerID = Orders.CustomerID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
inner join Products
on [Order Details].ProductID = Products.ProductID
order by CompanyName

/*5. Dla ka�dego klienta (nazwa) podaj warto�� poszczeg�lnych
zam�wie�. Gdy klient nic nie zam�wi� te� powinna pojawi� si�
informacja.*/
use northwind
select  [Order Details].OrderID, CompanyName, SUM((UnitPrice*quantity)*(1-Discount)) as 'wartosc zamowienia'
from Customers
left outer join Orders
on Customers.CustomerID = Orders.CustomerID
left outer join [Order Details]
on [Order Details].OrderID = Orders.OrderID
group by CompanyName, [Order Details].OrderID
order by CompanyName

/*6. Podaj czytelnik�w (imi�, nazwisko), kt�rzy nigdy nie po�yczyli �adnej
ksi��ki.                                                                              ? */
use library
select member.firstname, member.lastname
from member
left outer join loan
on member.member_no = loan.member_no
group by member.firstname, member.lastname, isbn
having SUM(copy_no) is NULL
order by member.lastname

/*1. Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek
oraz nazw� klienta.*/
use northwind
select [Order Details].OrderID, CategoryName, SUM(quantity) as 'ilosc zamowionych jednostek'
from [Order Details]
inner join Products
on Products.ProductID = [Order Details].ProductID
inner join Categories
on Categories.CategoryID = Products.CategoryID
group by CategoryName, [Order Details].OrderID

/*2. Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia,
dla kt�rych ��czna liczb� zam�wionych jednostek jest wi�ksza ni�
250. */
use northwind
select [Order Details].OrderID, CategoryName, SUM(quantity) as 'ilosc zamowionych jednostek'
from [Order Details]
inner join Products
on Products.ProductID = [Order Details].ProductID
inner join Categories
on Categories.CategoryID = Products.CategoryID
group by CategoryName, [Order Details].OrderID
having sum(Quantity)>250 

/*3. Dla ka�dego zam�wienia podaj ��czn� warto�� tego zam�wienia oraz
nazw� klienta.*/
use northwind
select [Order Details].OrderID, SUM([Order Details].unitprice*quantity*(1-discount)), CompanyName
from Customers
inner join Orders
on Customers.CustomerID = Orders.CustomerID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
inner join Products
on [Order Details].ProductID = Products.ProductID
group by [Order Details].OrderID, CompanyName

/*4. Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia,
dla kt�rych ��czna liczba jednostek jest wi�ksza ni� 250. */
use northwind
select [Order Details].OrderID, SUM([Order Details].unitprice*quantity*(1-discount)), CompanyName
from Customers
inner join Orders
on Customers.CustomerID = Orders.CustomerID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
inner join Products
on [Order Details].ProductID = Products.ProductID
group by [Order Details].OrderID, CompanyName
having sum(Quantity)>250 

/*5. Zmodyfikuj poprzedni przyk�ad tak �eby doda� jeszcze imi� i
nazwisko pracownika obs�uguj�cego zam�wienie */
use northwind
select [Order Details].OrderID, SUM([Order Details].unitprice*quantity*(1-discount)) as 'wartosc zamowienia', 
CompanyName, FirstName, LastName
from Customers
inner join Orders
on Customers.CustomerID = Orders.CustomerID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
inner join Products
on [Order Details].ProductID = Products.ProductID
inner join Employees
on Employees.EmployeeID = Orders.EmployeeID
group by [Order Details].OrderID, CompanyName, FirstName, LastName

/*1. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb�
zam�wionych przez klient�w jednostek towar�w. */
use northwind
select CategoryName, SUM(quantity) 
from [Order Details]
inner join Products
on Products.ProductID = [Order Details].ProductID
inner join Categories
on Categories.CategoryID = Products.CategoryID
group by CategoryName

/*2. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� warto��
zam�wie� */
use northwind
select CategoryName, SUM([Order Details].unitprice*quantity*(1-discount))
from [Order Details]
inner join Products
on Products.ProductID = [Order Details].ProductID
inner join Categories
on Categories.CategoryID = Products.CategoryID
group by CategoryName

/* 3. Posortuj wyniki w zapytaniu z punktu 2 wg:
a) ��cznej warto�ci zam�wie� */
use northwind
select CategoryName, SUM([Order Details].unitprice*quantity*(1-discount))
from [Order Details]
inner join Products
on Products.ProductID = [Order Details].ProductID
inner join Categories
on Categories.CategoryID = Products.CategoryID
group by CategoryName
order by SUM([Order Details].unitprice*quantity*(1-discount)) desc

/* 3. Posortuj wyniki w zapytaniu z punktu 2 wg:
b) ��cznej liczby zam�wionych przez klient�w jednostek towar�w. */
use northwind
select CategoryName, SUM([Order Details].unitprice*quantity*(1-discount)), SUM(quantity) as 'ilosc'
from [Order Details]
inner join Products
on Products.ProductID = [Order Details].ProductID
inner join Categories
on Categories.CategoryID = Products.CategoryID
group by CategoryName
order by SUM(quantity) 

/* 1. Dla ka�dego przewo�nika (nazwa) podaj liczb� zam�wie� kt�re
przewie�li w 1997r */
use northwind
select shippers.CompanyName, COUNT(OrderID)
from Shippers
left outer join Orders
on Shippers.ShipperID = Orders.ShipVia and YEAR(shippedDate)=1997
group by shippers.CompanyName

/*2. Kt�ry z przewo�nik�w by� najaktywniejszy (przewi�z� najwi�ksz�
liczb� zam�wie�) w 1997r, podaj nazw� tego przewo�nika */
use northwind
select top 1 shippers.CompanyName, COUNT(OrderID)
from Shippers
left outer join Orders
on Shippers.ShipperID = Orders.ShipVia and YEAR(shippedDate)=1997
group by shippers.CompanyName
order by COUNT(OrderID) desc

/*3. Kt�ry z pracownik�w obs�u�y� najwi�ksz� liczb� zam�wie� w 1997r,
podaj imi� i nazwisko takiego pracownika */
use northwind
select top 1 Employees.LastName, Employees.FirstName, COUNT(OrderID)
from Employees
inner join Orders
on Employees.EmployeeID = Orders.EmployeeID
group by Employees.LastName, Employees.FirstName
order by COUNT(OrderID)desc

/*1. Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto��
zam�wie� obs�u�onych przez tego pracownika */
use northwind
select Employees.LastName, Employees.FirstName, SUM(UnitPrice*Quantity*(1-discount)) as'wartosc zamowien'
from Employees
left outer join Orders
on Employees.EmployeeID = Orders.EmployeeID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
group by Employees.LastName, Employees.FirstName

/*2. Kt�ry z pracownik�w obs�u�y� najaktywniejszy (obs�u�y� zam�wienia
o najwi�kszej warto�ci) w 1997r, podaj imi� i nazwisko takiego
pracownika */
use northwind
select top 1 Employees.LastName, Employees.FirstName, SUM(UnitPrice*Quantity*(1-discount)) as'wartosc zamowien'
from Employees
left outer join Orders
on Employees.EmployeeID = Orders.EmployeeID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
group by Employees.LastName, Employees.FirstName
order by SUM(UnitPrice*Quantity*(1-discount)) desc

/*3. Ogranicz wynik z pkt 1 tylko do pracownik�w
a) kt�rzy maj� podw�adnych */
use northwind
select szef.FirstName, szef.LastName,SUM(UnitPrice*Quantity*(1-discount)) as'wartosc zamowien' 
from Employees as podwladny
right outer join Employees as szef
on  podwladny.ReportsTo = szef.EmployeeID
left outer join Orders
on szef.EmployeeID = Orders.EmployeeID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
where podwladny.LastName is not NULL
group by szef.FirstName, szef.LastName

/*3. Ogranicz wynik z pkt 1 tylko do pracownik�w
b) kt�rzy nie maj� podw�adnych */
use northwind
select szef.FirstName, szef.LastName,SUM(UnitPrice*Quantity*(1-discount)) as'wartosc zamowien' 
from Employees as podwladny
right outer join Employees as szef
on  podwladny.ReportsTo = szef.EmployeeID
left outer join Orders
on szef.EmployeeID = Orders.EmployeeID
inner join [Order Details]
on [Order Details].OrderID = Orders.OrderID
where podwladny.LastName is NULL
group by szef.FirstName, szef.LastName