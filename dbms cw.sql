
/*            ---DBMS course work---
team members =>
              	GADSE232.F-005-Chanuka Dilshan[Leader]
				GADSE232.F-012- Bhagya P.I.
				GADSE232.F-019-A.L.P. De Zoysa
				GADSE232.F-026 Pitiyage K.L.
				GADSE232.F-033-Binarika W.G.P.     
*/

create database MealMate


----------------------------------------|Create tables|-----------------------------------------------------

--customer table


create table Customer(
CustID varchar(20) primary key check(CustID like '%C'),
Name varchar(150) not null,
PassWord varchar(50) not null,
TelephoneNumber int  unique not null
);

--create cart table

create table Cart(
CartID varchar(20) primary key check(CartID like 'C%'),
NumberOfProducts int not null,
TotalPrice decimal(10,2) not null,
Discount varchar(10) default '0'
);

--create Cart_NameOfItems
create table Cart_NameOfProducts(
CartID varchar(20) foreign key references Cart(CartID),
NameOfProducts varchar(100),
primary key (CartID,NameOfProducts)
);


--create Menuitem table

create table MenuItem (
ItemID varchar(20) primary key check(ItemID like'I%'),
Name varchar (100) not null,
Decription text not null,
PricePerUnit decimal (5,2),
Availability varchar(15)
);


--create CartMenuItem table

create table CartMenuItem(
ItemID varchar(20) foreign key references MenuItem(ItemID),
CartID varchar(20) foreign key references Cart(CartID),
primary key(ItemID,CartID),
Quantity int not null
);

--create Restorent table

create table Restorent(
RestorentID  varchar(20) primary key check(RestorentID like 'R%'),
Name varchar (150) not null,
Location varchar(50) not null,
email varchar(200) unique,
Rating float not null check( Rating >0 and Rating <= 5),
OpeningTime time not null,
CloseingTime time not null
);

--create RestorentTelephoneNo table

create table RerstorentTelephoneNo(
RestorentID varchar(20) foreign key references Restorent(RestorentID),
TelephoneNo int unique,
primary key (RestorentID,TelephoneNo)
);

--create MenuItemRestorent table 

create table MenuItemRestorent(
RestorentID varchar(20) foreign key references Restorent(RestorentID),
ItemID varchar(20) foreign key references MenuItem(ItemID),
primary key (ItemID,RestorentID)
);

--create  DeliveryAgency  table

create table DeliveryAgency (
DeliveryAgencyID varchar(20) primary key  check(DeliveryAgencyID like 'DA%'),
Name varchar(200) not null,
Location varchar(50) not null
);


--create DeliveryAgencyTelephoneNo table

create table DeliveryAgencyTelephoneNo(
DeliveryAgencyID varchar(20) foreign key  references DeliveryAgency(DeliveryAgencyID),
telePhoneNo int unique not null,
primary key (DeliveryAgencyID,telePhoneNo)
);

--create Driver table

create table Driver(
DriverID varchar(20) primary key check(DriverID like '%D'),
name varchar(150) not null,
TelePhoneNo int  unique not null ,
email varchar(200) unique,
DeliveryFee decimal(5,2) default 0.00,
DeliveryAgencyID varchar(20) foreign key references DeliveryAgency(DeliveryAgencyID)------look at this
);

--create Staff table

create table Staff(
StaffID varchar(20) primary key check (StaffID like 'S%'),
name varchar(150) not null,
email varchar(200) unique ,
telePhoneNo int unique not null,
DateOfJoin date ,
RestorentID varchar(20) foreign key references Restorent(RestorentID)
);

--create Order table 

create table Orders(
OrderID varchar(20) primary key check(OrderID like 'O_%'),
Location varchar(50) not null,
DateAndTime datetime default getdate(),
PaymentMethod varchar(10) not null,
Cost decimal(10,2)not null,
CustID varchar(20) foreign key references Customer(CustID),
StaffID varchar(20) foreign key references Staff(StaffID),
DriverID varchar(20) foreign key references Driver(DriverID),
CartID varchar(20) foreign key references Cart(CartID)
);

ALTER TABLE Orders
alter column PaymentMethod varchar(30) not null


--create Feedback table

create table Feedback(
OrderID varchar(20) foreign key references Orders(OrderID),
FeedbackID varchar(20) check(feedbackID like 'F%'),
primary key(OrderID,FeedbackID),
Rating float not null check( Rating >0 and Rating <= 5),
comment text 
);




