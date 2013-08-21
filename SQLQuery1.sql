/* */
select buyer_name, Sales.buyer_id
from Buyers, Sales
where Buyers.buyer_id = Sales.buyer_id

/* */
select buyer_name, s.buyer_id, qty
from Buyers as b, Sales as s
where b.buyer_id = s.buyer_id

/* */
select buyer_name as [b.buyer_name], 
s.buyer_id as [s.buyer_id],
b.buyer_id as [b.buyer_id],
qty as [s.qty]
from Buyers as b, Sales as s

/* */
select buyer_name as [b.buyer_name], 
s.buyer_id as [s.buyer_id],
b.buyer_id as [b.buyer_id],
qty as [s.qty]
from Buyers as b, Sales as s
where b.buyer_name = 'Adam Barr'

/* */
select 
b.buyer_name as [b.buyer_name], 
s.buyer_id as [s.buyer_id],
b.buyer_id as [b.buyer_id],
qty as [s.qty]
from Buyers as b, Sales as s
where s.buyer_id = b.buyer_id

/* */
select buyer_name, b.buyer_id, qty
from Buyers as b, Sales as s
where s.buyer_id = b.buyer_id

/* */
select buyer_name, sales.buyer_id, qty
from Buyers inner join Sales
on Buyers.buyer_id = Sales.buyer_id

/* tak aby produkty bez �dostarczycieli� i �dostarczyciele� bez
produkt�w nie pojawiali si� w wyniku.*/
select ProductName, CompanyName
from Products inner join Suppliers
on Products.SupplierID = Suppliers.SupplierID

/* Napisz polecenie zwracaj�ce jako wynik nazwy klient�w,
kt�rzy z�o�yli zam�wienia po 1 marca 1998*/
select distinct CompanyName, OrderDate
from orders inner join Customers
on Orders.CustomerID = Customers.CustomerID
WHERE orderdate > '3/1/98'

/* Z��czenie zewn�trzne � OUTER JOIN */
select buyer_name, Sales.buyer_id, qty
from Buyers left outer join Sales
on Buyers.buyer_id = Sales.buyer_id

/*polecenie zwracaj�ce wszystkich klient�w z datami
zam�wie�.*/
SELECT companyname, customers.customerid, orderdate
FROM customers
LEFT OUTER JOIN orders
ON customers.customerid = orders.customerid

/*Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych
cz�onkami biblioteki. Interesuje nas imi�, nazwisko i data
urodzenia dziecka. */
select firstname, lastname, birth_date
from juvenile inner join member
on juvenile.member_no = member.member_no

/*Napisz polecenie, kt�re podaje tytu�y aktualnie
wypo�yczonych ksi��ek */
select distinct title 
from loan inner join title
on loan.title_no = title.title_no

/*Podaj informacje o karach zap�aconych za przetrzymywanie
ksi��ki o tytule �Tao Teh King�. Interesuje nas data oddania
ksi��ki, ile dni by�a przetrzymywana i jak� zap�acono kar� */
select 
due_date as 'Kiedy powinien oddac',
in_date as 'Data oddania', 
DATEDIFF(DAY,due_date,in_date), 
fine_paid
from loanhist inner join title
on loanhist.title_no = title.title_no
where DATEDIFF(DAY,due_date,in_date) > 0
and title LIKE 'Tao Teh King'

/*Napisz polecenie kt�re podaje list� ksi��ek (numery ISBN)
zarezerwowanych przez osob� o nazwisku: Stephen A.
Graff */
select firstname, lastname, isbn
from member inner join reservation
on member.member_no = reservation.member_no
where lastname LIKE 'Graff' and firstname LIKE 'Stephen'

/*Wybierz nazwy i ceny produkt�w o cenie jednostkowej
pomi�dzy 20 a 30, dla ka�dego produktu podaj dane
adresowe dostawcy*/
select ProductName, UnitPrice, CompanyName, Address
from Suppliers inner join Products
on Suppliers.SupplierID = Products.SupplierID
where UnitPrice between 20 and 30

/*Wybierz nazwy produkt�w oraz informacje o stanie
magazynu dla produkt�w dostarczanych przez firm� �Tokyo
Traders� */
select ProductName, UnitsInStock, CompanyName
from Suppliers inner join Products
on Suppliers.SupplierID = Products.SupplierID
where CompanyName LIKE 'Tokyo Traders'

/*Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia
w 1997 roku, je�li tak to poka� ich dane adresowe */
select Address, OrderDate, Orders.CustomerID
from Orders RIGHT outer join Customers
on Customers.CustomerID = Orders.CustomerID and YEAR(OrderDate) = 1997
where OrderDate IS NULL

/*Wybierz nazwy i numery telefon�w dostawc�w,
dostarczaj�cych produkty, kt�rych aktualnie nie ma w
magazynie*/
select CompanyName, Phone
from Suppliers inner join Products
on Suppliers.SupplierID = Products.SupplierID and UnitsInStock = 0
/*********dlaczego unitsinstock w waruku on?************/


