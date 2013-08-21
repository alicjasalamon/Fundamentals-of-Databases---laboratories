/*1. Wybierz nazwy i numery telefonów klientów, którzy nie kupili ¿adnego produktu z kategorii 
‘Confections’. Rozwi¹zaæ u¿ywaj¹c mechanizmu podzapytañ.*/

select CompanyName, Phone
from Customers as c
where not exists(select * from Orders as o
			where c.CustomerID = o.CustomerID
			and exists(select * from [Order Details] as od
						where od.OrderID = o.OrderID
						and exists(select * from Products as p
									where p.ProductID = od.ProductID
									and exists(select * from Categories as c
													where c.CategoryID = P.CategoryID
													and c.CategoryName like 'Confections'
													)
									)
						)
			)


/*2. Dla ka¿dego produktu podaj jego nazwê kategorii, nazwê produktu, 
cenê, œredni¹ cenê wszystkich produktów danej kategorii oraz ró¿nicê miêdzy cen¹ produktu a œ
redni¹ cen¹ wszystkich produktów danej kategorii.*/

select ProductName, (select CategoryName from Categories as c
					where c.CategoryID = p.CategoryID) as 'category',
					(select AVG(UnitPrice) from Products as p2
					where p2.CategoryID = p.CategoryID) as 'srednia', 
					UnitPrice-(select AVG(UnitPrice) from Products as p2
					where p2.CategoryID = p.CategoryID)	as 'roznica'
from Products as p

/*3. Dla ka¿dego pracownika wypisz iloœæ zamówieñ, jakie obs³u¿y³ w 1997 roku, 
podaj tak¿e datê ostatniego obs³ugiwanego przez niego zamówienia (w 1997 r.). 
Interesuj¹ nas pracownicy, którzy obs³u¿yli wiêcej ni¿ szeœæ zamówieñ. */

select EmployeeID ,MAX(OrderDate), COUNT(OrderID)
from Orders as o
where YEAR(OrderDate) = 1997
group by EmployeeID
having COUNT(OrderID)>6

/*4. Wypisz kwoty nale¿ne przewoŸnikom z podzia³em na lata.*/

select ShipVia, YEAR(OrderDate), SUM(Freight)
from Orders
group by ShipVia, YEAR(OrderDate)
order by ShipVia, YEAR(OrderDate)

/**********************************************************/

/*podaj ³¹czn¹ wartoœæ dla ka¿dego zamówienia (uwzglêdnij cenê
za przesy³kê) - bez podzapytañ*/

select o.OrderID, Freight + SUM(Quantity*UnitPrice*(1-Discount))
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by o.OrderID, Freight
order by o.OrderID

/*czy sa jacys czytelnicy, ktorzy nie przeczytali zadnej ksiazki w 1996
na 2 sposoby*/

use library
select distinct member_no
from loanhist as l1
where not exists(select * from loanhist as l2
					where year(in_date)=2002
					and l1.member_no = l2.member_no)
					
use library
select member_no, COUNT(*)
from loanhist
where month(in_date)=2002
group by member_no
having COUNT(*) =0

select * from loanhist

select in_date
from loanhist


/*podaj wszystkie zamowienia, dla ktorych oplata za przesylke
byla wieksza od sredniej oplaty za przesylke zamowien zlozonych w tym 
samym eoku. 2 sposoby */

use northwind
select OrderID, YEAR(OrderDate),Freight, (select AVG(Freight) from Orders as o2
								where year(o1.OrderDate)= year(o2.OrderDate))
from Orders as o1
where Freight > (select AVG(Freight) from Orders as o2
				where year(o1.OrderDate)= year(o2.OrderDate))
				

use northwind
select distinct o1.OrderID, AVG(o2.Freight)
from Orders as o1
inner join Orders as o2
on YEAR(o1.OrderDate)=YEAR(o2.OrderDate)
group by o1.OrderID, o1.Freight
having o1.Freight < AVG(o2.Freight)


/*dla kazdego pracownika podaj jego imie i nawisko oraz calkowita
liczbe zamowien jakie obsluzyl ogolem oraz z rozbiciem na lata, kwartaly i miesiace*/

select e.LastName, e.FirstName, year(o.OrderDate), DATEPART(Q, o.OrderDate), MONTH(o.OrderDate),COUNT (*)
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
group by e.LastName, e.FirstName, year(o.OrderDate), DATEPART(Q, o.OrderDate), MONTH(o.OrderDate) 
with rollup
having e.LastName is not null and e.FirstName is not null

/*---------------------------------------------------------------------------------------*/
/*1) Czy s¹ jacyœ pracownicy, którzy nie obs³u¿yli ¿adnego zamówienia w 1997 
roku jeœli tak to podaj ich dane adresowe */

select distinct e.LastName
from Employees as e
left outer join Orders as o
on e.EmployeeID =o.EmployeeID and YEAR(o.OrderDate)=1997

/*2) Podaj imiê, nazwisko, adres oraz iloœæ aktualnie wypo¿yczonych ksi¹¿ek 
dla ka¿dego cz³onka biblioteki. Dla ka¿dego czytelnika dodaj adnotacjê czy 
jest czytelnikiem pe³no- czy te¿ niepe³noletnim.                                         
??????????????????????????????????????????????????????????????????????????????????????????????? */

use library
select m.lastname,m.firstname, COUNT(*)
from member as m
inner join loan as l
on m.member_no = l.member_no
group by m.member_no, m.firstname, m.lastname

/* wypisz wsystkie produkty ktorych cena jest mniejsza 
od sredniej ceny produktow bez nich*/

use northwind
select p1.ProductName, p1.CategoryID, p1.UnitPrice, AVG(p2.UnitPrice) 
from Products as p1
inner join Products as p2
on p1.CategoryID = p2.CategoryID
group by p1.ProductName, p1.CategoryID, p1.UnitPrice
having p1.UnitPrice<AVG(p2.UnitPrice) 
order by p1.CategoryID