----------------------------------------|Insert data|-----------------------------------------------------


-- Insert data into the Customer table
INSERT INTO Customer (CustID, Name, PassWord, TelephoneNumber)
VALUES
('001C', 'Chanuka Perera', 'password01', 0719999999),
('002C', 'Dilshan Ranasinghe', 'pass_dilshan02', 0768888888),
('003C', 'Kavindu Silva', 'pass_kavindu03', 0777777777),
('004C', 'Nimesh Fernando', 'pass_nimesh04', 0726666666),
('005C', 'Malitha Gunaratne', 'pass_malitha05', 0765555555),
('006C', 'Tharindu Rajapakse', 'pass_tharindu06', 0714444444),
('007C', 'Dinusha Wijeratne', 'pass_dinusha07', 0753333333),
('008C', 'Ruwini Perera', 'pass_ruwini08', 0712222222),
('009C', 'Kusal Jayawardena', 'pass_kusal09', 0761111111),
('010C', 'Sandun Silva', 'pass_sandun10', 0770000000),
('011C', 'Chathura Rathnayake', 'pass_chathura11', 0721234567),
('012C', 'Thilina Kumara', 'pass_thilina12', 0760987654),
('013C', 'Samantha Ranaweera', 'pass_samantha13', 0715674389),
('014C', 'Nadeesha Gunasekara', 'pass_nadeesha14', 0759753246),
('015C', 'Isuru Senanayake', 'pass_isuru15', 0710987123);





-- Insert data into the MenuItem table
insert into MenuItem (ItemID, Name, Decription, PricePerUnit, Availability)
VALUES
('I001', 'Burger', 'Delicious burger with fries', 500.00, 'Available'),
('I002', 'Pizza', 'Margherita pizza with fresh tomatoes', 999.99, 'Available'),
('I003', 'Pasta', 'Classic spaghetti with marinara sauce', 750.00, 'Available'),
('I004', 'Chicken Curry', 'Spicy chicken curry with basmati rice', 300.00, 'Available'),
('I005', 'Salad', 'Fresh garden salad with balsamic vinaigrette', 250.00, 'Available'),
('I006', 'Sushi Roll', 'Assorted sushi rolls with wasabi and soy sauce', 399.99, 'Available'),
('I007', 'Steak', 'Grilled sirloin steak with mashed potatoes', 500.00, 'Available'),
('I008', 'Vegetable Stir-Fry', 'Stir-fried vegetables with tofu in soy-ginger sauce', 450.00, 'Available'),
('I009', 'Fish Tacos', 'Battered fish tacos with coleslaw and chipotle mayo', 450.00, 'Available'),
('I010', 'Shrimp Scampi', 'Garlic butter shrimp with linguine pasta', 250.00, 'Available'),
('I011', 'Vegetarian Pizza', 'Vegetarian pizza with assorted veggies', 750.00, 'Available'),
('I012', 'BBQ Ribs', 'Slow-cooked BBQ ribs with barbecue sauce', 500.00, 'Available'),
('I013', 'Chicken Caesar Salad', 'Grilled chicken caesar salad with croutons', 650.00, 'Available'),
('I014', 'Mushroom Risotto', 'Creamy mushroom risotto with parmesan cheese', 249.99, 'Available'),
('I015', 'Tandoori Chicken', 'Tandoori-style grilled chicken with naan bread', 999.99, 'Available');

-- Insert data into the Cart table
insert into  Cart(CartID, NumberOfProducts, TotalPrice,Discount)
VALUES

('C001', 6, 4399.96, 439.99),
('C002', 3, 1750.00, 00.00),
('C003', 9, 3050.00, 305.00),
('C004', 2, 900.00, 00.00),
('C005', 4, 1800.00, 00.00),
('C006', 4, 2649.99, 00.00),
('C007', 7, 3500.00, 350.00),
('C008', 4, 2200.00, 00.00),
('C009', 2,  699.99, 00.00),
('C010', 7, 3999.97, 399.99),
('C011', 6, 3000.00, 300.00),
('C012', 7, 3399.99, 339.99),
('C013', 9, 6650.00, 665.00),
('C014', 7, 3398.96, 339.90),
('C015', 6, 3999.97, 399.99);


-----------------------------Cart_NameOfItems----------------------------------------------

