create table Station(
StationID INT Primary Key,
StationName VARCHAR(250),
Location VARCHAR(250),
);

insert into Station(StationID, StationName, Location)
values(1, 'Karachi Cantt Station', 'Karacahi, Sindh'),
(2, 'Piplan Railway Station', 'Mianwali, Pujab'),
(3, 'Peshawar Cantonment Railway Station ', 'Peshawar, Khyber Pakhtunkhwa'),
(4, 'Gilgit Railway Station ', 'Gilgit city, Gilgit-Baltistan'),
(5, 'Quetta Railway Station ', 'Quetta, Balochistan');

create table Trains(
TrainID INT Primary Key,
TrainName VARCHAR(250),
Capacity INT,
);

insert into Trains(TrainID, TrainName, Capacity)
values(1, 'Green Line Express', 50),
(2, 'Shalimar Express', 60),
(3, 'Tezgam Express', 70),
(4, 'Awam Express', 55),
(5, 'Khyber Mail', 80);

create table Routes(
RouteID INT Primary Key,
TrainID INT, 
DepartureTime TIME,
ArrivalTime TIME,
DepartureStationID INT, 
ArrivalStationID INT,
FOREIGN KEY (TrainID) REFERENCES Trains(TrainID), 
FOREIGN KEY (DepartureStationID) REFERENCES Station(StationID),
FOREIGN KEY (ArrivalStationID) REFERENCES Station(StationID)
);

INSERT INTO Routes(RouteID, TrainID, DepartureTime, ArrivalTime, DepartureStationID, ArrivalStationID)
VALUES
    (1, 1, '08:00:00', '09:30:00', 1, 2),
    (2, 2, '10:15:00', '11:45:00', 2, 3),
    (3, 3, '01:00:00', '02:20:00', 3, 4),
    (4, 4, '04:00:00', '05:10:00', 4, 5),
    (5, 5, '06:30:00', '07:55:00', 5, 1);

create table Passenger(
PassengerID INT Primary Key,
PassengerName VARCHAR (250),  
Age INT,
Gender VARCHAR(8)
);

INSERT INTO Passenger(PassengerID, PassengerName, Age, Gender)
VALUES(021, 'YAMAN ALTAF', 21, 'MALE'),
(022, 'TAHA KHAN', 21, 'MALE'),
(023, 'SAQIB ISHFAQ', 21, 'MALE'),
(024, 'FATIMA GUL', 20, 'FEMALE'),
(025, 'TANZEELA KHAN', 26, 'FEMALE');

create table Tickets(
TicketID INT Primary Key,
SeatNumber INT,
TicketPrice INT,
BookingTime TIME,
PassengerID INT,  
RouteID INT,
FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
FOREIGN KEY (RouteID) REFERENCES Routes(RouteID),
);

INSERT INTO Tickets(TicketID, SeatNumber, TicketPrice, BookingTime, PassengerID, RouteID)
VALUES(001, 3, 5000, '08:00:00', 021, 1),
(002, 4, 6000, '09:15:00', 022, 2),
(003, 5, 5000, '08:39:00', 023, 3),
(004, 1, 6000, '10:50:00', 024, 4),
(005, 2, 6000, '11:00:00', 025, 5);

create table Booking(
BookingID INT Primary Key,
TicketID INT,
BookingStatus VARCHAR(250),
FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID),
);

INSERT INTO Booking(BookingID, TicketID, BookingStatus)
VALUES(0101, 001, 'BOOKED'),
(0102, 002, 'PENDING'),
(0103, 003, 'BOOKED'),
(0104, 004, 'PENDING'),
(0105, 005, 'BOOKED');

create table Train_Types(
TrainTypeID INT Primary Key,   
TrainTypeName VARCHAR(250),   
Amenities varchar(250)
);

INSERT INTO Train_Types(TrainTypeID, TrainTypeName, Amenities)
VALUES(1, 'Business Class', 'Comfortable air-conditioned sleeper compartments'),
(2, 'Luxury', 'Standard air-conditioned seating for passengers'),
(3, 'Economy Class', 'Comfortable air-conditioned sleeper compartments'),
(4, 'Business Class', ' Standard air-conditioned seating for passengers.'),
(5, 'Luxury', 'Comfortable air-conditioned sleeper compartments');

