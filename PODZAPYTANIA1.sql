/*1.Wybierz nazwy i numery telefon�w klient�w , 
kt�rym w 1997 roku przesy�ki dostarcza�a firma United Package.*/
	select distinct Customers.CompanyName, Customers.Phone, Suppliers.CompanyName
	from Customers
	inner join Orders
	on Customers.CustomerID = Orders.CustomerID
	inner join [Order Details]
	on Orders.OrderID = [Order Details].OrderID
	inner join Products
	on Products.ProductID = [Order Details].ProductID
	inner join Suppliers
	on Suppliers.SupplierID = Products.SupplierID
	where Suppliers.CompanyName like 'tokyo%' and YEAR(Orders.OrderDate)=1997
	order by Customers.CompanyName
	
	select CompanyName, Phone
	from Customers as c
	where exists ( select * from Orders as o
					where o.CustomerID = c.CustomerID
					and YEAR(o.OrderDate)=1997
					and exists(select * from [Order Details] as od
								where od.OrderID = o.OrderID
								and exists (select * from Products as p
											where p.ProductID = od.ProductID
											and exists (select * from Suppliers as s
														where s.SupplierID = p.SupplierID
														and s.CompanyName like 'tokyo%'
														)
										)
								)
					)
	order by c.CompanyName
	
	/*////////////////////////////////////////////////////////////// */
	
	select c.CompanyName, c.Phone
	from Customers as c
	inner join Orders as o
	on c.CustomerID = o.CustomerID
	inner join Shippers as s
	on s.ShipperID = o.ShipVia
	where year(o.OrderDate)=1997
	and s.CompanyName like '%united%'
	
	select distinct c.CompanyName, c.Phone
	from Customers as c
	inner join Orders as o
	on c.CustomerID = o.CustomerID and yeAR(o.OrderDate)=1997
	inner join Shippers as s
	on s.ShipperID = o.ShipVia
	and s.CompanyName like '%united%'
	
	select c.CompanyName, c.Phone
	from Customers as c
	where exists (select * from Orders as o
					where o.CustomerID = c.CustomerID
					and year(o.OrderDate)=1997
					and exists(select * from Shippers as s
								where s.ShipperID = o.ShipVia
								and s.CompanyName like '%united%'
								)
					)

/*2.Wybierz nazwy i numery telefon�w klient�w, 
kt�rzy kupowali produkty z kategorii Confections..*/

	select distinct Customers.CompanyName, Customers.Phone
	from Customers
	inner join Orders
	on Customers.CustomerID = Orders.CustomerID
	inner join [Order Details]
	on Orders.OrderID = [Order Details].OrderID
	inner join Products
	on Products.ProductID = [Order Details].ProductID
	inner join Categories
	on Categories.CategoryID = Products.CategoryID
	where Categories.CategoryName like '%confections%'
	
	select CompanyName, Phone
	from Customers as c
	where exists ( select * from Orders as o
					where o.CustomerID = c.CustomerID
					and YEAR(o.OrderDate)=1997
					and exists(select * from [Order Details] as od
								where od.OrderID = o.OrderID
								and exists (select * from Products as p
											where p.ProductID = od.ProductID
											and exists(select * from Categories as ca
														where ca.CategoryID = p.CategoryID
														and ca.CategoryName like '%confections%'
														)
											)
								)
					)
											
/*3.Wybierz nazwy i numery telefon�w klient�w, 
kt�rzy nie kupowali produkt�w z kategorii Confections.*/


	select distinct Customers.CompanyName, Customers.Phone
	from Customers
	inner join Orders
	on Customers.CustomerID = Orders.CustomerID
	inner join [Order Details]
	on Orders.OrderID = [Order Details].OrderID
	inner join Products
	on Products.ProductID = [Order Details].ProductID
	inner join Categories
	on Categories.CategoryID = Products.CategoryID and Categories.CategoryName not like '%confections%'
	
	select CompanyName, Phone
	from Customers as c
	where exists ( select * from Orders as o
					where o.CustomerID = c.CustomerID
					and exists(select * from [Order Details] as od
								where od.OrderID = o.OrderID
								and exists (select * from Products as p
											where p.ProductID = od.ProductID
											and not exists(select * from Categories as ca
														where ca.CategoryID = p.CategoryID
														and ca.CategoryName like '%confections%'
														)
											)
								)
					)
					
/*1.Dla ka�dego produktu podaj maksymaln� liczb� zam�wionych jednostek*/

	select distinct ProductID, MAX(quantity)
	from [Order Details] 
	group by ProductID
	order by ProductID

	select distinct od1.ProductID, od1.Quantity
	from [Order Details]  as od1
	where Quantity=(select MAX(Quantity) 
					from [Order Details] as od2
					where od1.ProductID = od2.ProductID
					)
	order by ProductID
						
/*2.Podaj wszystkie produkty kt�rych cena jest mniejsza ni� �rednia cena produktu*/

select ProductName, UnitPrice, (select AVG(UnitPrice) from Products)
from Products
where UnitPrice < (select AVG(UnitPrice) from Products)

select p1.ProductName, p1.UnitPrice ,AVG(p2.UnitPrice)
from Products as p1
cross join Products as p2
group by p1.ProductName, p1.UnitPrice 
having p1.UnitPrice < AVG(p2.UnitPrice)

/*3.Podaj wszystkie produkty kt�rych cena jest mniejsza ni� �rednia cena produktu danej kategorii*/

select p1.ProductName, p1.Unitprice, p1.CategoryID ,(select AVG(UnitPrice) from Products as p2
						where p1.CategoryID = p2.CategoryID
						group by p2.CategoryID)