insert into Cart_NameOfProducts (CartID,NameOfProducts)
values
('C001','Burger'),
('C001','Pizza'),
('C001','Sushi Roll'),
('C002','Burger'),
('C002','Steak'),
('C002','Pasta'),
('C003','Chiken Curry'),
('C003','Salad'),
('C003','Vegetable stir-fry'),
('C004','Fish Tacos'),
('C005','Shrimp scampi'),
('C006','Sushi Roll'),
('C006','Vegiterian Pizza'),
('C007','Steak'),
('C007','BBQ Ribs'),
('C008','Vegetable stir-fry'),
('C008','Chicken Caesar Salad'),
('C009','Fish Tacos'),
('C009','Mushroom Risotto'),
('C010','Shrimp Scampi'),
('C010','Tandoori Chicken'),
('C011','Vegetarian Pizza'),
('C011','Burger'),
('C012','BBQ Ribs'),
('C012','Chicken Curry'),
('C012','Pizza'),
('C013','Chicken Caesar salad'),
('C013','Pasta'),
('C014','Mushroom Risotto'),
('C014','Pizza'),
('C014','Chicken Curry'),
('C015','Tandoori Chicken'),
('C015','Burger'),
('C015','Salad')

-- Insert data into the CartMenuItem table
insert into CartMenuItem (ItemID, CartID, Quantity)
VALUES
('I001', 'C001', 2),
('I002', 'C001', 3),
('I003', 'C002', 1),
('I004', 'C003', 4),
('I005', 'C003', 2),
('I006', 'C006', 1),
('I007', 'C007', 3),
('I008', 'C008', 2),
('I009', 'C009', 1),
('I010', 'C010', 4),
('I011', 'C011', 2),
('I012', 'C012', 3),
('I013', 'C013', 1),
('I014', 'C014', 2),
('I015', 'C015', 3),
('I001', 'C015', 1),
('I002', 'C014', 2),
('I003', 'C013', 8),
('I004', 'C012', 3),
('I005', 'C011', 2),
('I006', 'C001', 1),
('I007', 'C002', 2),
('I008', 'C003', 3),
('I009', 'C004', 2),
('I010', 'C005', 2),
('I011', 'C006', 3),
('I012', 'C007', 4),
('I013', 'C008', 2),
('I014', 'C009', 1),
('I015', 'C010', 3),
('I001', 'C011', 2),
('I002', 'C012', 1),
('I004', 'C014', 3),
('I005', 'C015', 2);


-- Insert data into the Restorent table
insert into Restorent (RestorentID, Name, Location, email, Rating, OpeningTime, CloseingTime)
VALUES
('R001', 'The Food Haven', '123 Main St', 'info@foodhaven.com', 4.5, '08:00:00', '22:00:00'),
('R002', 'Tasty Bites', '456 Oak St', 'info@tastybites.com', 4.2, '09:00:00', '23:00:00'),
('R003', 'Sizzling Grill', '789 Pine St', 'info@sizzlinggrill.com', 4.7, '10:00:00', '21:30:00'),
('R004', 'Mellow Mushroom', '101 Elm St', 'info@mellowmushroom.com', 4.0, '11:00:00', '20:00:00'),
('R005', 'Spice Palace', '202 Maple St', 'info@spicepalace.com', 4.8, '12:00:00', '22:30:00'),
('R006', 'Crispy Crust Pizza', '303 Birch St', 'info@crispycrust.com', 4.3, '13:00:00', '21:00:00'),
('R007', 'Ocean Delights', '404 Cedar St', 'info@oceandelights.com', 4.6, '14:00:00', '22:30:00'),
('R008', 'Golden Wok', '505 Willow St', 'info@goldenwok.com', 4.1, '15:00:00', '20:30:00'),
('R009', 'Juicy Burger Joint', '606 Redwood St', 'info@juicyburger.com', 4.4, '16:00:00', '23:00:00'),
('R010', 'Green Leaf Salad Bar', '707 Spruce St', 'info@greenleafsalad.com', 4.9, '17:00:00', '21:30:00'),
('R011', 'Taco Fiesta', '808 Cedar St', 'info@tacofiesta.com', 4.2, '18:00:00', '22:00:00'),
('R012', 'Sushi Haven', '909 Pine St', 'info@sushihaven.com', 3.0, '19:00:00', '23:30:00'),
('R013', 'Pasta Paradise', '1010 Elm St', 'info@pastaparadise.com', 4.5, '20:00:00', '22:30:00'),
('R014', 'Fresh and Fit Cafe', '1111 Oak St', 'info@freshfitcafe.com', 4.6, '21:00:00', '20:30:00'),
('R015', 'Brewed Bliss Coffee', '1212 Maple St', 'info@brewedbliss.com', 4.3, '22:00:00', '23:59:00')


