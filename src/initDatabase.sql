drop database if exists Webshop;
create database Webshop;
use Webshop;

create table Item(
    id int not null auto_increment primary key,
    name varchar(100) not null,
    size ENUM ('XS', 'S', 'M', 'L', 'XL', 'XXL') not null,
    price int not null,
    brand varchar(100) not null,
    stockQuantity int not null,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table Category(
    id int not null auto_increment primary key,
    name varchar(100) not null,
    description varchar(255) not null,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table Customer(
    id int not null auto_increment primary key,
    firstName varchar(100) not null,
    lastName varchar(100) not null,
    email varchar(100) not null,
    phoneNumber varchar(100) not null,
    address varchar(255) not null,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table Orders(
    id int not null auto_increment primary key,
    date datetime not null,
    customer_id int null,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    foreign key (customer_id) references Customer(id) on delete set null
);

create table OrderItem(
    id int not null auto_increment primary key,
    quantity int not null,
    order_id int not null,
    item_id int not null,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    foreign key (order_id) references Orders(id) on delete cascade,
    foreign key (item_id) references Item(id) on delete cascade
);

create table ItemCategory(
    id int not null auto_increment primary key,
    item_id int not null,
    category_id int not null,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    foreign key (item_id) references Item(id) on delete cascade,
    foreign key (category_id) references Category(id) on delete cascade
);

insert into Item (name, size, price, brand, stockQuantity) values
('T-shirt', 'M', 199, 'H&M', 100),
('Jeans', 'L', 499, 'Levis', 50),
('Sweater', 'S', 299, 'Gant', 75),
('Dress', 'M', 399, 'Zara', 25),
('Shirt', 'XL', 249, 'Polo', 125),
('Jacket', 'L', 699, 'Peak Performance', 30);

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
(3, 3, 6),
(1, 4, 1),
(4, 4, 2),
(2, 5, 3),
(3, 5, 4),
(1, 6, 5),
(4, 6, 6),
(2, 7, 1),
(3, 7, 2),
(1, 8, 3),
(4, 8, 4),
(2, 9, 5),
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