from Products as p1
where p1.UnitPrice < (select AVG(UnitPrice) from Products as p2
						where p1.CategoryID = p2.CategoryID
						group by p2.CategoryID)

select p1.ProductName, p1.UnitPrice, p1.CategoryID, AVG(p2.UnitPrice)
from Products as p1
inner join Products as p2
on p1.CategoryID = p2.CategoryID
group by p1.ProductName, p1.UnitPrice, p1.CategoryID
having p1.UnitPrice < AVG(p2.UnitPrice)
order by p1.CategoryID

/*1.Dla ka�dego produktu podaj jego nazw�, cen�, �redni� cen� wszystkich produkt�w 
oraz r�nic� mi�dzy cen� produktu a �redni� cen� wszystkich produkt�w*/

select ProductName, UnitPrice, (select AVG(Unitprice) from Products), UnitPrice-(select AVG(Unitprice) from Products)
from Products

select p1.ProductName, p1.UnitPrice, AVG(p2.UnitPrice), p1.UnitPrice - AVG(p2.UnitPrice)
from Products as p1
cross join Products as p2
group by p1.ProductName, p1.UnitPrice


/*2.Dla ka�dego produktu podaj jego nazw� kategorii, nazw� produktu, cen�, 
�redni� cen� wszystkich produkt�w danej kategorii oraz r�nic� mi�dzy cen� produktu 
a �redni� cen� wszystkich produkt�w danej kategorii */

select ProductName, (select CategoryName from Categories as c
					where p.CategoryID = c.CategoryID ) as 'kategoria',
					UnitPrice,
					(select avg(UnitPrice) from Products as p2
					where p.CategoryID = p2.CategoryID)as 'avg_kategoria',
					UnitPrice-(select avg(UnitPrice) from Products as p2
					where p.CategoryID = p2.CategoryID)'roznica'
from Products as p

select p1.ProductName, c.CategoryName, p1.UnitPrice, AVG(p2.UnitPrice), p1.UnitPrice-AVG(p2.UnitPrice)
from Products as p1
inner join Products as p2
on p1.CategoryID = p2.CategoryID
inner join Categories as c
on p1.CategoryID = c.CategoryID
group by  p1.ProductName, p1. CategoryID, p1.UnitPrice, c.CategoryName
order by p1.CategoryID

/*1.Podaj ��czn� warto�d zam�wienia o numerze 10250 (uwzgl�dnij cen� za przesy�k�)*/

select OrderID, Freight+ (select SUM(Quantity*Unitprice*(1-Discount)) 
						  from [Order Details] 
						  where OrderID=10252)
from Orders
where OrderID=10252

select Freight+ SUM(Quantity*UnitPrice*(1-Discount))
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID and o.OrderID =10252 and od.OrderID = 10252
group by Freight


/*2.Podaj ��czn� warto�d zam�wieo ka�dego zam�wienia (uwzgl�dnij cen� za przesy�k�)*/

select OrderID, Freight +( select SUM(Quantity*Unitprice*(1-Discount)) 
							from [Order Details] as od2 
							where o1.OrderID = od2.OrderID)
from Orders as o1 

select o.OrderID, o.Freight + SUM(Quantity*UnitPrice*(1-Discount))
from Orders as o
left outer join [Order Details] as od
on o.OrderID = od.OrderID
group by o.OrderID, o.Freight

/*3.Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia w 1997 roku, 
je�li tak to poka� ich dane adresowe*/

select CompanyName, Address
from Customers as c
where not exists(select * from Orders as o
				where YEAR(OrderDate)=1997
				and c.CustomerID = o.CustomerID)
				
select c.CompanyName
from Customers as c
left outer join Orders as o
on c.CustomerID = o.CustomerID and YEAR(o.OrderDate)=1997
where o.OrderID is null

/*4.Podaj produkty kupowane przez wi�cej ni� jednego klienta*/

select distinct ProductID, count ( distinct CustomerID)
from [Order Details] as od
inner join Orders as o
on od.OrderID = o.OrderID
group by ProductID
having count ( distinct CustomerID)>1
order by ProductID


/*1.Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�d zam�wieo 
obs�u�onych przez tego pracownika (przy obliczaniu warto�ci zam�wieo uwzgl�dnij cen� za przesy�k�_*/

select e.EmployeeID, o.Freight --e.EmployeeID, o.Freight, SUM(Quantity*UnitPrice*(1-Discount))
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.EmployeeID, o.Freight


/*2.Kt�ry z pracownik�w obs�u�y� najaktywniejszy (obs�u�y� zam�wienia o najwi�kszej warto�ci) 
w 1997r, podaj imi� i nazwisko takiego pracownika */

select e.LastName, SUM(Quantity*UnitPrice*(1-Discount))
from Employees as e
inner join Orders as o
on o.EmployeeID = e.EmployeeID and year(o.OrderDate)=1997 
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.LastName
order by SUM(Quantity*UnitPrice*(1-Discount))

select e.LastName, (select SUM(Quantity*UnitPrice*(1-Discount)) from [Order Details] as od
							where od.orderid in(select o.orderid
												from Orders as o
												where o.EmployeeID = e.EmployeeID
												and year(o.OrderDate)=1997) 
					) as t
from Employees as e
order by t
				
/*3.Ogranicz wynik z pkt 1 tylko do pracownik�w
 a) kt�rzy maj� podw�adnych b) kt�rzy nie maj� podw�adnych */
 
/*4.Zmodyfikuj rozwi�zania z pkt 3 tak aby dla pracownik�w 
pokazad jeszcze dat� ostatnio obs�u�onego zam�wienia */