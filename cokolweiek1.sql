/**1. Wybierz nazwy i numery telefon�w klient�w, kt�rzy nie kupili 
�adnego produktu z kategorii �Confections�. Rozwi�za� u�ywaj�c mechanizmu podzapyta�. */

select c.CompanyName, c.Phone
from Customers as c
where NOT exists( select * from Orders as o
			where o.CustomerID = c.customerID
			and exists(select * from [Order Details] as od
						where od.OrderID = o.OrderID
						and exists(select * from Products as p
									where p.ProductID = od.ProductID
									and exists(select * from Categories as ca
												where ca.CategoryID = p.CategoryID
												and ca.CategoryName like '%confections%' 
											        ) 
									)
						)
				)

/*2. Dla ka�dego produktu podaj jego nazw� kategorii, nazw� produktu, cen�, 
�redni� cen� wszystkich produkt�w danej kategorii oraz r�nic� mi�dzy cen� 
produktu a �redni� cen� wszystkich produkt�w danej kategorii. */


select p1.ProductName, (select c.CategoryName from Categories as c
						where p1.CategoryID = c.CategoryID),
						p1.UnitPrice,
						(select AVG(UnitPrice) from Products as p2
						where p1.CategoryID = p2.CategoryID),
						p1.UnitPrice - (select AVG(UnitPrice) from Products as p2
						where p1.CategoryID = p2.CategoryID)
from Products as p1
order by (select c.CategoryName from Categories as c
		 where p1.CategoryID = c.CategoryID)
						
/*3. Dla ka�dego pracownika wypisz ilo�� zam�wie�, jakie obs�u�y� w 1997 roku,
 podaj tak�e dat� ostatniego obs�ugiwanego przez niego zam�wienia (w 1997 r.). 
Interesuj� nas pracownicy, kt�rzy obs�u�yli wi�cej ni� sze�� zam�wie�.*/

select e.LastName, COUNT(*), MAX(o.OrderDate) 
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID and YEAR(o.OrderDate)=1997
group by e.EmployeeID, e.LastName
having COUNT(*)>6


/*4. Wypisz kwoty nale�ne przewo�nikom z podzia�em na lata.*/

select s.ShipperID, YEAR(o.OrderDate), SUM(o.Freight)
from Shippers as s
inner join Orders as o
on s.ShipperID = o.ShipVia
group by s.ShipperID, YEAR(o.OrderDate)
with rollup
having s.ShipperID is not null

/**laczna wartosc zamowienia z freight, bez podzapytan) */

select o.OrderID, o.Freight+ SUM(Quantity*UnitPrice*(1-Discount))
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by o.OrderID, o.Freight

/*dla kazdego pracownika liczba zamowien, z rozbiciem */

select e.LastName, YEAR(o.OrderDate), DATEPART(Q, o.OrderDate), MONTH(o.OrderDate), COUNT(*) 
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
group by e.EmployeeID, e.LastName, YEAR(o.OrderDate), DATEPART(Q, o.OrderDate), MONTH(o.OrderDate)
with rollup
having e.LastName is not null

/*wszystkie zamowienia freight > sredni freight w tym roku ,  2 sposoby*/

select distinct o1.OrderID, o1.Freight ,(select AVG(o2.Freight )from Orders as o2
								where YEAR(o2.OrderDate)=YEAR(o1.OrderDate)
								), o1.OrderDate
from Orders as o1
where o1.Freight >(select AVG(o2.Freight )from Orders as o2
								where YEAR(o2.OrderDate)=YEAR(o1.OrderDate)
								)
								

select distinct o1.OrderID, o1.Freight, AVG(o2.Freight)
from Orders as o1
inner join Orders as o2
on YEAR(o1.OrderDate)=year(o2.OrderDate)
group by o1.OrderID, o1.Freight
having o1.Freight > AVG(o2.Freight)

/* klienci nie kupowali w 1997 
2 sposoby*/

select c.CompanyName 
from Customers as c
where not exists (select * from Orders as o
					where c.CustomerID = o.CustomerID
					and YEAR(o.OrderDate)=1997
				)

select c.CompanyName, o.OrderDate
from Customers as c
left outer join Orders as o
on c.CustomerID = o.CustomerID and YEAR(o.OrderDate)=1997
where o.OrderDate is null