-- Insert data into the RerstorentTelephoneNo table
insert into RerstorentTelephoneNo (RestorentID, TelephoneNo)
VALUES
('R001', 0910000001),
('R001', 0910000002),
('R002', 0910000003),
('R002', 0910000004),
('R003', 0910000005),
('R003', 0910000006),
('R004', 0910000007),
('R004', 0910000008),
('R005', 0910000009),
('R005', 0910000010),
('R006', 0910000011),
('R006', 0910000012),
('R007', 0910000013),
('R007', 0910000014),
('R008', 0910000015),
('R008', 0910000016),
('R009', 0910000017),
('R009', 0910000018),
('R010', 0910000019),
('R010', 0910000020),
('R011', 0910000021),
('R011', 0910000022),
('R012', 0910000023),
('R012', 0910000024),
('R013', 0910000025),
('R013', 0910000026),
('R014', 0910000027),
('R015', 0910000028);

-- Insert data into the MenuItemRestorent table

insert into MenuItemRestorent(RestorentID,ItemID)
values
('R001','I001'),
('R001','I002'),
('R001','I004'),
('R001','I005'),
('R001','I008'),
('R001','I010'),
('R001','I015'),
('R002','I001'),
('R002','I003'),
('R002','I004'),
('R002','I005'),
('R002','I006'),
('R002','I007'),
('R002','I008'),
('R002','I011'),
('R002','I013'),
('R003','I001'),
('R003','I002'),
('R003','I003'),
('R003','I005'),
('R003','I006'),
('R003','I007'),
('R003','I009'),
('R003','I011'),
('R003','I012'),
('R004','I001'),
('R004','I002'),
('R004','I003'),
('R004','I004'),
('R004','I005'),
('R004','I006'),
('R004','I007'),
('R004','I009'),
('R004','I010'),
('R004','I011'),
('R005','I001'),
('R005','I002'),
('R005','I003'),
('R005','I004'),
('R005','I005'),
('R005','I006'),
('R005','I007'),
('R005','I015'),
('R006','I001'),
('R006','I002'),
('R006','I003'),
('R006','I004'),
('R006','I005'),
('R006','I006'),
('R006','I007'),
('R006','I008'),
('R006','I009'),
('R006','I010'),
('R007','I001'),
('R007','I002'),
('R007','I003'),
('R007','I004'),
('R007','I005'),
('R007','I006'),
('R007','I007'),
('R007','I008'),
('R007','I009'),
('R007','I010'),
('R008','I001'),
('R008','I002'),
('R008','I003'),
('R008','I004'),
('R008','I005'),
('R008','I006'),
('R008','I007'),
('R008','I008'),
('R009','I001'),
('R009','I002'),
('R009','I003'),
('R009','I004'),
('R009','I005'),
('R009','I006'),
('R009','I007'),
('R009','I008'),
('R010','I001'),
('R010','I002'),
('R010','I003'),
('R010','I004'),
('R010','I005'),
('R010','I006'),
('R010','I007'),
('R010','I008'),
('R010','I009'),
('R010','I010'),
('R010','I011'),
('R010','I012'),
('R010','I013'),
('R010','I014'),
('R011','I001'),
('R011','I002'),
('R011','I003'),
('R011','I004'),
('R011','I005'),
('R011','I006'),
('R011','I007'),
('R011','I008'),
('R011','I009'),
('R011','I010'),
('R011','I011'),
('R011','I012'),
('R012','I001'),
('R012','I002'),
('R012','I003'),
('R012','I004'),
('R012','I005'),
('R012','I006'),
('R012','I007'),
('R012','I008'),
('R012','I009'),
('R012','I010'),
('R012','I011'),
('R013','I001'),
('R013','I002'),
('R013','I003'),
('R013','I004'),
('R013','I005'),
('R013','I006'),
('R013','I007'),
('R013','I008'),
('R013','I009'),
('R013','I010'),
('R013','I011'),
('R013','I012'),
('R014','I001'),
('R014','I002'),
('R014','I003'),
('R014','I004'),
('R014','I005'),
('R014','I006'),
('R014','I007'),
('R014','I008'),
('R014','I009'),
('R014','I010'),
('R014','I013'),
('R015','I001'),
('R015','I002'),
('R015','I003'),
('R015','I004'),
('R015','I005'),
('R015','I006'),
('R015','I007'),
('R015','I008'), 
('R015','I009'),
('R015','I010'),
('R015','I012');

