drop database if exists Webshop;
create database Webshop;
use Webshop;

create table Item(
    id int not null auto_increment primary key,
    name varchar(100) not null,
    size varchar(10) not null,
    price int not null,
    brand varchar(100) not null,
    stockQuantity int not null
);

create table Category(
    id int not null auto_increment primary key,
    name varchar(100) not null,
    description varchar(255) not null
);

create table Customer(
    id int not null auto_increment primary key,
    firstName varchar(100) not null,
    lastName varchar(100) not null,
    email varchar(100) not null,
    phoneNumber varchar(100) not null,
    address varchar(255) not null
);

create table Orders(
    id int not null auto_increment primary key,
    date date not null,
    customer_id int not null,
    foreign key (customer_id) references Customer(id)
);

create table OrderItem(
    id not null auto_increment primary key,
    quantity int not null,
    order_id int not null,
    item_id int not null,
    foreign key (order_id) references Order(id),
    foreign key (item_id) references Item(id)
);

create tabel ItemCategory(
    id int not null auto_increment primary key,
    item_id int not null,
    category_id int not null,
    foreign key (item_id) references Item(id),
    foreign key (category_id) references Category(id)
);