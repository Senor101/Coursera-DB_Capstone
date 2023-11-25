
Create View OrdersView as
 select OrderID,Quantity,TotalCost from Orders 
 where quantity>2;

select * from OrdersView;


select C.CustomerID, C.Name,
 O.OrderID, O.TotalCost,
 M.MenuName, MI.MainCourse 
 from Orders as O inner join Customers as C on O.CustomerID = C.CustomerID
 inner join Menu as M on O.MenuID = M.MenuID inner join 
 MenuItems as MI on M.MenuItemID = MI.MenuItemID
 Where O.TotalCost > 150 
 Order by O.TotalCost asc;

select MenuName from Menu where MenuID = any (
select MenuID from Orders where Quantity > 2);



-- Procedure GetMaxQuantity
DELIMITER //

create procedure GetMaxQuantity()
begin
select max(Quantity) as 'Max Quantity in Order' from Orders;
end

//

call GetMaxQuantity();

-- Prepared statement GetOrderDetail
prepare GetOrderDetail from 'SELECT OrderID,Quantity,TotalCost FROM Orders WHERE CustomerID=?'; 

set @id =1 ;
execute GetOrderDetail using @id;


-- Procedure cancelOrder
delimiter //
create procedure cancelOrder (in id INT)
begin
delete from orders where OrderID = id;
select distinct concat('Order ', id, ' is cancelled') as Confirmation from Orders;
end
//
 

call cancelOrder(2);
