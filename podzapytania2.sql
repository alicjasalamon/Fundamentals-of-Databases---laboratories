/**1.1
Wybierz nazwy i numery telefonów klientów , którym w 1997 
roku przesy³ki dostarcza³a firma United Package. **/

use northwind
select CompanyName, Phone							
from Customers as c
where exists (select * from Orders as o
				where c.CustomerID = o.CustomerID 
				and year(o.OrderDate) = 1997
				and exists (select * from Shippers as s
							where s.ShipperID = o.ShipVia
							and s.CompanyName like 'United Package')
				)

/**1.2
Wybierz nazwy i numery telefonów klientów, którzy kupowali 
produkty z kategorii Confections.. **/
use northwind
select CompanyName, Phone							
from Customers as c
where exists (select * from Orders as o
			 where c.CustomerID = o.CustomerID
			 and exists ( select * from [Order Details] as od
						where o.OrderID = od.OrderID
						and exists ( select * from Products AS p
									where exists (select * from Categories
													where CategoryName like 'Confections')
									)
						)
				)
				
/**1.3
Wybierz nazwy i numery telefonów klientów, którzy nie kupowali 
produkty z kategorii Confections.. **/
use northwind
select CompanyName, Phone							
from Customers as c
where not exists (select * from Orders as o
			 where c.CustomerID = o.CustomerID
			 and exists ( select * from [Order Details] as od
						where o.OrderID = od.OrderID
						and exists ( select * from Products AS p
									where exists (select * from Categories
													where CategoryName like 'Confections')
									)
						)
				)		 
			 
/**2.1
Dla ka¿dego produktu podaj maksymaln¹ liczbê zamówionych jednostek **/
use northwind
select distinct ProductID, Quantity
from [Order Details] as ord1
	where Quantity= (select MAX(quantity) 
				from [Order Details] as ord2
				where ord1.ProductID = ord2.ProductID)
order by Productid

/** 2.2
Podaj wszystkie produkty których cena jest mniejsza ni¿ œrednia cena produktu **/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products as p_wew 
		where p_zewn.CategoryID = p_wew.CategoryID ) as average
from Products as p_zewn
where UnitPrice > (select AVG(UnitPrice) from Products as p_wew 
				   where p_zewn.CategoryID = p_wew.CategoryID)

/**2.3
Podaj wszystkie produkty których cena jest mniejsza ni¿ œrednia 
cena produktu danej kategorii **/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products as p_wew 
		where p_zewn.CategoryID = p_wew.CategoryID ) as average
from Products as p_zewn
where UnitPrice < (select AVG(UnitPrice) from Products as p_wew 
				   where p_zewn.CategoryID = p_wew.CategoryID)
				   
/** 2.4
Dla ka¿dego produktu podaj jego nazwê, cenê, œredni¹ cenê wszystkich produktów 
oraz ró¿nicê miêdzy cen¹ produktu a œredni¹ cen¹ wszystkich produktów **/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products) as average,
		UnitPrice-(select AVG(UnitPrice) from Products)as difference
from Products

/** 2.5
Dla ka¿dego produktu podaj jego nazwê kategorii, nazwê produktu, cenê, 
œredni¹ cenê wszystkich produktów danej kategorii oraz ró¿nicê miêdzy cen¹ produktu 
a œredni¹ cen¹ wszystkich produktów danej kategorii **/

use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice), 
		(select Unitprice AVG(UnitPrice) from Products as p_wew 
				   where p_zewn.CategoryID = p_wew.CategoryID)
		from Products as p_wew 
		where p_zewn.CategoryID = p_wew.CategoryID ) as average
from Products as p_zewn 