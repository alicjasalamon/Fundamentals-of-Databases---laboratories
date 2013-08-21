/**1. Podaj liczb� produkt�w o cenach mniejszych ni� 10$ lub
wi�kszych ni� 20$ */

select COUNT(*)
from Products
where UnitPrice between 10 and 20

/*2. Podaj maksymaln� cen� produktu dla produkt�w o cenach
poni�ej 20$ */

select MAX(UnitPrice)
from Products
where UnitPrice < 20

/**3. Podaj maksymaln�, minimaln� i �redni� cen� produktu dla
produkt�w sprzedawanych w butelkach (�bottle�) */

select MAX(UnitPrice), AVG(UnitPrice), MIN(unitPrice)
from Products
where QuantityPerUnit like '%bottle%'

/**4. Wypisz informacj� o wszystkich produktach o cenie
powy�ej �redniej */

select *
from Products
where UnitPrice > (select AVG(UnitPrice) from Products)

/**5. Podaj warto�� zam�wienia o numerze 10252 */

select sum(UnitPrice* Quantity-(1- Discount))
from [Order Details] 
where OrderID=10252

/**1. Podaj maksymaln� cen� zamawianego produktu dla
ka�dego zam�wienia. Posortuj zam�wienia wg
maksymalnej ceny produktu */

select OrderID, MAX(unitPrice)
from [Order Details]
group by OrderID
order by MAX(unitPrice)

/*2. Podaj maksymaln� i minimaln� cen� zamawianego
produktu dla ka�dego zam�wienia*/

select OrderID, MAX(unitPrice), MIN(UnitPrice)
from [Order Details]
group by OrderID
order by OrderID

/**3. Podaj liczb� zam�wie� dostarczanych przez
poszczeg�lnych spedytor�w*/

select count(*), ShipVia 
from Orders
group by ShipVia

/**4. Kt�ry ze spedytor�w by� najaktywniejszy w 1997 roku?*/

select top 1 count(*), ShipVia 
from Orders
group by ShipVia
order by count(*)

/*1. Wy�wietl zam�wienia dla kt�rych liczba pozycji
zam�wienia jest wi�ksza ni� 5*/

select COUNT(*)
from [Order Details]
group by OrderID 
having COUNT(*) >5

/**2. Wy�wietl klient�w, dla kt�rych w 1998 roku zrealizowano
wi�cej ni� 8 zam�wie� (wyniki posortuj malej�co wg
��cznej kwoty za dostarczenie zam�wie� dla ka�dego z
klient�w) */

select CustomerId, COUNT(*), SUM(freight)
from Orders
group by CustomerID
having COUNT(*)>8
order by SUM(Freight) desc

/**/
USE northwind
SELECT orderid, productid, SUM(quantity) AS total_quantity
FROM [order details]
WHERE orderid < 10250
GROUP BY orderid, productid
with rollup
ORDER BY orderid, productid

/**/
USE northwind
SELECT orderid, productid, SUM(quantity) AS total_quantity
FROM [order details]
WHERE orderid < 10250
GROUP BY orderid, productid
with cube
ORDER BY orderid, productid


/**/
USE northwind
SELECT productid, orderid,quantity
FROM orderhist
ORDER BY productid, orderid
COMPUTE SUM(quantity)

USE northwind
SELECT productid, orderid, quantity
FROM orderhist
ORDER BY productid, orderid
COMPUTE SUM(quantity) BY productid
COMPUTE SUM(quantity)

/*1. Napisz polecenie, kt�re oblicza warto�� sprzeda�y dla ka�dego
zam�wienia i wynik zwraca posortowany w malej�cej kolejno�ci
(wg warto�ci sprzeda�y).*/

select OrderID, SUM((Quantity* UnitPrice)*(1-Discount)) as 'cena'
from [Order Details]
group by OrderID
order by cena desc

/*2. Zmodyfikuj zapytanie z punktu 1., tak aby zwraca�o pierwszych 10
wierszy*/

select top 10 OrderID, SUM((Quantity* UnitPrice)*(1-Discount)) as 'cena'
from [Order Details]
group by OrderID
order by cena desc

/**3. Zmodyfikuj zapytanie z punktu 2., tak aby zwraca�o 10 pierwszych
produkt�w wliczaj�c r�wnorz�dne. Por�wnaj wyniki.*/

select top 10 with ties OrderID, SUM((Quantity* UnitPrice)*(1-Discount)) as 'cena'
from [Order Details]
group by OrderID
order by cena desc

/**1. Podaj liczb� zam�wionych jednostek produkt�w dla produkt�w o
identyfikatorze < 3 */

select ProductID, COUNT(*)
from [Order Details]
group by ProductID
having productID<3

/*2. Zmodyfikuj zapytanie z punktu 1. tak aby podawa�o liczb�
zam�wionych jednostek produktu dla wszystkich produkt�w*/

select ProductID, COUNT(*)
from [Order Details]
group by ProductID

/**3. Podaj warto�� zam�wienia dla ka�dego zam�wienia, dla kt�rego
��czna liczba zamawianych jednostek produkt�w jest > 250 */

select ProductID, COUNT(*), SUM((1-discount)*(quantity*Unitprice))
from [Order Details]
group by ProductID
having COUNT(*) >50

/**1. Napisz polecenie, kt�re oblicza sumaryczn� ilo�� zam�wionych
towar�w i porz�dkuje wg productid i orderid oraz wykonuje
kalkulacje rollup. */

select productID, orderid, COUNT(*)
from [Order Details]
group by ProductID, OrderID
with rollup
order by ProductID, OrderID

/*2. Zmodyfikuj zapytanie z punktu 1., tak aby ograniczy� wynik tylko do
produktu o numerze 50.*/

select productID, orderid, COUNT(*)
from [Order Details]
group by ProductID, OrderID
with rollup
having ProductID=5
order by ProductID, OrderID

/*4. Zmodyfikuj polecenie z punktu 1. u�ywaj�c operator cube zamiast
rollup. U�yj r�wnie� funkcji GROUPING na kolumnach productid i
orderid do rozr�nienia mi�dzy sumarycznymi i szczeg�owymi
wierszami w zbiorze*/


select productID, GROUPING(productid), orderid, GROUPING(orderid), COUNT(*)
from [Order Details]
group by ProductID, OrderID
with cube
order by ProductID, OrderID