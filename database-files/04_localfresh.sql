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

insert into customers (id, first_name, last_name, email, age, dob, address) values (1, 'Randa', 'Wolpert', 'rwolpert0@edublogs.org', 14, '1994-12-06', '35 Hauk Crossing');
insert into customers (id, first_name, last_name, email, age, dob, address) values (2, 'Avie', 'Simcoe', 'asimcoe1@multiply.com', 26, '2004-05-11', '177 Erie Avenue');
insert into customers (id, first_name, last_name, email, age, dob, address) values (3, 'Zaria', 'Howman', 'zhowman2@dell.com', 1, '1982-06-04', '95304 Cascade Lane');
insert into customers (id, first_name, last_name, email, age, dob, address) values (4, 'Adriane', 'Zorzi', 'azorzi3@admin.ch', 3, '2015-05-07', '75 Sachs Hill');
insert into customers (id, first_name, last_name, email, age, dob, address) values (5, 'Lucita', 'Wapplington', 'lwapplington4@statcounter.com', 9, '1973-04-02', '407 Basil Trail');
insert into customers (id, first_name, last_name, email, age, dob, address) values (6, 'Melody', 'Godsal', 'mgodsal5@foxnews.com', 64, '1946-12-25', '280 Fremont Court');
insert into customers (id, first_name, last_name, email, age, dob, address) values (7, 'Frasco', 'Moryson', 'fmoryson6@chicagotribune.com', 9, '1957-07-23', '1 Atwood Park');
insert into customers (id, first_name, last_name, email, age, dob, address) values (8, 'Tera', 'Landor', 'tlandor7@tuttocitta.it', 30, '1941-09-07', '11769 Algoma Trail');
insert into customers (id, first_name, last_name, email, age, dob, address) values (9, 'Fabian', 'Merrifield', 'fmerrifield8@google.com.hk', 66, '2003-10-26', '7 Artisan Street');
insert into customers (id, first_name, last_name, email, age, dob, address) values (10, 'Alix', 'Andrichuk', 'aandrichuk9@usgs.gov', 76, '1944-02-04', '1 Hayes Hill');
insert into customers (id, first_name, last_name, email, age, dob, address) values (11, 'Reginauld', 'Elsegood', 'relsegooda@sourceforge.net', 1, '2008-02-07', '2753 Lerdahl Crossing');
insert into customers (id, first_name, last_name, email, age, dob, address) values (12, 'Paxton', 'Duffus', 'pduffusb@ustream.tv', 46, '2008-08-01', '036 Fordem Lane');
insert into customers (id, first_name, last_name, email, age, dob, address) values (13, 'Caterina', 'Paten', 'cpatenc@usnews.com', 48, '1999-12-04', '57 Claremont Lane');
insert into customers (id, first_name, last_name, email, age, dob, address) values (14, 'Pepe', 'Lewinton', 'plewintond@marriott.com', 2, '1935-07-05', '8766 Rockefeller Place');
insert into customers (id, first_name, last_name, email, age, dob, address) values (15, 'Melessa', 'Mellem', 'mmelleme@cnbc.com', 94, '1953-01-12', '5708 Mandrake Crossing');
insert into customers (id, first_name, last_name, email, age, dob, address) values (16, 'Dionysus', 'Edgler', 'dedglerf@economist.com', 22, '2016-11-09', '699 Old Shore Trail');
insert into customers (id, first_name, last_name, email, age, dob, address) values (17, 'Wilone', 'Cream', 'wcreamg@huffingtonpost.com', 86, '2010-06-27', '9958 Prentice Street');
insert into customers (id, first_name, last_name, email, age, dob, address) values (18, 'Cris', 'Sango', 'csangoh@latimes.com', 40, '1989-06-26', '88 Mosinee Drive');
insert into customers (id, first_name, last_name, email, age, dob, address) values (19, 'Aryn', 'Pincked', 'apinckedi@miibeian.gov.cn', 27, '1985-07-18', '090 Messerschmidt Place');
insert into customers (id, first_name, last_name, email, age, dob, address) values (20, 'Lisle', 'Fishbourne', 'lfishbournej@mozilla.com', 33, '1951-07-24', '97 Birchwood Parkway');
insert into customers (id, first_name, last_name, email, age, dob, address) values (21, 'Gilles', 'Fores', 'gforesk@flavors.me', 77, '2012-09-16', '3 Talisman Trail');
insert into customers (id, first_name, last_name, email, age, dob, address) values (22, 'Shirley', 'Godsafe', 'sgodsafel@nature.com', 94, '1945-10-18', '873 Karstens Junction');
insert into customers (id, first_name, last_name, email, age, dob, address) values (23, 'Maxim', 'Sprackling', 'mspracklingm@wordpress.org', 54, '1990-04-19', '709 Alpine Circle');
insert into customers (id, first_name, last_name, email, age, dob, address) values (24, 'Kristal', 'Rumming', 'krummingn@networkadvertising.org', 42, '1976-10-17', '24272 Talmadge Junction');
insert into customers (id, first_name, last_name, email, age, dob, address) values (25, 'Gertrudis', 'Abby', 'gabbyo@wikia.com', 94, '1975-05-09', '74 Russell Avenue');
insert into customers (id, first_name, last_name, email, age, dob, address) values (26, 'Kiersten', 'Larter', 'klarterp@boston.com', 35, '2024-05-29', '830 Union Terrace');
insert into customers (id, first_name, last_name, email, age, dob, address) values (27, 'Alessandro', 'Bassilashvili', 'abassilashviliq@cloudflare.com', 20, '1980-08-11', '933 Mendota Pass');
insert into customers (id, first_name, last_name, email, age, dob, address) values (28, 'Boycey', 'Haddock', 'bhaddockr@eventbrite.com', 25, '1934-04-23', '17069 3rd Park');
insert into customers (id, first_name, last_name, email, age, dob, address) values (29, 'Cindie', 'Salvadore', 'csalvadores@imageshack.us', 32, '2022-12-17', '5 Harper Drive');
insert into customers (id, first_name, last_name, email, age, dob, address) values (30, 'Helsa', 'Butt', 'hbuttt@google.com', 37, '1977-08-29', '5532 Declaration Point');
insert into customers (id, first_name, last_name, email, age, dob, address) values (31, 'Judah', 'Takis', 'jtakisu@dot.gov', 24, '2023-01-18', '819 Oak Valley Lane');
insert into customers (id, first_name, last_name, email, age, dob, address) values (32, 'Kikelia', 'Unstead', 'kunsteadv@umich.edu', 24, '1989-06-03', '2 Steensland Way');
insert into customers (id, first_name, last_name, email, age, dob, address) values (33, 'Jecho', 'Hardware', 'jhardwarew@salon.com', 14, '1974-01-27', '201 Weeping Birch Pass');
insert into customers (id, first_name, last_name, email, age, dob, address) values (34, 'Joell', 'Gosz', 'jgoszx@wisc.edu', 22, '1994-06-03', '441 Rigney Avenue');
insert into customers (id, first_name, last_name, email, age, dob, address) values (35, 'Corabella', 'Hanby', 'chanbyy@a8.net', 24, '2024-03-24', '91615 Randy Street');