-- Insert data into the DeliveryAgency table
insert into DeliveryAgency (DeliveryAgencyID, Name, Location)
VALUES
('DA001', 'Swift Deliveries', 'City Center'),
('DA002', 'Express Eats', 'Suburb Street'),
('DA003', 'Speedy Couriers', 'Downtown Avenue'),
('DA004', 'Rapid Dispatch', 'Metro Plaza'),
('DA005', 'Quick Drop', 'Urban Square'),
('DA006', 'Flash Delivery', 'Central Boulevard'),
('DA007', 'Pace Couriers', 'Mall Road'),
('DA008', 'Zoom Express', 'Shopping Center'),
('DA009', 'CitySwift Logistics', 'Business District'),
('DA010', 'Metro Movers', 'Corporate Park'),
('DA011', 'Urban Express', 'Tech Hub Street'),
('DA012', 'SwiftLine Couriers', 'Financial District'),
('DA013', 'Dash Deliveries', 'Tech Center'),
('DA014', 'Mega Movers', 'Innovation Alley'),
('DA015', 'Sprint Logistics', 'Tech Park');


-- Insert data into the DeliveryAgencyTelephoneNo table
insert into DeliveryAgencyTelephoneNo (DeliveryAgencyID, telePhoneNo)
VALUES
('DA001', 0919989999),
('DA001', 0919999991),
('DA002', 0919999992),
('DA002', 0919999993),
('DA003', 0919999994),
('DA003', 0919999995),
('DA004', 0919999996),
('DA004', 0919999997),
('DA005', 0919999998),
('DA005', 0919999999),
('DA006', 0919999910),
('DA006', 0919999911),
('DA007', 0919999912),
('DA007', 0919999913),
('DA008', 0919999914),
('DA008', 0919999915),
('DA009', 0919999916),
('DA009', 0919999917),
('DA010', 0919999918),
('DA010', 0919999919),
('DA011', 0919999920),
('DA011', 0919999921),
('DA012', 0919999922),
('DA012', 0919999923),
('DA013', 0919999924),
('DA014', 0919999925),
('DA014', 0919999926),
('DA015', 0919999927),
('DA015', 0919999928);


-- Insert data into the Driver table
insert into Driver (DriverID, name, TelePhoneNo, email, DeliveryFee, DeliveryAgencyID)
VALUES
('001D', 'John', 0770234567, 'john@example.com', 300.00, 'DA001'),
('002D', 'Jane', 0710987654, 'jane@example.com', 450.00, 'DA002'),
('003D', 'Robert', 0753876543, 'robert@example.com', 350.00, 'DA001'),
('004D', 'Alice', 0744765432, 'alice@example.com', 400.00, 'DA002'),
('005D', 'Michael', 0735654321, 'michael@example.com', 320.00, 'DA001'),
('006D', 'Emily', 0726543210, 'emily@example.com', 480.00, 'DA002'),
('007D', 'David', 0717432109, 'david@example.com', 380.00, 'DA001'),
('008D', 'Olivia', 0708321098, 'olivia@example.com', 420.00, 'DA002'),
('009D', 'Matthew', 0799210987, 'matthew@example.com', 310.00, 'DA001'),
('010D', 'Sophia', 0780109876, 'sophia@example.com', 460.00, 'DA002'),
('011D', 'Daniel', 0771789012, 'daniel@example.com', 330.00, 'DA001'),
('012D', 'Ella', 0764890123, 'ella@example.com', 490.00, 'DA002'),
('013D', 'Christopher', 0757901234, 'christopher@example.com', 340.00, 'DA001'),
('014D', 'Ava', 0746012345, 'ava@example.com', 470.00, 'DA002'),
('015D', 'Mason', 0726123456, 'mason@example.com', 360.00, 'DA001');


