/**podzapytania do tabel**/
use northwind
select T.OrderID, T.CustomerID
from (select OrderID, CustomerID from Orders) as T

/**podzapytania jako wyrazenie**/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products) as average,
		UnitPrice-(select AVG(UnitPrice) from Products)as difference
from Products

/**podzapytania w warunku**/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products) as average,
		UnitPrice-(select AVG(UnitPrice) from Products)as difference
from Products
where UnitPrice > (select AVG(UnitPrice) from Products)

/**podzapytania skorelowane**/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products as p_wew 
		where p_zewn.CategoryID = p_wew.CategoryID) as average
from Products as p_zewn

/**podzapytania skorelowane w warunku**/
use northwind
select ProductName, UnitPrice, 
		(select AVG(UnitPrice) from Products as p_wew 
		where p_zewn.CategoryID = p_wew.CategoryID ) as average
from Products as p_zewn
where UnitPrice > (select AVG(UnitPrice) from Products as p_wew 
				   where p_zewn.CategoryID = p_wew.CategoryID)

/** dla kazdego produktu maksymalna ilosc zamowionych jednostek**/
use northwind
select distinct ProductID, Quantity
from [Order Details] as ord1
	where Quantity= (select MAX(quantity) 
				from [Order Details] as ord2
				where ord1.ProductID = ord2.ProductID)
order by Productid

/** dla kazdego produktu maksymalna ilosc zamowionych jednostek
przy uzyciu group by**/
use northwind
select ProductID, max(Quantity)
from [Order Details] 
group by ProductID
order by ProductID

/** exist **/
use northwind
select LastName, EmployeeID
from Employees as e
where exists (select * from Orders as o
	where e.EmployeeID = o.EmployeeID
	and o.OrderDate = '9/5/97')
	
/** to samo na joinach **/
use northwind
select distinct LastName, e.EmployeeID
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID and o.OrderDate = '9/5/97'

/** not exist **/
use northwind
select LastName, EmployeeID
from Employees as e
where not exists (select * from Orders as o
	where e.EmployeeID = o.EmployeeID
	and o.OrderDate = '9/5/97')

/** in**/
use northwind
select LastName, EmployeeID
from Employees as e
where EmployeeID in (select EmployeeID from Orders as o
					where o.OrderDate = '9/5/97')