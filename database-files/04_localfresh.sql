drop database if exists localfresh;

create database if not exists localfresh;

use localfresh;

create table if not exists customers (
  id integer auto_increment,
  first_name varchar(255) not null,
  last_name varchar(255) not null,
  age integer,
  dob datetime,
  address varchar(255) not null,
  email varchar(255) not null,
  primary key (id)
);

create table if not exists customer_addresses (
  id integer,
  address varchar(255),
  primary key (id, address),
  foreign key (id) references customers(id) on update cascade on delete cascade
);

create table if not exists driver (
  id integer auto_increment,
  first_name varchar(255) not null,
  last_name varchar(255) not null,
  vehicle_type varchar(255),
  primary key (id)
);

create table if not exists store (
  id integer auto_increment,
  name varchar(255) not null,
  phone bigint unique not null,
  primary key (id)
);

create table if not exists orders (
  id integer auto_increment,
  time_created datetime default current_timestamp,
  time_fulfilled datetime on update current_timestamp,
  pickup_address varchar(255) not null,
  delivery_address varchar(255) not null,
  customer_id integer not null,
  store_id integer not null,
  driver_id integer not null,
  primary key (id),
  foreign key (customer_id) references customers(id) on update cascade on delete cascade,
  foreign key (store_id) references store(id) on update cascade on delete restrict,
  foreign key (driver_id) references driver(id) on update cascade on delete restrict
);

create table if not exists analyst (
  id integer auto_increment,
  first_name varchar(255) not null,
  last_name varchar(255) not null,
  email varchar(255) not null,
  primary key (id)
);

create table if not exists analyst_orders (
  analyst_id integer,
  orders_id integer,
  primary key (analyst_id, orders_id),
  foreign key (analyst_id) references analyst(id) on update cascade on delete restrict,
  foreign key (orders_id) references orders(id) on update restrict on delete restrict
);

create table if not exists store_addresses (
  id integer,
  address varchar(255),
  primary key (id, address),
  foreign key (id) references store(id) on update cascade on delete restrict
);

create table if not exists store_emails (
  id integer,
  email varchar(255),
  primary key (id, email),
  foreign key (id) references store(id) on update cascade on delete restrict
);

create table if not exists category (
  id integer auto_increment,
  name varchar(255) unique not null,
  primary key (id)
);

create table if not exists product (
  id integer auto_increment unique,
  store_id integer not null,
  category_id integer not null,
  name varchar(255) not null,
  units_in_stock integer,
  price decimal(65,2) not null,
  primary key (id, store_id),
  foreign key (category_id) references category(id) on update cascade on delete cascade,
  foreign key (store_id) references store(id) on update cascade on delete restrict
);

create table if not exists orders_product (
  orders_id integer,
  product_id integer,
  quantity integer not null,
  primary key (orders_id, product_id),
  foreign key (orders_id) references orders(id) on update restrict on delete restrict,
  foreign key (product_id) references product(id) on update cascade on delete restrict
);


#basic sample data for initial testing.
#TODO: add mockaroo data below or in new file, sequentially lower (e.g. 05_sampledata.sql)

INSERT INTO driver (first_name, last_name, vehicle_type, id)
VALUES ('Bob', 'Fuller', 'Car', 789),
	   ('Jane', 'Smith', 'Bike', 123);

INSERT INTO store (name, phone, id)
VALUES ('Max\'s Fish Market', 1234567891, 235),
	   ('Bill\'s Local Farm', 6578904324, 888);

INSERT INTO customers (first_name, last_name, age, dob, address, email, id)
VALUES ('John', 'Smith', 23, '2000-12-24', '123 Avery Ct, Juniper FL', 'johnsmith@gmail.com', 333),
       ('Emily', 'Doe', 26, '1997-11-02', '55 Building Rd, Pittsburgh PA', 'emilydoe@gmail.com', 989);


INSERT INTO orders (pickup_address, delivery_address, customer_id, store_id, driver_id, id)
VALUES ('78 Computer Ln, New York NY','55 Building Rd, Pittsburgh PA', 989, 888, 123, 333),
('78 Computer Ln, New York NY','123 Avery Ct, Juniper FL', 333, 235, 789, 111);

INSERT INTO category (id, name)
VALUES (235, 'Fresh Fish');

INSERT INTO store (id, name, phone)
VALUES (1, 'Whole Foods', 1243675899);

INSERT INTO product (store_id, name, price, units_in_stock, category_id)
VALUES (1, 'Fresh Salmon', 10, 1, 235),
       (1, 'Fresh Halibut', 15, 2, 235);

