/*1. Dla ka¿dego przewoŸnika (nazwa) podaj liczbê zamówieñ które
przewieŸli w 1997r*/

select CompanyName, COUNT(OrderID)
from Shippers
inner join Orders
on Orders.ShipVia = Shippers.ShipperID and YEAR(shippeddate)=1997
group by CompanyName

/*3. Który z pracowników obs³u¿y³ najwiêksz¹ liczbê zamówieñ w 1997r,
podaj imiê i nazwisko takiego pracownika*/

select Employees.LastName, COUNT(OrderID)  
from Employees
inner join Orders
on Orders.EmployeeID = Employees.EmployeeID and YEAR(OrderDate)=1997
group by Employees.LastName

select Employees.LastName, COUNT(OrderID)  
from Employees
inner join Orders
on Orders.EmployeeID = Employees.EmployeeID
where YEAR(OrderDate)=1997 
group by Employees.LastName

/*1. Dla ka¿dego pracownika (imiê i nazwisko) podaj ³¹czn¹ wartoœæ
zamówieñ obs³u¿onych przez tego pracownika*/

select Employees.LastName, SUM(od.UnitPrice*od.Quantity*(1-od.Discount))
from Employees
inner join Orders
on Employees.EmployeeID = Orders.EmployeeID
inner join [Order Details] as od
on Orders.OrderID = od.OrderID
group by Employees.LastName

/**2. Który z pracowników obs³u¿y³ najaktywniejszy (obs³u¿y³ zamówienia
o najwiêkszej wartoœci) w 1997r, podaj imiê i nazwisko takiego
pracownika*/

select top 1 Employees.LastName, SUM(od.UnitPrice*od.Quantity*(1-od.Discount))
from Employees
inner join Orders
on Employees.EmployeeID = Orders.EmployeeID
inner join [Order Details] as od
on Orders.OrderID = od.OrderID
where year(Orders.OrderDate) = 1997
group by Employees.LastName
order by SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) desc

/*3. Ogranicz wynik z pkt 1 tylko do pracowników

b) którzy nie maj¹ podw³adnych*/

select szef.LastName, SUM(od.UnitPrice*od.Quantity*(1-od.Discount))
from Employees as podwladny
right outer join Employees as szef
on podwladny.ReportsTo = szef.EmployeeID
inner join Orders
on szef.EmployeeID = Orders.EmployeeID
inner join [Order Details] as od
on Orders.OrderID = od.OrderID
where year(Orders.OrderDate) = 1997 and podwladny.EmployeeID is NULL
group by szef.LastName

/*a) którzy maj¹ podw³adnych*/
select szef.LastName, SUM(od.UnitPrice*od.Quantity*(1-od.Discount))
from Employees as podwladny
right outer join Employees as szef
on podwladny.ReportsTo = szef.EmployeeID
inner join Orders
on szef.EmployeeID = Orders.EmployeeID
inner join [Order Details] as od
on Orders.OrderID = od.OrderID
where year(Orders.OrderDate) = 1997 and podwladny.EmployeeID is not NULL
group by szef.LastName

select LastName, ReportsTo from Employees

