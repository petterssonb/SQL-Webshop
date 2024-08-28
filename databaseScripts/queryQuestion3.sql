-- Fråga 3
 -- Skapa en kundlista med den totala summan pengar som varje kund har handlat för.
 -- Kundens för- och efternamn, samt det totala värdet som varje person har shoppats för, skall visas.

select Customer.firstName as 'First name', Customer.lastName as 'Last name', sum(OrderItem.quantity * Item.price) as OrderValue
from Customer inner join Orders on Customer.id = Orders.customer_id
inner join OrderItem on Orders.id = OrderItem.order_id
inner join Item on OrderItem.item_id = Item.id
group by Customer.id, Customer.firstName, Customer.lastName
order by OrderValue desc;