insert into analyst (id, first_name, last_name, email) values (1, 'Milly', 'Rash', 'mrash0@msn.com');
insert into analyst (id, first_name, last_name, email) values (2, 'Alta', 'Lanon', 'alanon1@nasa.gov');
insert into analyst (id, first_name, last_name, email) values (3, 'Raynard', 'Lamberto', 'rlamberto2@aboutads.info');
insert into analyst (id, first_name, last_name, email) values (4, 'Gilberta', 'Lording', 'glording3@webeden.co.uk');
insert into analyst (id, first_name, last_name, email) values (5, 'Gery', 'Hubbucke', 'ghubbucke4@pcworld.com');
insert into analyst (id, first_name, last_name, email) values (6, 'Joni', 'Pladen', 'jpladen5@chronoengine.com');
insert into analyst (id, first_name, last_name, email) values (7, 'Olly', 'Gash', 'ogash6@w3.org');
insert into analyst (id, first_name, last_name, email) values (8, 'Alina', 'Bagguley', 'abagguley7@independent.co.uk');
insert into analyst (id, first_name, last_name, email) values (9, 'Phoebe', 'Borgnol', 'pborgnol8@reverbnation.com');
insert into analyst (id, first_name, last_name, email) values (10, 'Elmo', 'Gilligan', 'egilligan9@cbslocal.com');
insert into analyst (id, first_name, last_name, email) values (11, 'Keslie', 'McComiskey', 'kmccomiskeya@salon.com');
insert into analyst (id, first_name, last_name, email) values (12, 'Eberto', 'Meake', 'emeakeb@bbc.co.uk');
insert into analyst (id, first_name, last_name, email) values (13, 'Flem', 'Siemianowicz', 'fsiemianowiczc@marketwatch.com');
insert into analyst (id, first_name, last_name, email) values (14, 'Massimo', 'Ochterlony', 'mochterlonyd@google.ca');
insert into analyst (id, first_name, last_name, email) values (15, 'Joel', 'Cousins', 'jcousinse@lycos.com');
insert into analyst (id, first_name, last_name, email) values (16, 'Doug', 'Bloodworthe', 'dbloodworthef@ft.com');
insert into analyst (id, first_name, last_name, email) values (17, 'Othelia', 'Do', 'odog@wsj.com');
insert into analyst (id, first_name, last_name, email) values (18, 'Brennen', 'Rosson', 'brossonh@xrea.com');
insert into analyst (id, first_name, last_name, email) values (19, 'Frederik', 'Wheatland', 'fwheatlandi@macromedia.com');
insert into analyst (id, first_name, last_name, email) values (20, 'Mickie', 'Antonsson', 'mantonssonj@latimes.com');
insert into analyst (id, first_name, last_name, email) values (21, 'Kippar', 'Heaslip', 'kheaslipk@g.co');
insert into analyst (id, first_name, last_name, email) values (22, 'Devinne', 'Ludlow', 'dludlowl@dyndns.org');
insert into analyst (id, first_name, last_name, email) values (23, 'Dun', 'Blanden', 'dblandenm@twitter.com');
insert into analyst (id, first_name, last_name, email) values (24, 'Carl', 'Van Eeden', 'cvaneedenn@1688.com');
insert into analyst (id, first_name, last_name, email) values (25, 'Ceil', 'Pattingson', 'cpattingsono@rakuten.co.jp');
insert into analyst (id, first_name, last_name, email) values (26, 'Jeth', 'Mollin', 'jmollinp@myspace.com');
insert into analyst (id, first_name, last_name, email) values (27, 'Arlana', 'Anthony', 'aanthonyq@squarespace.com');
insert into analyst (id, first_name, last_name, email) values (28, 'Xaviera', 'Bernhardsson', 'xbernhardssonr@hugedomains.com');
insert into analyst (id, first_name, last_name, email) values (29, 'Drucy', 'Lofty', 'dloftys@printfriendly.com');
insert into analyst (id, first_name, last_name, email) values (30, 'Berti', 'Baggally', 'bbaggallyt@pinterest.com');
insert into analyst (id, first_name, last_name, email) values (31, 'Torey', 'Wharf', 'twharfu@linkedin.com');
insert into analyst (id, first_name, last_name, email) values (32, 'Agosto', 'Skate', 'askatev@webnode.com');
insert into analyst (id, first_name, last_name, email) values (33, 'Bartholomeo', 'Reboul', 'breboulw@reverbnation.com');
insert into analyst (id, first_name, last_name, email) values (34, 'Trstram', 'Paramor', 'tparamorx@skyrock.com');
insert into analyst (id, first_name, last_name, email) values (35, 'Charin', 'Libbe', 'clibbey@unc.edu');
insert into analyst (id, first_name, last_name, email) values (36, 'Bonita', 'Pettegree', 'bpettegreez@w3.org');
insert into analyst (id, first_name, last_name, email) values (37, 'Goddart', 'Caller', 'gcaller10@liveinternet.ru');
insert into analyst (id, first_name, last_name, email) values (38, 'Brig', 'Artindale', 'bartindale11@tumblr.com');
insert into analyst (id, first_name, last_name, email) values (39, 'Ambros', 'McSporrin', 'amcsporrin12@howstuffworks.com');
insert into analyst (id, first_name, last_name, email) values (40, 'Jsandye', 'Collyear', 'jcollyear13@jugem.jp');

insert into category (id, name) values (1, 'Healthy');
insert into category (id, name) values (2, 'Convenient');
insert into category (id, name) values (3, 'Seafood');
insert into category (id, name) values (4, 'Poultry');
insert into category (id, name) values (5, 'Vegetables');
insert into category (id, name) values (6, 'Fruit');
insert into category (id, name) values (7, 'Farm Fresh');
insert into category (id, name) values (8, 'Bakery');