-- Insert data into the Staff table
insert into Staff (StaffID, name, email, telePhoneNo, DateOfJoin, RestorentID)
VALUES
('S001', 'Kavindu Silva', 'kavindu.silva@example.com', 0764445555, '2023-01-01', 'R001'),
('S002', 'Ishara Fernando', 'ishara.fernando@example.com', 0773334444, '2023-02-01', 'R002'),
('S003', 'Sahan Perera', 'sahan.perera@example.com', 0772223333, '2023-03-01', 'R003'),
('S004', 'Tharindu Bandara ', 'tharindu.bandara@example.com', 0768887777, '2023-04-01', 'R004'),
('S005', 'Anushka Jayawardena', 'anushka.jayawardena@example.com', 0767776666, '2023-05-01', 'R005'),
('S006', 'Dinusha Rajapakse', 'dinusha.rajapakse@example.com', 0706665555, '2023-06-01', 'R006'),
('S007', 'Chathura Senanayake', 'chathura.senanayake@example.com', 0705554444, '2023-07-01', 'R007'),
('S008', 'Malitha Gunaratne', 'malitha.gunaratne@example.com',0774443333, '2023-08-01', 'R008'),
('S009', 'Nadeesha Ranasinghe', 'nadeesha.ranasinghe@example.com', 0763332222, '2023-09-01', 'R009'),
('S010', 'Niroshan Karunaratne', 'niroshan.karunaratne@example.com', 0702221111, '2023-10-01', 'R010'),
('S011', 'Shalini Pathirana', 'shalini.pathirana@example.com', 0761110000, '2023-11-01', 'R011'),
('S012', 'Asanka Samaraweera', 'asanka.samaraweera@example.com', 0740009999, '2023-12-01', 'R012'),
('S013', 'Dilhani de Silva', 'dilhani.desilva@example.com', 0748887777, '2024-01-01', 'R013'),
('S014', 'Chamara Rathnayake', 'chamara.rathnayake@example.com', 0747776666, '2024-02-01', 'R014'),
('S015', 'Devindi Liyanage', 'devindi.liyanage@example.com', 0766665555, '2024-03-01', 'R015')


-- Insert data into the Order table
insert into Orders (OrderID, Location, DateAndTime, PaymentMethod, Cost, CustID, StaffID, DriverID, CartID)
VALUES
('O_001', '888 Barre Boulevard, Balletburg', '2023-03-01 12:00:00', 'Cash', 800.00, '001C', 'S001', '001D', 'C001'),
('O_002', '505 Climbing Climb, Summit City', '2023-03-02 18:30:00', 'Credit Card', 750.00, '002C', 'S002', '002D', 'C002'),
('O_003',' 45 Jumping Jack Avenue','2023-03-02 18:31:12','Online payment',800.00,'004C','S003','004D','C005'),
('O_004','789 Treadmill Terrace, Cardio City','2023-03-02 18:48:00','Online Payment',2350.00,'007C','S004','003D','C004'),
('O_005','12 Squat Street, Flexington','2023-03-03 10:12:01','Cash',750.00,'003C','S010','008D','C011'),
('O_006','560 Yoga Lane, Zenville','2023-03-03 12:01:19','Cash',1480.00,'009C','S007','006D','C003'),
('O_007','34 Dumbbell Drive, Strength Springs','2023-03-03 12:30:05','Credit Card',590.00,'005C','S006','009D','C015'),
('O_008','98 Spin Class Circle, Cyclotopia','2023-03-03 13:02:01','Cash',680.00,'010C','S005','005D','C009'),
('O_009','23 Zumba Zone, Danceville','2023-03-03 18:02:03','Cash',650.00,'011C','S009','007D','C007'),
('O_010',' 76 Pilates Place, Coreburg','2023-03-03 18:15:10','Cash',960.00,'015C','S008','010D','C005'),
('O_011',' 155 Kettlebell Court, Muscleville','2023-03-03 18:30:20','Credit Card',2160.50,'005C','S011','015D','C008'),
('O_012',' 8 Plank Plaza, Stabilize City','2023-03-03 18:31:00','Cash',660.00,'014C','S009','011D','C010'),
('O_013', '432 HIIT Highway, Sprintburg', '2023-03-03 18:32:50','Credit Card',710.00,'006C','S015','012D','C013'),
('O_014',' 67 CrossFit Crescent, Power Peak','2023-03-03 19:10:40','Credit Card',890.00,'008C','S012','014D','C014'),
('O_015',' 321 Calisthenics Corner, Flexburg','2023-03-03 19:14:40','Online Payment',1340.00,'012C','S013','013D','C006');


