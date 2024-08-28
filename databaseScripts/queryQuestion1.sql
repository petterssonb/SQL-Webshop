-- Fråga 1
 -- Vilka kunder har köpt svarta t-shirts i storlek M av märket H&M?

select distinct Customer.firstName as 'Customers'
from Item left join OrderItem on Item.id = OrderItem.item_id
inner join Orders on Orders.id = OrderItem.order_id
right join Customer on Customer.id = Orders.customer_id
where (Item.color = 'Black' and Item.size = 'M' and Item.brand = 'H&M');