insert into driver (id, first_name, last_name, vehicle_type) values (1, 'Rooney', 'Benettelli', 'Motorcycle');
insert into driver (id, first_name, last_name, vehicle_type) values (2, 'Coretta', 'Slobom', 'Motorcycle');
insert into driver (id, first_name, last_name, vehicle_type) values (3, 'Alard', 'Peeke-Vout', 'Motorcycle');
insert into driver (id, first_name, last_name, vehicle_type) values (4, 'Zorah', 'D''Elia', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (5, 'Margaux', 'Tiesman', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (6, 'Melamie', 'Itter', 'Truck');
insert into driver (id, first_name, last_name, vehicle_type) values (7, 'Estella', 'Sollime', 'Motorcycle');
insert into driver (id, first_name, last_name, vehicle_type) values (8, 'Sissy', 'Nortcliffe', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (9, 'Birdie', 'Cremins', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (10, 'Shauna', 'Craise', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (11, 'Ogdon', 'Hoggan', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (12, 'Heddie', 'Avory', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (13, 'Raul', 'Ballham', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (14, 'Heddie', 'Tilberry', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (15, 'Roda', 'Bales', 'Motorcycle');
insert into driver (id, first_name, last_name, vehicle_type) values (16, 'Koressa', 'McGillacoell', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (17, 'Glenda', 'Borzoni', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (18, 'Enrika', 'MacFie', 'Truck');
insert into driver (id, first_name, last_name, vehicle_type) values (19, 'Adlai', 'Jimson', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (20, 'William', 'Chicken', 'Motorcycle');
insert into driver (id, first_name, last_name, vehicle_type) values (21, 'Nertie', 'Auchterlony', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (22, 'Kalinda', 'De la Perrelle', 'Motorcycle');
insert into driver (id, first_name, last_name, vehicle_type) values (23, 'Roseanna', 'Steljes', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (24, 'Noelle', 'Kenefick', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (25, 'Heloise', 'De Beneditti', 'Truck');
insert into driver (id, first_name, last_name, vehicle_type) values (26, 'Abagail', 'Strivens', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (27, 'Brittne', 'Reedie', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (28, 'Emmey', 'Dawidman', 'Motorcycle');
insert into driver (id, first_name, last_name, vehicle_type) values (29, 'Dagmar', 'Walesa', 'Truck');
insert into driver (id, first_name, last_name, vehicle_type) values (30, 'Jillie', 'Imlach', 'Truck');
insert into driver (id, first_name, last_name, vehicle_type) values (31, 'Druci', 'Lumber', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (32, 'Fredek', 'Artiss', 'Truck');
insert into driver (id, first_name, last_name, vehicle_type) values (33, 'Shell', 'Welbelove', 'Truck');
insert into driver (id, first_name, last_name, vehicle_type) values (34, 'Helyn', 'Lau', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (35, 'Gaye', 'Gambell', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (36, 'Felita', 'Runciman', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (37, 'Aretha', 'Sealeaf', 'Motorcycle');
insert into driver (id, first_name, last_name, vehicle_type) values (38, 'Belva', 'Severn', 'Bike');
insert into driver (id, first_name, last_name, vehicle_type) values (39, 'Von', 'Worthing', 'Car');
insert into driver (id, first_name, last_name, vehicle_type) values (40, 'Keene', 'Helling', 'Truck');

insert into store (id, name, phone) values (1, 'Wilkinson Group', '1993446090');
insert into store (id, name, phone) values (2, 'Runolfsdottir and Sons', '3038330132');
insert into store (id, name, phone) values (3, 'Ledner-Fisher', '1667909640');
insert into store (id, name, phone) values (4, 'Smitham-Wolff', '4493442290');
insert into store (id, name, phone) values (5, 'Robel-Stoltenberg', '1325371388');
insert into store (id, name, phone) values (6, 'Kovacek Group', '5248918845');
insert into store (id, name, phone) values (7, 'Monahan, Rippin and Cassin', '1078475708');
insert into store (id, name, phone) values (8, 'Pfannerstill-Hickle', '2954391728');
insert into store (id, name, phone) values (9, 'McClure LLC', '8666160560');
insert into store (id, name, phone) values (10, 'Hammes-Orn', '2122229297');
insert into store (id, name, phone) values (11, 'Bauch LLC', '1718440174');
insert into store (id, name, phone) values (12, 'Muller, Mertz and Ferry', '1861404640');
insert into store (id, name, phone) values (13, 'Bednar-Ruecker', '3019342608');
insert into store (id, name, phone) values (14, 'Christiansen, West and Adams', '7802865425');
insert into store (id, name, phone) values (15, 'Fadel LLC', '9107204503');
insert into store (id, name, phone) values (16, 'Jast, Jast and Stokes', '8507377355');
insert into store (id, name, phone) values (17, 'McDermott-Kunze', '2495611562');
insert into store (id, name, phone) values (18, 'Runolfsdottir Group', '9655834919');
insert into store (id, name, phone) values (19, 'Howe-Howe', '2243136658');
insert into store (id, name, phone) values (20, 'Blanda, Crooks and Kuhlman', '7852432784');
insert into store (id, name, phone) values (21, 'Walsh, Kub and Tromp', '1334925606');
insert into store (id, name, phone) values (22, 'Murazik Inc', '4287164818');
insert into store (id, name, phone) values (23, 'Weissnat, Klocko and Yundt', '2705071069');
insert into store (id, name, phone) values (24, 'Harris Inc', '1574834037');
insert into store (id, name, phone) values (25, 'Walker LLC', '1783583240');
insert into store (id, name, phone) values (26, 'Mertz, Goyette and Buckridge', '2549932010');
insert into store (id, name, phone) values (27, 'Macejkovic-Schultz', '9441724220');
insert into store (id, name, phone) values (28, 'Macejkovic LLC', '7077578729');
insert into store (id, name, phone) values (29, 'Upton-Swaniawski', '7517266029');
insert into store (id, name, phone) values (30, 'Barrows, Altenwerth and Kozey', '9771696756');
insert into store (id, name, phone) values (31, 'Watsica-VonRueden', '1186294592');
insert into store (id, name, phone) values (32, 'Berge Inc', '4008555476');
insert into store (id, name, phone) values (33, 'Rosenbaum-Wilkinson', '8903481597');
insert into store (id, name, phone) values (34, 'Borer and Sons', '3073379419');
insert into store (id, name, phone) values (35, 'Weber and Sons', '7594494459');

insert into product (id, name, units_in_stock, price, store_id, category_id) values (1, 'Cheese - Comte', 28, 778.57, '4', '8');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (2, 'Pasta - Lasagna, Dry', 5, 418.35, '28', '4');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (3, 'Oats Large Flake', 81, 1270.08, '5', '6');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (4, 'Muffin Mix - Oatmeal', 68, 622.35, '7', '3');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (5, 'Tea - Orange Pekoe', 7, 746.56, '13', '5');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (6, 'Squid U5 - Thailand', 61, 1599.43, '18', '1');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (7, 'Capon - Breast, Wing On', 95, 1061.55, '35', '2');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (8, 'Wine - Penfolds Koonuga Hill', 41, 509.03, '16', '7');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (9, 'Cheese - Victor Et Berthold', 24, 1442.38, '1', '6');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (10, 'Pepper - Julienne, Frozen', 86, 1725.18, '11', '2');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (11, 'Ice Cream - Life Savers', 59, 1711.14, '25', '3');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (12, 'Crab - Dungeness, Whole, live', 97, 354.18, '29', '7');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (13, 'Wine - White, Cooking', 50, 1746.46, '22', '4');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (14, 'Pepper - Orange', 2, 561.66, '34', '5');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (15, 'Asparagus - Mexican', 57, 383.07, '20', '8');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (16, 'Lettuce - Belgian Endive', 66, 671.55, '2', '1');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (17, 'Sugar - Crumb', 59, 1098.89, '32', '4');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (18, 'Nut - Pecan, Pieces', 42, 1374.82, '23', '1');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (19, 'Chocolate - Sugar Free Semi Choc', 98, 783.26, '33', '2');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (20, 'Appetizer - Crab And Brie', 58, 1217.72, '6', '5');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (21, 'Beef - Top Sirloin', 48, 1292.77, '30', '6');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (22, 'Bread Country Roll', 80, 1668.0, '17', '3');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (23, 'Beer - Alexander Kieths, Pale Ale', 23, 1106.89, '19', '7');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (24, 'Sauce - Fish 25 Ozf Bottle', 18, 1703.07, '10', '8');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (25, 'Creme De Banane - Marie', 60, 565.35, '27', '8');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (26, 'Shrimp - 16/20, Peeled Deviened', 60, 1765.22, '24', '7');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (27, 'Puff Pastry - Sheets', 60, 1082.88, '3', '2');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (28, 'Juice - Prune', 47, 536.22, '15', '6');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (29, 'Wine - Chablis 2003 Champs', 77, 224.77, '8', '3');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (30, 'Stock - Veal, White', 51, 1626.37, '14', '5');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (31, 'Chilli Paste, Ginger Garlic', 87, 1619.51, '31', '1');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (32, 'Wine - Casablanca Valley', 53, 202.92, '12', '4');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (33, 'Rum - White, Gg White', 83, 495.37, '9', '6');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (34, 'Bagel - Ched Chs Presliced', 48, 1598.5, '21', '2');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (35, 'Tart Shells - Sweet, 4', 74, 390.26, '26', '3');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (36, 'Lentils - Red, Dry', 59, 548.62, '29', '5');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (37, 'Paper - Brown Paper Mini Cups', 44, 1762.5, '27', '7');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (38, 'Schnappes Peppermint - Walker', 6, 1406.27, '21', '1');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (39, 'Sauce - Chili', 53, 215.43, '5', '8');
insert into product (id, name, units_in_stock, price, store_id, category_id) values (40, 'Oil - Sunflower', 85, 1873.37, '25', '4');

insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (1, '2024-01-29', '2024-07-07', '44 Comanche Trail', '64 Chive Center', '10', '11', 23);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (2, '2024-05-18', '2024-07-16', '31099 Memorial Way', '0969 Iowa Parkway', '8', '33', 5);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (3, '2024-05-30', '2023-08-22', '3362 Manley Crossing', '92 Wayridge Way', '34', '2', 14);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (4, '2024-01-27', '2024-03-21', '6459 Summer Ridge Crossing', '154 Artisan Road', '2', '7', 3);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (5, '2024-07-28', '2024-02-23', '5446 Helena Terrace', '8290 Esch Point', '19', '9', 6);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (6, '2024-07-03', '2024-07-14', '15 Oxford Avenue', '9580 Holmberg Lane', '25', '29', 32);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (7, '2024-02-12', '2023-11-25', '1218 Luster Park', '3087 Dryden Trail', '35', '5', 34);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (8, '2024-04-03', '2024-01-25', '89 Walton Parkway', '5002 Lyons Terrace', '13', '27', 31);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (9, '2024-04-29', '2024-01-10', '13 Hoepker Point', '10619 Arkansas Center', '28', '13', 37);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (10, '2024-07-14', '2023-12-07', '1672 Meadow Vale Drive', '21593 Carberry Drive', '20', '31', 12);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (11, '2023-10-31', '2024-03-02', '33747 Ridgeview Way', '91 Park Meadow Circle', '1', '10', 22);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (12, '2023-09-28', '2024-04-24', '5064 Towne Avenue', '2588 Forest Run Center', '27', '4', 36);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (13, '2024-01-25', '2024-02-21', '71838 Aberg Terrace', '8 Susan Park', '32', '24', 39);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (14, '2024-06-29', '2023-12-25', '96 Pearson Center', '1 Morning Road', '6', '30', 38);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (15, '2024-07-11', '2023-09-03', '92 Hoepker Junction', '3418 Dawn Court', '4', '8', 9);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (16, '2024-02-10', '2023-08-14', '28 Namekagon Road', '37 Sauthoff Way', '26', '17', 28);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (17, '2024-02-04', '2024-04-18', '3 Carey Hill', '44991 Briar Crest Way', '17', '35', 25);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (18, '2024-03-22', '2024-03-16', '968 Huxley Road', '47685 Mayer Avenue', '23', '21', 18);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (19, '2024-05-03', '2024-06-08', '50 Monument Circle', '86875 Northview Point', '11', '28', 24);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (20, '2024-02-14', '2023-10-20', '94 Dakota Park', '173 Evergreen Court', '29', '23', 20);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (21, '2023-11-17', '2023-09-22', '32122 Vermont Crossing', '27220 Charing Cross Drive', '3', '22', 16);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (22, '2024-07-14', '2024-06-27', '2 Clarendon Circle', '09789 Coolidge Parkway', '24', '18', 11);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (23, '2023-08-13', '2024-05-13', '76 Autumn Leaf Point', '718 Forest Dale Road', '16', '32', 30);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (24, '2024-05-22', '2024-08-12', '0520 Swallow Way', '4 Fairfield Place', '12', '14', 40);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (25, '2024-01-21', '2024-01-11', '7779 Cordelia Road', '0 Shopko Avenue', '9', '34', 4);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (26, '2024-04-08', '2023-09-11', '874 Starling Circle', '6 Vidon Road', '15', '16', 2);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (27, '2024-02-05', '2023-11-26', '53966 Spohn Alley', '4 Novick Court', '18', '25', 26);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (28, '2024-04-09', '2024-01-20', '25 Swallow Drive', '5 Bluejay Road', '7', '26', 27);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (29, '2024-03-01', '2024-03-05', '47605 Gerald Junction', '06039 Center Parkway', '31', '12', 35);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (30, '2024-01-17', '2024-06-21', '693 Spaight Drive', '00 Maple Wood Center', '14', '19', 1);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (31, '2024-02-12', '2024-06-20', '39579 Crowley Point', '10 Monument Circle', '30', '6', 33);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (32, '2024-03-07', '2023-11-10', '0 Forster Road', '963 Elgar Drive', '21', '15', 13);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (33, '2023-09-17', '2024-01-01', '6 Spenser Road', '33205 Ohio Pass', '5', '1', 21);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (34, '2024-03-22', '2024-07-13', '2097 Claremont Junction', '91 Dawn Lane', '33', '3', 19);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (35, '2024-08-01', '2024-06-13', '66 Hovde Court', '699 Pearson Street', '22', '20', 29);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (36, '2024-03-19', '2023-10-10', '96137 Hooker Center', '54384 Bunting Plaza', '7', '24', 7);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (37, '2023-11-07', '2024-07-22', '7622 Lakewood Gardens Hill', '99 Dovetail Place', '23', '9', 17);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (38, '2023-11-26', '2023-10-06', '989 Mallard Court', '8856 Coolidge Point', '25', '19', 15);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (39, '2024-07-06', '2023-10-01', '2824 Jay Pass', '24 Sheridan Terrace', '27', '21', 8);
insert into orders (id, time_created, time_fulfilled, pickup_address, delivery_address, customer_id, store_id, driver_id) values (40, '2024-02-22', '2024-06-27', '7 Raven Hill', '1 Northport Lane', '34', '1', 10);

insert into analyst_orders (analyst_id, orders_id) values (40, '36');
insert into analyst_orders (analyst_id, orders_id) values (4, '29');
insert into analyst_orders (analyst_id, orders_id) values (36, '22');
insert into analyst_orders (analyst_id, orders_id) values (28, '40');
insert into analyst_orders (analyst_id, orders_id) values (15, '5');
insert into analyst_orders (analyst_id, orders_id) values (16, '34');
insert into analyst_orders (analyst_id, orders_id) values (21, '4');
insert into analyst_orders (analyst_id, orders_id) values (30, '30');
insert into analyst_orders (analyst_id, orders_id) values (32, '28');
insert into analyst_orders (analyst_id, orders_id) values (39, '10');
insert into analyst_orders (analyst_id, orders_id) values (12, '21');
insert into analyst_orders (analyst_id, orders_id) values (6, '38');
insert into analyst_orders (analyst_id, orders_id) values (11, '26');
insert into analyst_orders (analyst_id, orders_id) values (22, '17');
insert into analyst_orders (analyst_id, orders_id) values (13, '37');
insert into analyst_orders (analyst_id, orders_id) values (7, '27');
insert into analyst_orders (analyst_id, orders_id) values (2, '20');
insert into analyst_orders (analyst_id, orders_id) values (37, '32');
insert into analyst_orders (analyst_id, orders_id) values (34, '6');
insert into analyst_orders (analyst_id, orders_id) values (25, '39');
insert into analyst_orders (analyst_id, orders_id) values (38, '11');
insert into analyst_orders (analyst_id, orders_id) values (14, '8');
insert into analyst_orders (analyst_id, orders_id) values (26, '15');
insert into analyst_orders (analyst_id, orders_id) values (8, '2');
insert into analyst_orders (analyst_id, orders_id) values (19, '23');
insert into analyst_orders (analyst_id, orders_id) values (17, '33');
insert into analyst_orders (analyst_id, orders_id) values (18, '12');
insert into analyst_orders (analyst_id, orders_id) values (10, '16');
insert into analyst_orders (analyst_id, orders_id) values (20, '1');
insert into analyst_orders (analyst_id, orders_id) values (27, '31');
insert into analyst_orders (analyst_id, orders_id) values (31, '7');
insert into analyst_orders (analyst_id, orders_id) values (5, '25');
insert into analyst_orders (analyst_id, orders_id) values (23, '9');
insert into analyst_orders (analyst_id, orders_id) values (33, '18');
insert into analyst_orders (analyst_id, orders_id) values (1, '35');
insert into analyst_orders (analyst_id, orders_id) values (3, '19');
insert into analyst_orders (analyst_id, orders_id) values (29, '24');
insert into analyst_orders (analyst_id, orders_id) values (9, '3');
insert into analyst_orders (analyst_id, orders_id) values (24, '14');
insert into analyst_orders (analyst_id, orders_id) values (35, '13');
insert into analyst_orders (analyst_id, orders_id) values (24, '12');
insert into analyst_orders (analyst_id, orders_id) values (18, '27');
insert into analyst_orders (analyst_id, orders_id) values (19, '34');
insert into analyst_orders (analyst_id, orders_id) values (26, '10');
insert into analyst_orders (analyst_id, orders_id) values (23, '16');
insert into analyst_orders (analyst_id, orders_id) values (34, '5');
insert into analyst_orders (analyst_id, orders_id) values (10, '19');
insert into analyst_orders (analyst_id, orders_id) values (27, '32');
insert into analyst_orders (analyst_id, orders_id) values (15, '17');
insert into analyst_orders (analyst_id, orders_id) values (16, '24');
insert into analyst_orders (analyst_id, orders_id) values (11, '31');
insert into analyst_orders (analyst_id, orders_id) values (39, '22');
insert into analyst_orders (analyst_id, orders_id) values (2, '26');
insert into analyst_orders (analyst_id, orders_id) values (9, '6');
insert into analyst_orders (analyst_id, orders_id) values (20, '23');
insert into analyst_orders (analyst_id, orders_id) values (7, '11');
insert into analyst_orders (analyst_id, orders_id) values (5, '33');
insert into analyst_orders (analyst_id, orders_id) values (33, '3');
insert into analyst_orders (analyst_id, orders_id) values (22, '25');
insert into analyst_orders (analyst_id, orders_id) values (29, '38');
insert into analyst_orders (analyst_id, orders_id) values (31, '9');
insert into analyst_orders (analyst_id, orders_id) values (6, '7');
insert into analyst_orders (analyst_id, orders_id) values (38, '36');
insert into analyst_orders (analyst_id, orders_id) values (21, '37');
insert into analyst_orders (analyst_id, orders_id) values (40, '28');
insert into analyst_orders (analyst_id, orders_id) values (35, '30');
insert into analyst_orders (analyst_id, orders_id) values (17, '35');
insert into analyst_orders (analyst_id, orders_id) values (36, '20');
insert into analyst_orders (analyst_id, orders_id) values (1, '4');
insert into analyst_orders (analyst_id, orders_id) values (25, '8');
insert into analyst_orders (analyst_id, orders_id) values (12, '18');
insert into analyst_orders (analyst_id, orders_id) values (32, '21');
insert into analyst_orders (analyst_id, orders_id) values (14, '1');
insert into analyst_orders (analyst_id, orders_id) values (3, '14');
insert into analyst_orders (analyst_id, orders_id) values (30, '39');
insert into analyst_orders (analyst_id, orders_id) values (37, '15');
insert into analyst_orders (analyst_id, orders_id) values (13, '13');
insert into analyst_orders (analyst_id, orders_id) values (32, '14');
insert into analyst_orders (analyst_id, orders_id) values (5, '12');
insert into analyst_orders (analyst_id, orders_id) values (16, '17');
insert into analyst_orders (analyst_id, orders_id) values (3, '7');
insert into analyst_orders (analyst_id, orders_id) values (23, '21');
insert into analyst_orders (analyst_id, orders_id) values (19, '15');
insert into analyst_orders (analyst_id, orders_id) values (14, '11');
insert into analyst_orders (analyst_id, orders_id) values (22, '37');
insert into analyst_orders (analyst_id, orders_id) values (30, '25');
insert into analyst_orders (analyst_id, orders_id) values (25, '4');
insert into analyst_orders (analyst_id, orders_id) values (17, '27');
insert into analyst_orders (analyst_id, orders_id) values (39, '5');
insert into analyst_orders (analyst_id, orders_id) values (15, '33');
insert into analyst_orders (analyst_id, orders_id) values (35, '1');
insert into analyst_orders (analyst_id, orders_id) values (40, '9');
insert into analyst_orders (analyst_id, orders_id) values (27, '26');
insert into analyst_orders (analyst_id, orders_id) values (12, '13');
insert into analyst_orders (analyst_id, orders_id) values (9, '32');
insert into analyst_orders (analyst_id, orders_id) values (29, '8');
insert into analyst_orders (analyst_id, orders_id) values (7, '24');

insert into customer_addresses (id, address) values ('16', '894 Morningstar Drive');
insert into customer_addresses (id, address) values ('26', '59 Amoth Terrace');
insert into customer_addresses (id, address) values ('8', '511 Lukken Plaza');
insert into customer_addresses (id, address) values ('2', '3886 Rigney Drive');
insert into customer_addresses (id, address) values ('32', '64 Pond Point');
insert into customer_addresses (id, address) values ('30', '327 Melrose Street');
insert into customer_addresses (id, address) values ('27', '7803 South Plaza');
insert into customer_addresses (id, address) values ('21', '9 Parkside Trail');
insert into customer_addresses (id, address) values ('17', '833 Logan Crossing');
insert into customer_addresses (id, address) values ('22', '53852 Mayer Center');
insert into customer_addresses (id, address) values ('4', '2151 Algoma Place');
insert into customer_addresses (id, address) values ('33', '77718 Old Gate Terrace');
insert into customer_addresses (id, address) values ('12', '9677 Kennedy Road');
insert into customer_addresses (id, address) values ('5', '09 Hansons Court');
insert into customer_addresses (id, address) values ('35', '329 Briar Crest Lane');
insert into customer_addresses (id, address) values ('31', '662 Pankratz Junction');
insert into customer_addresses (id, address) values ('10', '7 Amoth Park');
insert into customer_addresses (id, address) values ('24', '4 Loomis Lane');
insert into customer_addresses (id, address) values ('13', '93054 Onsgard Way');
insert into customer_addresses (id, address) values ('23', '182 1st Pass');
insert into customer_addresses (id, address) values ('14', '59425 Buhler Street');
insert into customer_addresses (id, address) values ('28', '54 Thompson Plaza');
insert into customer_addresses (id, address) values ('11', '34 Troy Road');
insert into customer_addresses (id, address) values ('20', '5112 Dayton Alley');
insert into customer_addresses (id, address) values ('6', '22 Valley Edge Center');
insert into customer_addresses (id, address) values ('1', '3 Waubesa Place');
insert into customer_addresses (id, address) values ('25', '7592 Gulseth Alley');
insert into customer_addresses (id, address) values ('9', '14404 Hoepker Terrace');
insert into customer_addresses (id, address) values ('34', '3 Debra Junction');
insert into customer_addresses (id, address) values ('7', '6570 Loftsgordon Park');
insert into customer_addresses (id, address) values ('29', '337 Morrow Lane');
insert into customer_addresses (id, address) values ('18', '878 Kinsman Avenue');
insert into customer_addresses (id, address) values ('19', '269 Doe Crossing Street');
insert into customer_addresses (id, address) values ('15', '52162 Pleasure Lane');
insert into customer_addresses (id, address) values ('3', '87 Oak Valley Road');
insert into customer_addresses (id, address) values ('15', '76206 Leroy Circle');
insert into customer_addresses (id, address) values ('28', '0663 Weeping Birch Plaza');
insert into customer_addresses (id, address) values ('29', '34843 Aberg Drive');
insert into customer_addresses (id, address) values ('35', '4 8th Crossing');
insert into customer_addresses (id, address) values ('14', '5 Dawn Court');
insert into customer_addresses (id, address) values ('9', '40209 Maple Wood Plaza');
insert into customer_addresses (id, address) values ('3', '96911 Utah Parkway');
insert into customer_addresses (id, address) values ('11', '135 Kenwood Plaza');
insert into customer_addresses (id, address) values ('4', '12640 Shasta Hill');
insert into customer_addresses (id, address) values ('33', '1 Myrtle Trail');
insert into customer_addresses (id, address) values ('21', '6 Fairview Trail');
insert into customer_addresses (id, address) values ('10', '4897 Buena Vista Point');
insert into customer_addresses (id, address) values ('31', '00 Sycamore Hill');
insert into customer_addresses (id, address) values ('7', '13547 Menomonie Avenue');
insert into customer_addresses (id, address) values ('1', '9 Corscot Pass');
insert into customer_addresses (id, address) values ('2', '83 Eagan Crossing');
insert into customer_addresses (id, address) values ('22', '0014 Eagan Pass');
insert into customer_addresses (id, address) values ('12', '591 Basil Trail');
insert into customer_addresses (id, address) values ('30', '3127 Fairview Trail');
insert into customer_addresses (id, address) values ('13', '1 Vernon Avenue');
insert into customer_addresses (id, address) values ('23', '0 Meadow Valley Crossing');
insert into customer_addresses (id, address) values ('16', '0488 Roxbury Junction');
insert into customer_addresses (id, address) values ('18', '3556 Kipling Court');
insert into customer_addresses (id, address) values ('17', '516 Mifflin Hill');
insert into customer_addresses (id, address) values ('20', '062 Merrick Avenue');
insert into customer_addresses (id, address) values ('6', '21989 Waywood Point');
insert into customer_addresses (id, address) values ('27', '31 Towne Terrace');
insert into customer_addresses (id, address) values ('26', '49 Armistice Court');
insert into customer_addresses (id, address) values ('8', '264 East Parkway');
insert into customer_addresses (id, address) values ('24', '7 High Crossing Place');
insert into customer_addresses (id, address) values ('5', '92616 Amoth Parkway');
insert into customer_addresses (id, address) values ('19', '0449 Walton Alley');
insert into customer_addresses (id, address) values ('34', '241 Kingsford Park');
insert into customer_addresses (id, address) values ('25', '909 Farwell Way');
insert into customer_addresses (id, address) values ('32', '5451 Di Loreto Road');

insert into orders_product (orders_id, product_id, quantity) values ('25', '12', 22);
insert into orders_product (orders_id, product_id, quantity) values ('1', '25', 42);
insert into orders_product (orders_id, product_id, quantity) values ('5', '31', 22);
insert into orders_product (orders_id, product_id, quantity) values ('30', '27', 5);
insert into orders_product (orders_id, product_id, quantity) values ('31', '7', 27);
insert into orders_product (orders_id, product_id, quantity) values ('23', '22', 30);
insert into orders_product (orders_id, product_id, quantity) values ('24', '26', 7);
insert into orders_product (orders_id, product_id, quantity) values ('3', '33', 11);
insert into orders_product (orders_id, product_id, quantity) values ('34', '6', 2);
insert into orders_product (orders_id, product_id, quantity) values ('16', '32', 47);
insert into orders_product (orders_id, product_id, quantity) values ('10', '14', 38);
insert into orders_product (orders_id, product_id, quantity) values ('14', '1', 36);
insert into orders_product (orders_id, product_id, quantity) values ('2', '8', 15);
insert into orders_product (orders_id, product_id, quantity) values ('37', '10', 47);
insert into orders_product (orders_id, product_id, quantity) values ('19', '3', 27);
insert into orders_product (orders_id, product_id, quantity) values ('29', '21', 18);
insert into orders_product (orders_id, product_id, quantity) values ('12', '37', 6);
insert into orders_product (orders_id, product_id, quantity) values ('35', '39', 24);
insert into orders_product (orders_id, product_id, quantity) values ('22', '24', 27);
insert into orders_product (orders_id, product_id, quantity) values ('33', '15', 20);
insert into orders_product (orders_id, product_id, quantity) values ('11', '36', 19);
insert into orders_product (orders_id, product_id, quantity) values ('13', '38', 12);
insert into orders_product (orders_id, product_id, quantity) values ('21', '20', 50);
insert into orders_product (orders_id, product_id, quantity) values ('36', '4', 22);
insert into orders_product (orders_id, product_id, quantity) values ('32', '30', 11);
insert into orders_product (orders_id, product_id, quantity) values ('7', '5', 35);
insert into orders_product (orders_id, product_id, quantity) values ('17', '13', 27);
insert into orders_product (orders_id, product_id, quantity) values ('20', '18', 24);
insert into orders_product (orders_id, product_id, quantity) values ('26', '2', 17);
insert into orders_product (orders_id, product_id, quantity) values ('6', '29', 30);
insert into orders_product (orders_id, product_id, quantity) values ('9', '35', 35);
insert into orders_product (orders_id, product_id, quantity) values ('38', '23', 5);
insert into orders_product (orders_id, product_id, quantity) values ('28', '11', 2);
insert into orders_product (orders_id, product_id, quantity) values ('40', '40', 18);
insert into orders_product (orders_id, product_id, quantity) values ('39', '28', 34);
insert into orders_product (orders_id, product_id, quantity) values ('4', '9', 37);
insert into orders_product (orders_id, product_id, quantity) values ('15', '34', 20);
insert into orders_product (orders_id, product_id, quantity) values ('8', '16', 4);
insert into orders_product (orders_id, product_id, quantity) values ('18', '17', 40);
insert into orders_product (orders_id, product_id, quantity) values ('27', '19', 9);
insert into orders_product (orders_id, product_id, quantity) values ('8', '6', 13);
insert into orders_product (orders_id, product_id, quantity) values ('13', '21', 41);
insert into orders_product (orders_id, product_id, quantity) values ('18', '7', 30);
insert into orders_product (orders_id, product_id, quantity) values ('17', '18', 15);
insert into orders_product (orders_id, product_id, quantity) values ('23', '26', 2);
insert into orders_product (orders_id, product_id, quantity) values ('28', '12', 6);
insert into orders_product (orders_id, product_id, quantity) values ('20', '10', 42);
insert into orders_product (orders_id, product_id, quantity) values ('12', '39', 21);
insert into orders_product (orders_id, product_id, quantity) values ('5', '29', 5);
insert into orders_product (orders_id, product_id, quantity) values ('26', '20', 5);
insert into orders_product (orders_id, product_id, quantity) values ('3', '2', 8);
insert into orders_product (orders_id, product_id, quantity) values ('9', '13', 10);
insert into orders_product (orders_id, product_id, quantity) values ('15', '37', 29);
insert into orders_product (orders_id, product_id, quantity) values ('27', '22', 49);
insert into orders_product (orders_id, product_id, quantity) values ('22', '33', 20);
insert into orders_product (orders_id, product_id, quantity) values ('33', '35', 50);
insert into orders_product (orders_id, product_id, quantity) values ('29', '38', 46);
insert into orders_product (orders_id, product_id, quantity) values ('25', '16', 44);
insert into orders_product (orders_id, product_id, quantity) values ('11', '8', 7);
insert into orders_product (orders_id, product_id, quantity) values ('21', '5', 21);
insert into orders_product (orders_id, product_id, quantity) values ('37', '19', 17);
insert into orders_product (orders_id, product_id, quantity) values ('36', '23', 16);
insert into orders_product (orders_id, product_id, quantity) values ('30', '3', 47);
insert into orders_product (orders_id, product_id, quantity) values ('38', '31', 18);
insert into orders_product (orders_id, product_id, quantity) values ('6', '1', 20);
insert into orders_product (orders_id, product_id, quantity) values ('35', '25', 35);
insert into orders_product (orders_id, product_id, quantity) values ('34', '27', 39);
insert into orders_product (orders_id, product_id, quantity) values ('24', '36', 24);
insert into orders_product (orders_id, product_id, quantity) values ('2', '24', 45);
insert into orders_product (orders_id, product_id, quantity) values ('14', '17', 13);
insert into orders_product (orders_id, product_id, quantity) values ('39', '11', 13);
insert into orders_product (orders_id, product_id, quantity) values ('32', '34', 4);
insert into orders_product (orders_id, product_id, quantity) values ('1', '40', 16);
insert into orders_product (orders_id, product_id, quantity) values ('31', '30', 48);
insert into orders_product (orders_id, product_id, quantity) values ('19', '14', 45);
insert into orders_product (orders_id, product_id, quantity) values ('7', '15', 37);
insert into orders_product (orders_id, product_id, quantity) values ('40', '28', 1);
insert into orders_product (orders_id, product_id, quantity) values ('10', '4', 17);
insert into orders_product (orders_id, product_id, quantity) values ('11', '29', 3);
insert into orders_product (orders_id, product_id, quantity) values ('8', '15', 49);
insert into orders_product (orders_id, product_id, quantity) values ('17', '10', 21);
insert into orders_product (orders_id, product_id, quantity) values ('16', '1', 8);
insert into orders_product (orders_id, product_id, quantity) values ('5', '20', 23);
insert into orders_product (orders_id, product_id, quantity) values ('36', '2', 37);
insert into orders_product (orders_id, product_id, quantity) values ('14', '25', 39);
insert into orders_product (orders_id, product_id, quantity) values ('39', '33', 32);
insert into orders_product (orders_id, product_id, quantity) values ('9', '4', 2);
insert into orders_product (orders_id, product_id, quantity) values ('31', '40', 25);
insert into orders_product (orders_id, product_id, quantity) values ('32', '22', 21);
insert into orders_product (orders_id, product_id, quantity) values ('22', '13', 14);
insert into orders_product (orders_id, product_id, quantity) values ('35', '21', 44);
insert into orders_product (orders_id, product_id, quantity) values ('27', '36', 48);
insert into orders_product (orders_id, product_id, quantity) values ('25', '35', 31);
insert into orders_product (orders_id, product_id, quantity) values ('26', '9', 5);
insert into orders_product (orders_id, product_id, quantity) values ('2', '6', 34);
insert into orders_product (orders_id, product_id, quantity) values ('20', '12', 19);
insert into orders_product (orders_id, product_id, quantity) values ('28', '37', 36);
insert into orders_product (orders_id, product_id, quantity) values ('24', '17', 13);

insert into store_addresses (id, address) values ('9', '99870 Blaine Trail');
insert into store_addresses (id, address) values ('10', '7330 Hagan Trail');
insert into store_addresses (id, address) values ('23', '6196 Schurz Parkway');
insert into store_addresses (id, address) values ('26', '46 Lakewood Plaza');
insert into store_addresses (id, address) values ('6', '500 Cardinal Road');
insert into store_addresses (id, address) values ('35', '095 Fairfield Plaza');
insert into store_addresses (id, address) values ('28', '48929 Birchwood Park');
insert into store_addresses (id, address) values ('31', '8835 New Castle Lane');
insert into store_addresses (id, address) values ('25', '76 Northland Circle');
insert into store_addresses (id, address) values ('19', '569 David Pass');
insert into store_addresses (id, address) values ('33', '5 Laurel Center');
insert into store_addresses (id, address) values ('34', '6 Cody Trail');
insert into store_addresses (id, address) values ('27', '4534 Chinook Park');
insert into store_addresses (id, address) values ('24', '3323 Hanover Road');
insert into store_addresses (id, address) values ('20', '8959 Arrowood Center');
insert into store_addresses (id, address) values ('8', '0462 Hoard Avenue');
insert into store_addresses (id, address) values ('16', '9132 Erie Way');
insert into store_addresses (id, address) values ('1', '5571 Crownhardt Crossing');
insert into store_addresses (id, address) values ('21', '7465 Golf View Alley');
insert into store_addresses (id, address) values ('14', '04 Lighthouse Bay Park');
insert into store_addresses (id, address) values ('29', '3994 Morning Drive');
insert into store_addresses (id, address) values ('5', '164 Thierer Court');
insert into store_addresses (id, address) values ('30', '83 Nancy Court');
insert into store_addresses (id, address) values ('12', '7 Pond Plaza');
insert into store_addresses (id, address) values ('32', '090 Dahle Alley');
insert into store_addresses (id, address) values ('4', '0 Hazelcrest Road');
insert into store_addresses (id, address) values ('7', '88 Mallard Point');
insert into store_addresses (id, address) values ('13', '8900 Butternut Way');
insert into store_addresses (id, address) values ('18', '86 Green Ridge Parkway');
insert into store_addresses (id, address) values ('3', '19284 8th Terrace');
insert into store_addresses (id, address) values ('11', '0266 Monument Circle');
insert into store_addresses (id, address) values ('15', '1819 Brown Way');
insert into store_addresses (id, address) values ('2', '5 Florence Point');
insert into store_addresses (id, address) values ('22', '5 Derek Plaza');
insert into store_addresses (id, address) values ('17', '42494 Corscot Trail');
insert into store_addresses (id, address) values ('18', '827 Manley Pass');
insert into store_addresses (id, address) values ('7', '41226 8th Crossing');
insert into store_addresses (id, address) values ('12', '1723 Garrison Drive');
insert into store_addresses (id, address) values ('8', '0 Pierstorff Road');
insert into store_addresses (id, address) values ('24', '73090 Westend Lane');
insert into store_addresses (id, address) values ('15', '3 Nova Alley');
insert into store_addresses (id, address) values ('26', '5878 Londonderry Street');
insert into store_addresses (id, address) values ('20', '00 Eggendart Trail');
insert into store_addresses (id, address) values ('5', '26 Darwin Hill');
insert into store_addresses (id, address) values ('10', '73 Killdeer Point');
insert into store_addresses (id, address) values ('14', '240 Jenna Street');
insert into store_addresses (id, address) values ('29', '6 Mayer Way');
insert into store_addresses (id, address) values ('35', '628 Scofield Way');
insert into store_addresses (id, address) values ('27', '71181 Myrtle Court');
insert into store_addresses (id, address) values ('11', '1 Maryland Park');
insert into store_addresses (id, address) values ('2', '77555 Golf Course Plaza');
insert into store_addresses (id, address) values ('25', '447 Evergreen Plaza');
insert into store_addresses (id, address) values ('13', '813 Randy Parkway');
insert into store_addresses (id, address) values ('3', '622 Alpine Pass');
insert into store_addresses (id, address) values ('31', '94 Darwin Court');
insert into store_addresses (id, address) values ('33', '5128 Scofield Pass');
insert into store_addresses (id, address) values ('21', '5258 Claremont Park');
insert into store_addresses (id, address) values ('30', '106 Buell Road');
insert into store_addresses (id, address) values ('34', '572 Sachs Junction');
insert into store_addresses (id, address) values ('22', '86273 Northridge Alley');
insert into store_addresses (id, address) values ('9', '5 Forest Dale Road');
insert into store_addresses (id, address) values ('6', '24 Carberry Trail');
insert into store_addresses (id, address) values ('28', '3110 Southridge Road');
insert into store_addresses (id, address) values ('1', '036 Gale Circle');
insert into store_addresses (id, address) values ('23', '972 Dapin Avenue');
insert into store_addresses (id, address) values ('16', '89 Anniversary Road');
insert into store_addresses (id, address) values ('4', '840 Lillian Street');
insert into store_addresses (id, address) values ('32', '481 Rusk Park');
insert into store_addresses (id, address) values ('17', '05405 Grayhawk Terrace');
insert into store_addresses (id, address) values ('19', '8728 Homewood Alley');
insert into store_addresses (id, address) values ('29', '16284 Dixon Alley');
insert into store_addresses (id, address) values ('3', '886 Heffernan Place');
insert into store_addresses (id, address) values ('31', '46 Granby Center');
insert into store_addresses (id, address) values ('12', '26 Buhler Street');
insert into store_addresses (id, address) values ('10', '39 Riverside Lane');
insert into store_addresses (id, address) values ('5', '21 Old Gate Place');
insert into store_addresses (id, address) values ('17', '5317 Ohio Park');
insert into store_addresses (id, address) values ('23', '38 Blue Bill Park Pass');
insert into store_addresses (id, address) values ('2', '44248 Lukken Court');
insert into store_addresses (id, address) values ('24', '802 Mitchell Terrace');
insert into store_addresses (id, address) values ('14', '47366 Scoville Way');
insert into store_addresses (id, address) values ('16', '0244 Center Pass');
insert into store_addresses (id, address) values ('25', '99 Debs Drive');
insert into store_addresses (id, address) values ('7', '9515 Reindahl Street');
insert into store_addresses (id, address) values ('20', '55275 Farmco Lane');
insert into store_addresses (id, address) values ('13', '45 Emmet Drive');
insert into store_addresses (id, address) values ('19', '1768 Crescent Oaks Plaza');
insert into store_addresses (id, address) values ('9', '99 Meadow Valley Parkway');
insert into store_addresses (id, address) values ('32', '53859 Everett Drive');
insert into store_addresses (id, address) values ('28', '9447 Thierer Lane');
insert into store_addresses (id, address) values ('26', '297 Mccormick Street');
insert into store_addresses (id, address) values ('15', '64 Reinke Pass');
insert into store_addresses (id, address) values ('8', '74346 Cottonwood Hill');
insert into store_addresses (id, address) values ('34', '8179 La Follette Junction');
insert into store_addresses (id, address) values ('35', '50883 Maple Point');
insert into store_addresses (id, address) values ('33', '82999 South Pass');
insert into store_addresses (id, address) values ('21', '34055 East Crossing');
insert into store_addresses (id, address) values ('22', '93 Sunnyside Street');
insert into store_addresses (id, address) values ('30', '68 Jana Street');
insert into store_addresses (id, address) values ('4', '7 6th Lane');

insert into store_emails (id, email) values ('32', 'zbernardoni0@timesonline.co.uk');
insert into store_emails (id, email) values ('28', 'lhulance1@house.gov');
insert into store_emails (id, email) values ('14', 'gkilkenny2@bbc.co.uk');
insert into store_emails (id, email) values ('31', 'lbesnard3@4shared.com');
insert into store_emails (id, email) values ('13', 'tberan4@harvard.edu');
insert into store_emails (id, email) values ('21', 'lbaseggio5@geocities.com');
insert into store_emails (id, email) values ('11', 'bsturley6@princeton.edu');
insert into store_emails (id, email) values ('29', 'jbaggs7@wisc.edu');
insert into store_emails (id, email) values ('23', 'wzamorrano8@1688.com');
insert into store_emails (id, email) values ('20', 'tcumberledge9@canalblog.com');
insert into store_emails (id, email) values ('24', 'ckonertza@de.vu');
insert into store_emails (id, email) values ('3', 'bhendrenb@weather.com');
insert into store_emails (id, email) values ('9', 'kloughheadc@webeden.co.uk');
insert into store_emails (id, email) values ('27', 'tkorbd@microsoft.com');
insert into store_emails (id, email) values ('17', 'abogaerte@amazon.com');
insert into store_emails (id, email) values ('1', 'ctabernerf@miitbeian.gov.cn');
insert into store_emails (id, email) values ('33', 'erudeforthg@cafepress.com');
insert into store_emails (id, email) values ('4', 'wdewberryh@posterous.com');
insert into store_emails (id, email) values ('16', 'slipyeati@wix.com');
insert into store_emails (id, email) values ('34', 'mlancetterj@hp.com');
insert into store_emails (id, email) values ('26', 'strevenak@naver.com');
insert into store_emails (id, email) values ('15', 'jvarndalll@is.gd');
insert into store_emails (id, email) values ('5', 'wpohlingm@lycos.com');
insert into store_emails (id, email) values ('30', 'jrehnn@4shared.com');
insert into store_emails (id, email) values ('25', 'dhillando@github.io');
insert into store_emails (id, email) values ('22', 'nledwidgep@oaic.gov.au');
insert into store_emails (id, email) values ('35', 'cliellq@youtu.be');
insert into store_emails (id, email) values ('12', 'melphr@java.com');
insert into store_emails (id, email) values ('6', 'afoads@spotify.com');
insert into store_emails (id, email) values ('2', 'dwoodburnet@mozilla.com');
insert into store_emails (id, email) values ('19', 'utownsendu@gravatar.com');
insert into store_emails (id, email) values ('7', 'svondrasekv@ameblo.jp');
insert into store_emails (id, email) values ('18', 'cgudemanw@list-manage.com');
insert into store_emails (id, email) values ('8', 'eyewenx@pagesperso-orange.fr');
insert into store_emails (id, email) values ('10', 'dlanbertoniy@over-blog.com');
insert into store_emails (id, email) values ('9', 'phullerz@google.ca');
insert into store_emails (id, email) values ('35', 'ealmak10@naver.com');
insert into store_emails (id, email) values ('28', 'mheselwood11@timesonline.co.uk');
insert into store_emails (id, email) values ('8', 'roseland12@kickstarter.com');
insert into store_emails (id, email) values ('23', 'mfriday13@wired.com');
insert into store_emails (id, email) values ('29', 'ldurtnall14@globo.com');
insert into store_emails (id, email) values ('24', 'hgroundwator15@comsenz.com');
insert into store_emails (id, email) values ('4', 'gskechley16@gizmodo.com');
insert into store_emails (id, email) values ('27', 'slewcock17@walmart.com');
insert into store_emails (id, email) values ('25', 'akrolle18@photobucket.com');
insert into store_emails (id, email) values ('2', 'mlenox19@yellowbook.com');
insert into store_emails (id, email) values ('13', 'adymock1a@princeton.edu');
insert into store_emails (id, email) values ('16', 'keverist1b@geocities.jp');
insert into store_emails (id, email) values ('20', 'bluna1c@ebay.co.uk');
insert into store_emails (id, email) values ('18', 'tdibiasi1d@lulu.com');
insert into store_emails (id, email) values ('1', 'ndibiasi1e@multiply.com');
insert into store_emails (id, email) values ('3', 'tpatrono1f@opera.com');
insert into store_emails (id, email) values ('12', 'abrisland1g@shutterfly.com');
insert into store_emails (id, email) values ('21', 'rgrealish1h@google.co.uk');
insert into store_emails (id, email) values ('22', 'vmyrkus1i@multiply.com');
insert into store_emails (id, email) values ('10', 'khammersley1j@theguardian.com');
insert into store_emails (id, email) values ('6', 'cdebrett1k@jugem.jp');
insert into store_emails (id, email) values ('7', 'fguy1l@usnews.com');
insert into store_emails (id, email) values ('31', 'adearan1m@etsy.com');
insert into store_emails (id, email) values ('11', 'dhame1n@hostgator.com');
insert into store_emails (id, email) values ('17', 'lvedmore1o@opera.com');
insert into store_emails (id, email) values ('15', 'marnaez1p@cargocollective.com');
insert into store_emails (id, email) values ('34', 'tclarridge1q@hostgator.com');
insert into store_emails (id, email) values ('26', 'kthorneley1r@youtube.com');
insert into store_emails (id, email) values ('33', 'eknuckles1s@bbc.co.uk');
insert into store_emails (id, email) values ('14', 'jbasketter1t@trellian.com');
insert into store_emails (id, email) values ('5', 'cdjokic1u@networksolutions.com');
insert into store_emails (id, email) values ('30', 'bhamelyn1v@phpbb.com');
insert into store_emails (id, email) values ('32', 'cfriar1w@yahoo.com');
insert into store_emails (id, email) values ('19', 'ckeizman1x@accuweather.com');
insert into store_emails (id, email) values ('35', 'rfilipovic1y@spotify.com');
insert into store_emails (id, email) values ('32', 'dmaides1z@amazon.com');
insert into store_emails (id, email) values ('14', 'tbradick20@boston.com');
insert into store_emails (id, email) values ('25', 'rburfoot21@flavors.me');
insert into store_emails (id, email) values ('2', 'cdornin22@gmpg.org');
insert into store_emails (id, email) values ('17', 'tworkes23@nasa.gov');
insert into store_emails (id, email) values ('26', 'sbulmer24@reuters.com');
insert into store_emails (id, email) values ('9', 'aferrucci25@skype.com');
insert into store_emails (id, email) values ('3', 'lkopp26@topsy.com');
insert into store_emails (id, email) values ('15', 'mtraylen27@ezinearticles.com');
insert into store_emails (id, email) values ('6', 'dmacghee28@time.com');
insert into store_emails (id, email) values ('24', 'bmccomish29@slate.com');
insert into store_emails (id, email) values ('18', 'tdeantoni2a@china.com.cn');
insert into store_emails (id, email) values ('23', 'fheyns2b@japanpost.jp');
insert into store_emails (id, email) values ('1', 'ikennelly2c@dion.ne.jp');
insert into store_emails (id, email) values ('20', 'snyles2d@washingtonpost.com');
insert into store_emails (id, email) values ('29', 'mtann2e@cpanel.net');
insert into store_emails (id, email) values ('28', 'mbetho2f@wunderground.com');
insert into store_emails (id, email) values ('13', 'gdymock2g@ft.com');
insert into store_emails (id, email) values ('31', 'cradke2h@angelfire.com');
insert into store_emails (id, email) values ('11', 'wcollicott2i@nytimes.com');
insert into store_emails (id, email) values ('7', 'hturbat2j@unblog.fr');
insert into store_emails (id, email) values ('19', 'gcrichton2k@mediafire.com');
insert into store_emails (id, email) values ('16', 'jpeggram2l@thetimes.co.uk');
insert into store_emails (id, email) values ('34', 'dlaville2m@posterous.com');
insert into store_emails (id, email) values ('12', 'bmattingly2n@feedburner.com');
insert into store_emails (id, email) values ('30', 'mduffet2o@imgur.com');
insert into store_emails (id, email) values ('27', 'lbischoff2p@census.gov');
insert into store_emails (id, email) values ('21', 'oscoles2q@bandcamp.com');
insert into store_emails (id, email) values ('33', 'hbrokenshaw2r@nih.gov');

select o.id, Sum(op.quantity * p.price)
        from driver d join orders o on d.id = o.driver_id
        join orders_product op on o.id = op.orders_id
        join product p on op.product_id = p.id
        where o.id = 30 and d.id = 1
        group by o.id
