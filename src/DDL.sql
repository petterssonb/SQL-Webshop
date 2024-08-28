drop database if exists Webshop;
create database Webshop;
use Webshop;

create table Item(
    id int not null auto_increment primary key,
    name varchar(100) not null,
    size ENUM ('XS', 'S', 'M', 'L', 'XL', 'XXL') not null,
    price int not null,
    brand varchar(100) not null,
    color varchar(100) not null,
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
