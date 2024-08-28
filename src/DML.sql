use Webshop;

insert into Item (name, size, price, brand, color, stockQuantity) values
('T-shirt', 'M', 199, 'H&M', 'Black', 100),
('T-shirt', 'L', 199, 'H&M', 'Black', 50),
('Jeans', 'L', 499, 'Levis', 'Blue', 50),
('Sweater', 'S', 299, 'Gant', 'Green', 75),
('Dress', 'M', 399, 'Zara', 'Pink', 25),
('Shirt', 'XL', 249, 'Polo', 'Yellow', 125),
('Jacket', 'L', 699, 'Peak Performance', 'Red', 30);

select * from Item;

insert into Category (name, description) values
('Spring', 'Spring collection'),
('Summer', 'Summer collection'),
('Autumn', 'Autumn collection'),
('Winter', 'Winter collection'),
('Sale', 'Sale collection');

select * from Category;

insert into Customer (firstName, lastName, email, phoneNumber, address) values
('Annie', 'Andersson', 'annie.andersson@gmail.com', '070-1234567', 'Storgatan 1, 123 45 Staden'),
('Bertil', 'Bertilsson', 'bertil.bertilsson@gmail.com', '070-2345678', 'Sveavägen 4, 136 4 Stockholm'),
('Cecilia', 'Richardsson', 'cecilia.richardsson@gmail.com', '070-3456789', 'Drottninggatan 5, 123 45 Staden'),
('Erik', 'Pettersson', 'erik.pettersson@gmail.com', '070-4567890', 'Gaffelseglet 23, 136 56 Haninge'),
('Frida', 'Göransson', 'frida.göransson@gmail.com', '070-5678901', 'Kungsgatan 12, 123 45 Staden'),
('Gustav', 'Larsson', 'gustav.larsson@gmail.com', '070-6789012', 'Kingelinggatan 8, 123 45 Staden');

select * from Customer;

insert into Orders (date, customer_id) values
('2024-09-01 12:00:00', 1),
('2023-04-02 13:00:00', 2),
('2022-01-08 14:00:00', 3),
('2021-08-21 15:00:00', 4),
('2024-04-26 16:00:00', 5),
('2021-06-02 17:00:00', 6),
('2023-12-12 18:00:00', 1),
('2022-10-10 19:00:00', 2),
('2021-07-07 20:00:00', 3),
('2024-03-03 21:00:00', 4);

select * from Orders;

insert into OrderItem (quantity, order_id, item_id) values
(2, 1, 1),
(3, 1, 2),
(1, 2, 3),
(4, 2, 4),
(2, 3, 5),
(3, 3, 1),
(1, 4, 1),
(4, 4, 2),
(2, 5, 1),
(3, 5, 4),
(1, 6, 5),
(4, 6, 6),
(2, 7, 1),
(3, 7, 7),
(1, 8, 3),
(4, 8, 4),
(2, 9, 7),
(3, 9, 6),
(1, 10, 1),
(4, 10, 2);

select * from OrderItem;

insert into ItemCategory (item_id, category_id) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 1),
(6, 2),
(1, 3),
(2, 4),
(3, 5),
(4, 1),
(5, 2),
(6, 3);

select * from ItemCategory;

-- Fråga 1
select distinct Customer.firstName as 'Customers'
from Item left join OrderItem on Item.id = OrderItem.item_id
inner join Orders on Orders.id = OrderItem.order_id
right join Customer on Customer.id = Orders.customer_id
where (Item.color = 'Black' and Item.size = 'M' and Item.brand = 'H&M');

-- Fråga 2
select Category.name as 'Category', count(ItemCategory.id) as ItemCount from Category
left join ItemCategory on Category.id = ItemCategory.category_id
group by Category.name
order by ItemCount desc;

-- Fråga 3
select Customer.firstName as 'First name', Customer.lastName as 'Last name', sum(OrderItem.quantity * Item.price) as OrderValue
from Customer inner join Orders on Customer.id = Orders.customer_id
inner join OrderItem on Orders.id = OrderItem.order_id
inner join Item on OrderItem.item_id = Item.id
group by Customer.id, Customer.firstName, Customer.lastName
order by OrderValue desc;

-- Indexering
create index customerLastName on Customer(lastName);
