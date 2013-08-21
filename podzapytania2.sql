/**1.1
Wybierz nazwy i numery telefon�w klient�w , kt�rym w 1997 
roku przesy�ki dostarcza�a firma United Package. **/

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
Wybierz nazwy i numery telefon�w klient�w, kt�rzy kupowali 
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
Wybierz nazwy i numery telefon�w klient�w, kt�rzy nie kupowali 
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
Dla ka�dego produktu podaj maksymaln� liczb� zam�wionych jednostek **/
use northwind
select distinct ProductID, Quantity
from [Order Details] as ord1
	where Quantity= (select MAX(quantity) 
				from [Order Details] as ord2
				where ord1.ProductID = ord2.ProductID)
order by Productid

/** 2.2
Podaj wszystkie produkty kt�rych cena jest mniejsza ni� �rednia cena produktu **/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products as p_wew 
		where p_zewn.CategoryID = p_wew.CategoryID ) as average
from Products as p_zewn
where UnitPrice > (select AVG(UnitPrice) from Products as p_wew 
				   where p_zewn.CategoryID = p_wew.CategoryID)

/**2.3
Podaj wszystkie produkty kt�rych cena jest mniejsza ni� �rednia 
cena produktu danej kategorii **/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products as p_wew 
		where p_zewn.CategoryID = p_wew.CategoryID ) as average
from Products as p_zewn
where UnitPrice < (select AVG(UnitPrice) from Products as p_wew 
				   where p_zewn.CategoryID = p_wew.CategoryID)
				   
/** 2.4
Dla ka�dego produktu podaj jego nazw�, cen�, �redni� cen� wszystkich produkt�w 
oraz r�nic� mi�dzy cen� produktu a �redni� cen� wszystkich produkt�w **/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products) as average,
		UnitPrice-(select AVG(UnitPrice) from Products)as difference
from Products

/** 2.5
Dla ka�dego produktu podaj jego nazw� kategorii, nazw� produktu, cen�, 
�redni� cen� wszystkich produkt�w danej kategorii oraz r�nic� mi�dzy cen� produktu 
a �redni� cen� wszystkich produkt�w danej kategorii **/

use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice), 
		(select Unitprice AVG(UnitPrice) from Products as p_wew 
				   where p_zewn.CategoryID = p_wew.CategoryID)
		from Products as p_wew 
		where p_zewn.CategoryID = p_wew.CategoryID ) as average
from Products as p_zewn 