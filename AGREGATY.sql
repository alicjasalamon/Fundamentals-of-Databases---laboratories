/**1. Podaj liczbê produktów o cenach mniejszych ni¿ 10$ lub
wiêkszych ni¿ 20$ */

select COUNT(*)
from Products
where UnitPrice between 10 and 20

/*2. Podaj maksymaln¹ cenê produktu dla produktów o cenach
poni¿ej 20$ */

select MAX(UnitPrice)
from Products
where UnitPrice < 20

/**3. Podaj maksymaln¹, minimaln¹ i œredni¹ cenê produktu dla
produktów sprzedawanych w butelkach (‘bottle’) */

select MAX(UnitPrice), AVG(UnitPrice), MIN(unitPrice)
from Products
where QuantityPerUnit like '%bottle%'

/**4. Wypisz informacjê o wszystkich produktach o cenie
powy¿ej œredniej */

select *
from Products
where UnitPrice > (select AVG(UnitPrice) from Products)

/**5. Podaj wartoœæ zamówienia o numerze 10252 */

select sum(UnitPrice* Quantity-(1- Discount))
from [Order Details] 
where OrderID=10252

/**1. Podaj maksymaln¹ cenê zamawianego produktu dla
ka¿dego zamówienia. Posortuj zamówienia wg
maksymalnej ceny produktu */

select OrderID, MAX(unitPrice)
from [Order Details]
group by OrderID
order by MAX(unitPrice)

/*2. Podaj maksymaln¹ i minimaln¹ cenê zamawianego
produktu dla ka¿dego zamówienia*/

select OrderID, MAX(unitPrice), MIN(UnitPrice)
from [Order Details]
group by OrderID
order by OrderID

/**3. Podaj liczbê zamówieñ dostarczanych przez
poszczególnych spedytorów*/

select count(*), ShipVia 
from Orders
group by ShipVia

/**4. Który ze spedytorów by³ najaktywniejszy w 1997 roku?*/

select top 1 count(*), ShipVia 
from Orders
group by ShipVia
order by count(*)

/*1. Wyœwietl zamówienia dla których liczba pozycji
zamówienia jest wiêksza ni¿ 5*/

select COUNT(*)
from [Order Details]
group by OrderID 
having COUNT(*) >5

/**2. Wyœwietl klientów, dla których w 1998 roku zrealizowano
wiêcej ni¿ 8 zamówieñ (wyniki posortuj malej¹co wg
³¹cznej kwoty za dostarczenie zamówieñ dla ka¿dego z
klientów) */

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

/*1. Napisz polecenie, które oblicza wartoœæ sprzeda¿y dla ka¿dego
zamówienia i wynik zwraca posortowany w malej¹cej kolejnoœci
(wg wartoœci sprzeda¿y).*/

select OrderID, SUM((Quantity* UnitPrice)*(1-Discount)) as 'cena'
from [Order Details]
group by OrderID
order by cena desc

/*2. Zmodyfikuj zapytanie z punktu 1., tak aby zwraca³o pierwszych 10
wierszy*/

select top 10 OrderID, SUM((Quantity* UnitPrice)*(1-Discount)) as 'cena'
from [Order Details]
group by OrderID
order by cena desc

/**3. Zmodyfikuj zapytanie z punktu 2., tak aby zwraca³o 10 pierwszych
produktów wliczaj¹c równorzêdne. Porównaj wyniki.*/

select top 10 with ties OrderID, SUM((Quantity* UnitPrice)*(1-Discount)) as 'cena'
from [Order Details]
group by OrderID
order by cena desc

/**1. Podaj liczbê zamówionych jednostek produktów dla produktów o
identyfikatorze < 3 */

select ProductID, COUNT(*)
from [Order Details]
group by ProductID
having productID<3

/*2. Zmodyfikuj zapytanie z punktu 1. tak aby podawa³o liczbê
zamówionych jednostek produktu dla wszystkich produktów*/

select ProductID, COUNT(*)
from [Order Details]
group by ProductID

/**3. Podaj wartoœæ zamówienia dla ka¿dego zamówienia, dla którego
³¹czna liczba zamawianych jednostek produktów jest > 250 */

select ProductID, COUNT(*), SUM((1-discount)*(quantity*Unitprice))
from [Order Details]
group by ProductID
having COUNT(*) >50

/**1. Napisz polecenie, które oblicza sumaryczn¹ iloœæ zamówionych
towarów i porz¹dkuje wg productid i orderid oraz wykonuje
kalkulacje rollup. */

select productID, orderid, COUNT(*)
from [Order Details]
group by ProductID, OrderID
with rollup
order by ProductID, OrderID

/*2. Zmodyfikuj zapytanie z punktu 1., tak aby ograniczyæ wynik tylko do
produktu o numerze 50.*/

select productID, orderid, COUNT(*)
from [Order Details]
group by ProductID, OrderID
with rollup
having ProductID=5
order by ProductID, OrderID

/*4. Zmodyfikuj polecenie z punktu 1. u¿ywaj¹c operator cube zamiast
rollup. U¿yj równie¿ funkcji GROUPING na kolumnach productid i
orderid do rozró¿nienia miêdzy sumarycznymi i szczegó³owymi
wierszami w zbiorze*/


select productID, GROUPING(productid), orderid, GROUPING(orderid), COUNT(*)
from [Order Details]
group by ProductID, OrderID
with cube
order by ProductID, OrderID