create table Cargo_Types(
CargoTypeID INT Primary Key, 
CargoTypeName VARCHAR(250)
);

INSERT INTO Cargo_Types(CargoTypeID, CargoTypeName)
VALUES(1, 'General Goods'),
(2, 'Perishables'),
(3, 'Heavy Machinery'),
(4, 'Chemicals'),
(5, 'Livestock');

create table Cargo_Routes(
RouteID INT Primary Key,
DepartureStationID INT,
ArrivalStationID INT,
Distance FLOAT,
FOREIGN KEY (DepartureStationID) REFERENCES Station(StationID),
FOREIGN KEY (ArrivalStationID) REFERENCES Station(StationID),
);

INSERT INTO Cargo_Routes(RouteID, DepartureStationID, ArrivalStationID, Distance)
VALUES(1, 1, 2, 150.66),
(2, 2, 3, 150.66),
(3, 3, 4, 230.55),
(4, 4, 5, 300.78),
(5, 5, 1, 100.29);

create table Cargo_Booking(
BookingID INT Primary Key, 
CargoTypeID INT,
RouteID INT,
BookingDate DATE,
Weight DECIMAL,
BookingStatus VARCHAR(250),
FOREIGN KEY (CargoTypeID) REFERENCES Cargo_Types(CargoTypeID),
FOREIGN KEY (RouteID) REFERENCES Cargo_Routes(RouteID),
);

INSERT INTO Cargo_Booking(BookingID, CargoTypeID, RouteID, BookingDate, Weight, BookingStatus)
values(10, 1, 1, '2024-05-12', 10.00, 'Confirmed'),
    (20, 3, 3, '2024-05-13', 5.00, 'Pending'),
    (30, 4, 5, '2024-05-14', 15.00, 'Confirmed'),
    (40, 2, 4, '2024-05-15', 8.00, 'Pending'),
    (50, 5, 2, '2024-05-16', 12.00, 'Confirmed');

create table Train_Classes(
ClassID INT Primary Key,
ClassName VARCHAR(250),  
Fare INT
);

INSERT INTO Train_Classes(ClassID, ClassName, Fare)
values(101, 'AC Sleeper', 2000.00),
(102, 'AC Standard', 1500.00),
(103, 'Business Class', 3000.00),
(104, 'Luxury', 5000.00),
(105, 'Economy', 1000.00);


create table Train_Class_Mapping(
ClassMappingID INT Primary Key,
TrainID INT,
ClassID INT,
FOREIGN KEY (TrainID) REFERENCES Trains(TrainID),
FOREIGN KEY (ClassID) REFERENCES Train_Classes(ClassID),
);

INSERT INTO Train_Class_Mapping(ClassMappingID,TrainID, ClassID)
values(1001, 2, 105),
(1002, 1, 103),
(1003, 3, 101),
(1004, 5, 102),
(1005, 4, 104);

create table Anouncementes(
UpdateID INT Primary Key,
AnouncementesDate DATE,
Anouncementes VARCHAR(250)
);

INSERT INTO Anouncementes(UpdateID, AnouncementesDate, Anouncementes)
VALUES(1, '2024-05-12', 'Important system maintenance scheduled for next week.'),
(2, '2024-05-13', 'New feature rollout: Enhanced search functionality.'),
(3, '2024-05-14', 'Reminder: Year-end financial reports due by Friday.'),
(4, '2024-05-15', 'Upcoming webinar: Introduction to Machine Learning.'),
(5, '2024-05-16', 'Emergency server reboot on Saturday morning.');


select * from Routes
select * from Trains
select * from Station
select * from Passenger
select * from Tickets
select * from Booking
select * from Train_Types
select * from Cargo_Types
select * from Cargo_Routes
select * from Cargo_Booking
select * from Train_Classes
select * from Train_Class_Mapping
select * from Anouncementes
