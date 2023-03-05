create database production;

drop table production.brands;
drop table production.stocks;
drop table production.categories;
drop table production.products;
drop table sales.stores;
drop table sales.staffs;


#1
create table production.stocks(
	store_id int ,
    product_id int ,
    quantity int,
    primary key(store_id,product_id),
    constraint stocks_key
    foreign key(store_id) references sales.stores(store_id),
    foreign key(product_id) references production.products(product_id)
    	on update cascade on delete cascade
);

select * from production.stocks;
#2
create  table production.brands(
	brand_id int auto_increment not null,
    brand_name varchar(255) not null,
    primary key(brand_id)
);


  #3
create table production.categories(
	category_id int not null auto_increment,
    category_name varchar(255) not null,
    primary key(category_id)
);


#4
create table production.products(
	product_id int auto_increment not null,
    product_name varchar(255) not null,
    brand_id int not null,
    category_id int not null,
    model_year smallint not null,
    list_price decimal(10,2) not null,
    primary key(product_id),
    constraint products_key
    foreign key (brand_id) references production.brands(brand_id),
    foreign key (category_id) references production.categories(category_id)
	on update cascade on delete cascade
);
 select * from production.products;

create database sales;

#5
create table sales.stores(
	store_id int not null auto_increment,
    store_name varchar(255) not null,
    phone varchar(25),
    email varchar(255),
    street varchar(255),
    city varchar(255),
    state varchar(10),
    zip_code varchar(5),
    primary key(store_id)
);

select * from sales.stores;

# 6
create table sales.staffs(
	staff_id int auto_increment not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(255) unique not null,
    phone varchar(25),
    active tinyint not null,
    store_id int not null,
    manager_id int,
    primary key(staff_id),
    constraint staff_key
    foreign key (store_id) references sales.stores(store_id),
    foreign key(manager_id) references sales.staffs(staff_id)
    	on update cascade on delete cascade
);

select * from sales.staffs;

# 7
create table sales.customers(
	customer_id int not null auto_increment ,
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    phone varchar(25) ,
    email varchar(255) not null,
    street varchar(255),
    city varchar(50),
    state varchar(25),
    zip_code varchar(5),
    primary key(customer_id)
);
select * from sales.customers;
# 8
create table sales.orders(
	order_id int not null auto_increment,
    customer_id int,
    order_status tinyint not null,
    order_date date not null,
    required_date date,
    shipped_date date,
    store_id int not null,
    staff_id int not null,
    primary key(order_id),
    constraint orders_key
    foreign key(store_id) references sales.stores(store_id),
	foreign key(staff_id) references sales.staffs(staff_id),
	foreign key(customer_id) references sales.customers(customer_id)
        	on update cascade on delete cascade
);

select * from sales.orders;
# 9
create table sales.order_items(
	order_id int not null,
    item_id int not null,
    product_id int not null,
    quantity int not null,
    list_price decimal(10,2) not null,
    discount decimal(4,2) not null,
    primary key(item_id,order_id),
    constraint items_key
    foreign key(order_id) references sales.orders(order_id),
    foreign key(order_id) references production.products(product_id)
		on update cascade on delete cascade
);


select * from sales.order_items;



# Final table quarry

SET sql_mode = 'PAD_CHAR_TO_FULL_LENGTH';


select o.order_id, concat(c.first_name,' ', c.last_name) as customers, c.city, c.state, o.order_date, oi.quantity as total_units, 
sum(round(oi.quantity*(oi.list_price *(100-(oi.discount*100))/100),2)) as revenue ,
p.product_name, ca.category_name, s.store_name, concat(st.first_name,' ',st.last_name) as sales_rep
from  sales.customers as c inner join sales.orders as o
on c.customer_id = o.customer_id
inner join sales.stores as s
on o.store_id = s.store_id
inner join sales.staffs as st
on o.staff_id = st.staff_id
inner join sales.order_items as oi
on o.order_id = oi.order_id
inner join production.products as p
on p.product_id = oi.product_id
inner join production.categories as ca
on p.category_id = ca.category_id
group by o.order_id, concat(c.first_name,' ', c.last_name)
order by o.order_id;