-- Insert data into the Feedback table
insert into Feedback (OrderID, FeedbackID,Rating, comment)
VALUES 
('O_001', 'F001', 5,'Great service and wonderfull staff!'),
('O_002', 'F002', 5,'Delicious food!'),
('O_003', 'F003',4,'The variety of dishes offered is impressive, catering to different tastes and preferences.'),
('O_004', 'F004',5,'The quality of ingredients used in the dishes is evident, making each bite flavorful and enjoyable.'),
('O_005', 'F005',4,'The staff is friendly and attentive, providing excellent customer service throughout our visit.'),
('O_006', 'F006',3,'The ambiance creates a welcoming atmosphere, enhancing the overall dining experience.'),
('O_007', 'F007',3.7,'Portion sizes are generous, ensuring you leave satisfied without feeling overwhelmed.'),
('O_008', 'F008',5,'The menu showcases creativity with unique flavor combinations that stand out.'),
('O_009', 'F009',4.9,'Prices are reasonable for the quality of food and service provided.'),
('O_010', 'F010',5,'The cleanliness of the establishment reflects a commitment to hygiene standards.'),
('O_011', 'F011',4.1,'Timely service – our food arrived promptly, and the waitstaff was efficient.'),
('O_012', 'F012',4.2,'The presentation of each dish is aesthetically pleasing, adding to the overall dining pleasure.'),
('O_013', 'F013',4.7,'A great selection of beverages complements the food menu, offering diverse choices.'),
('O_014', 'F014',4.8,'The establishment accommodates dietary restrictions, providing options for various preferences.'),
('O_015', 'F015',4.9,'Consistent taste – our favorite dishes tasted just as good on repeat visits.');





-- quaries

--select
SELECT * FROM Customer;
SELECT * FROM MenuItem;
SELECT OrderID,Location,Cost,PaymentMethod from Orders;

--advance quearies
SELECT OrderID, SUM(Cost) AS TotalCost----------
FROM Orders
GROUP BY OrderID;


SELECT sum(quantity),ItemID from CartMenuItem-------
group by ItemID;


--joins
SELECT Orders.OrderID, Orders.Location, Orders.DateAndTime, Orders.PaymentMethod, Orders.Cost, Customer.Name AS CustomerName
FROM Orders
INNER JOIN Customer ON Orders.CustID = Customer.CustID;

SELECT Orders.OrderID, Orders.Location, Orders.DateAndTime, Orders.PaymentMethod, Orders.Cost, 
       Customer.Name AS CustomerName, Staff.name AS StaffName
FROM Orders
INNER JOIN Customer ON Orders.CustID = Customer.CustID
INNER JOIN Staff ON Orders.StaffID = Staff.StaffID;

SELECT Orders.OrderID,Feedback.Rating,Feedback.comment,Orders.PaymentMethod 
from Feedback 
INNER JOIN	Orders ON Feedback.OrderID=Orders.OrderID;

--sub quearies
SELECT Name AS CustomerName
FROM Customer
WHERE CustID IN (SELECT  CustID FROM Orders);

SELECT name,DeliveryFee 
from Driver
where DriverID IN(SELECT DriverID FROM Driver);

--VIEW
CREATE VIEW OrderDetails AS
SELECT Orders.OrderID, Orders.Location, Orders.DateAndTime, Orders.PaymentMethod, Orders.Cost, 
       Customer.Name AS CustomerName
FROM Orders
INNER JOIN Customer ON Orders.CustID = Customer.CustID;


CREATE VIEW RestaurantRatings AS
SELECT RestorentID, AVG(Rating) AS AvgRating
FROM Restorent
GROUP BY RestorentID;


CREATE VIEW RestaurantRatings AS
SELECT RestorentID, AVG(Rating) AS AvgRating
FROM Restorent
GROUP BY RestorentID;


--PROCEDURES

create Procedure listOfCustomer AS
begin
Select CustID,name from Customer
END

exec listOfCustomer

create Procedure listOfDriver AS
begin
Select DriverID,name,DeliveryFee from Driver
END

exec listOfDriver


create Procedure listOfDeliveryAgency AS
begin

Select DeliveryAgency.DeliveryAgencyID,DeliveryAgency.Name,DeliveryAgencyTelephoneNo.telePhoneNo 
From DeliveryAgency INNER JOIN DeliveryAgencyTelephoneNo
On DeliveryAgency.DeliveryAgencyID=DeliveryAgencyTelephoneNo.DeliveryAgencyID

END

exec listOfDeliveryAgency