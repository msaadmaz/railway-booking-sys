# Created by Jason Mustafa. Do not distribute.
# Use of this file without permission is a violation of academic integrity @ Rutgers University.
# Database schema and test data for Railway Booking Database Management System.

CREATE TABLE station (
    id INT NOT NULL AUTO_INCREMENT,
    state VARCHAR(15) NOT NULL,
    name VARCHAR(30) NOT NULL,
    city VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO station
VALUES  (1, 'NJ', 'New Brunswick Train Station',    'New Brunswick'),
        (2, 'NY', 'New York Penn Station',          'New York'),
        (3, 'PA', 'Philadelphia Train Station',     'Philadelphia'),
        (4, 'NJ', 'Clifton Train Station',          'Clifton'),
        (5, 'NJ', 'Burlington River Line',          'Burlington');

CREATE TABLE route (
    id INT NOT NULL AUTO_INCREMENT,
    transit_line_name VARCHAR(30) NOT NULL,
    travel_time INT NOT NULL,
    standard_fare FLOAT NOT NULL,
    depart_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    origin_station_id INT NOT NULL,
    destination_station_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (origin_station_id) REFERENCES station(id),
    FOREIGN KEY (destination_station_id) REFERENCES station(id)
);

INSERT INTO route
VALUES  (1, 'North Line', 60, 10.0, '05:00:00', '06:00:00', 5, 2),
        (2, 'North Line', 60, 10.0, '10:00:00', '11:00:00', 5, 2),
        (3, 'North Line', 60, 10.0, '14:00:00', '15:00:00', 5, 2),
        (4, 'North Line', 60, 10.0, '20:00:00', '21:00:00', 5, 2),
        
        (5, 'South Line', 60, 10.0, '05:30:00', '06:30:00', 2, 5),
        (6, 'South Line', 60, 10.0, '10:30:00', '11:30:00', 2, 5),
        (7, 'South Line', 60, 10.0, '14:30:00', '15:30:00', 2, 5),
        (8, 'South Line', 60, 10.0, '20:30:00', '21:30:00', 2, 5),
        
        (9, 'NJ North', 30, 6.5, '09:00:00', '09:30:00', 1, 4),
        (10, 'NJ North', 30, 6.5, '18:00:00', '18:30:00', 1, 4),
        
        (11, 'NJ South', 30, 6.5, '10:00:00', '06:30:00', 4, 1),
        (12, 'NJ South', 30, 6.5, '06:00:00', '06:30:00', 4, 1),
        
        (13, 'Coast North', 120, 14.25, '05:30:00', '07:30:00', 3, 2),
        (14, 'Coast North', 120, 14.25, '12:30:00', '14:30:00', 3, 2),
        (15, 'Coast North', 120, 14.25, '16:30:00', '18:30:00', 3, 2),
        
        (16, 'Coast South', 120, 14.25, '06:00:00', '08:00:00', 2, 3),
        (17, 'Coast South', 120, 14.25, '13:00:00', '15:00:00', 2, 3),
        (18, 'Coast South', 120, 14.25, '17:00:00', '19:00:00', 2, 3);

CREATE TABLE stops_at (
    route_id INT NOT NULL,
    station_id INT NOT NULL,
    arrival_time TIME NOT NULL,
    departure_time TIME NOT NULL,
    PRIMARY KEY (route_id, station_id),
    FOREIGN KEY (route_id) REFERENCES route(id),
    FOREIGN KEY (station_id) REFERENCES station(id)
);

INSERT INTO stops_at
VALUES  /* North Line */
        (1, 1, '05:25:00', '05:30:00'),
        (1, 4, '05:40:00', '05:50:00'),
        
        (2, 1, '10:25:00', '10:30:00'),
        (2, 4, '10:40:00', '10:45:00'),
        
        (3, 1, '14:25:00', '14:30:00'),
        (3, 4, '14:40:00', '14:45:00'),
        
        (4, 1, '20:25:00', '20:30:00'),
        (4, 4, '20:40:00', '20:45:00'),
        
        /* South Line */
        (5, 4, '05:40:00', '05:45:00'),
        (5, 1, '06:10:00', '06:15:00'),
        
        (6, 4, '10:40:00', '10:45:00'),
        (6, 1, '11:10:00', '11:15:00'),
        
        (7, 4, '14:40:00', '14:45:00'),
        (7, 1, '15:10:00', '15:15:00'),
        
        (8, 4, '20:40:00', '20:45:00'),
        (8, 1, '20:10:00', '20:15:00'),
        
        /* Coast North */
        (13, 5, '06:25:00', '06:30:00'),
        (13, 1, '06:55:00', '07:00:00'),
        (13, 4, '07:25:00', '07:30:00'),
        
        (14, 5, '12:55:00', '13:00:00'),
        (14, 1, '13:25:00', '13:30:00'),
        (14, 4, '13:55:00', '14:00:00'),
        
        (15, 5, '16:25:00', '17:00:00'),
        (15, 1, '17:25:00', '17:30:00'),
        (15, 4, '17:55:00', '18:00:00'),
        
        /* Coast South */
        (16, 4, '06:25:00', '06:30:00'),
        (16, 1, '06:55:00', '07:00:00'),
        (16, 5, '07:25:00', '07:30:00'),
        
        (17, 4, '13:25:00', '13:30:00'),
        (17, 1, '13:55:00', '14:00:00'),
        (17, 5, '14:25:00', '14:30:00'),
        
        (18, 4, '17:25:00', '17:30:00'),
        (18, 1, '17:55:00', '18:00:00'),
        (18, 5, '18:25:00', '18:30:00');

CREATE TABLE train (
    id INT NOT NULL,
    total_seats INT NOT NULL,
    num_cars INT,
    route_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (route_id) REFERENCES route(id)
);

INSERT INTO train
VALUES  (1001, 60, 3, 1),
        (1002, 60, 3, 2),
        (1003, 60, 3, 3),
        (1004, 60, 3, 4),
        (1005, 60, 3, 5),
        (1006, 120, 4, 6),
        (1007, 120, 4, 7),
        (1008, 120, 4, 8),
        (1009, 120, 4, 9),
        (1010, 120, 4, 10),
        (1011, 120, 4, 11),
        (1012, 120, 4, 12),
        (1013, 80, 2, 13),
        (1014, 80, 2, 14),
        (1015, 80, 2, 15),
        (1016, 80, 2, 16),
        (1017, 80, 2, 17),
        (1018, 80, 2, 18);

CREATE TABLE trip (
    id INT NOT NULL AUTO_INCREMENT,
    available_seats INT NOT NULL,
    trip_date DATE NOT NULL,
    delay INT NOT NULL,
    route_id INT NOT NULL,
    train_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (route_id) REFERENCES route(id),
    FOREIGN KEY (train_id) REFERENCES train(id)
);

INSERT INTO trip
VALUES  (1, 60, '2020-05-01', 0, 1, 1001),
        (2, 60, '2020-05-02', 0, 1, 1001),
        (3, 60, '2020-05-03', 0, 1, 1001),
        (4, 60, '2020-05-04', 0, 1, 1001),
        (5, 60, '2020-05-05', 0, 1, 1001),
        
        (6, 60, '2020-05-01', 0, 2, 1002),
        (7, 60, '2020-05-02', 0, 2, 1002),
        (8, 60, '2020-05-03', 0, 2, 1002),
        (9, 60, '2020-05-04', 0, 2, 1002),
        
        (10, 60, '2020-05-01', 0, 3, 1003),
        (11, 60, '2020-05-02', 0, 3, 1003),
        (12, 60, '2020-05-03', 0, 3, 1003),
        (13, 60, '2020-05-04', 0, 3, 1003),
        (14, 60, '2020-05-05', 0, 3, 1003),
        
        (15, 60, '2020-05-03', 0, 4, 1004),
        (16, 60, '2020-05-04', 0, 4, 1004),
        (17, 60, '2020-05-05', 0, 4, 1004),
        (18, 60, '2020-05-06', 0, 4, 1004),
        (19, 60, '2020-05-07', 0, 4, 1004),
        
        (20, 60, '2020-05-03', 0, 5, 1005),
        (21, 60, '2020-05-04', 0, 5, 1005),
        (22, 60, '2020-05-05', 0, 5, 1005),
        (23, 60, '2020-05-06', 0, 5, 1005),
        
        (24, 120, '2020-05-06', 0, 6, 1006),
        (25, 120, '2020-05-07', 0, 6, 1006),
        (26, 120, '2020-05-08', 0, 6, 1006),
        (27, 120, '2020-05-09', 0, 6, 1006),
        
        (28, 120, '2020-06-07', 0, 7, 1007),
        (29, 120, '2020-06-08', 0, 7, 1007),
        (30, 120, '2020-06-09', 0, 7, 1007),
        (31, 120, '2020-06-10', 0, 7, 1007),
        (32, 120, '2020-06-11', 0, 7, 1007),
        
        (33, 120, '2020-06-10', 0, 8, 1008),
        (34, 120, '2020-06-11', 0, 8, 1008),
        (35, 120, '2020-06-12', 0, 8, 1008),
        (36, 120, '2020-06-13', 0, 8, 1008),
        (37, 120, '2020-06-14', 0, 8, 1008),
        
        (38, 120, '2020-06-11', 0, 9, 1009),
        (39, 120, '2020-06-12', 0, 9, 1009),
        (40, 120, '2020-06-13', 0, 9, 1009),
        (41, 120, '2020-06-14', 0, 9, 1009),
        (42, 120, '2020-06-15', 0, 9, 1009),
        
        (43, 120, '2020-05-18', 0, 10, 1010),
        (44, 120, '2020-05-19', 0, 10, 1010),
        (45, 120, '2020-05-20', 0, 10, 1010),
        (46, 120, '2020-05-21', 0, 10, 1010),
        
        (47, 120, '2020-05-17', 0, 11, 1011),
        (48, 120, '2020-05-18', 0, 11, 1011),
        (49, 120, '2020-05-19', 0, 11, 1011),
        (50, 120, '2020-05-20', 0, 11, 1011),
        (51, 120, '2020-05-21', 0, 11, 1011);

CREATE TABLE customer (
    username VARCHAR(20) NOT NULL,
    password VARCHAR(50) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    address VARCHAR(30) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state VARCHAR(15) NOT NULL,
    zip INT NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(30) NOT NULL,
    PRIMARY KEY (username)
);

INSERT INTO customer
VALUES  ('test',        'test',     'Test',         'Customer',     '123 College Ave',  'New Brunswick',    'NJ', '08901', '123-456-7890', 'test@test.com'),
        ('customer1',   'test',     'John',         'Smith',        '124 College Ave',  'New Brunswick',    'NJ', '08901', '123-456-7890', 'test@test.com'),
        ('customer2',   'test123',  'Jessica',      'Jones',        '125 College Ave',  'New Brunswick',    'NJ', '08901', '123-456-7890', 'test@test.com'),
        ('customer3',   'test456',  'Jack',         'Black',        '26 East River Rd', 'Clifton',          'NJ', '07516', '123-456-7890', 'test@test.com'),
        ('customer4',   'test789',  'Zendaya',      'Goat',         '27 East River Rd', 'Clifton',          'NJ', '07516', '123-456-7890', 'test@test.com'),
        ('customer5',   'test',     'Teddy',        'Roosevelt',    '28 East River Rd', 'Clifton',          'NJ', '07516', '123-456-7890', 'test@test.com'),
        ('customer6',   'test',     'Gabrielle',    'Johnson',      '4 Yeet Street',    'New Nork',         'NY', '09231', '123-456-7890', 'test@test.com'),
        ('customer7',   'test',     'Dolald',       'Glover',       '5 Yeet Street',    'New York',         'NY', '09231', '123-456-7890', 'test@test.com'),
        ('customer8',   'test',     'Vanessa',      'Customer',     '6 Yeet Street',    'New York',         'NY', '09231', '123-456-7890', 'test@test.com'),
        ('customer9',   'test',     'Absolute',     'Unit',         '7 Yeet Street',    'New York',         'NY', '09231', '123-456-7890', 'test@test.com');

CREATE TABLE employee (
    username VARCHAR(20) NOT NULL,
    password VARCHAR(50) NOT NULL,
    ssn VARCHAR(12) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    is_manager BOOLEAN NOT NULL,
    PRIMARY KEY (username)
);

INSERT INTO employee
VALUES  ('test',        'test',     '123-45-6789', 'Testemployee',  'Employee', false),
        ('admin',       'admin',    '234-56-7891', 'Testadmin',     'Admin',    true),
        ('employee1',   'test',     '123-45-6789', 'Jason',         'Istired',  false),
        ('employee2',   'test',     '123-45-6789', 'Saad',          'Muzzy',    false),
        ('employee3',   'test',     '123-45-6789', 'Taha',          'Simp',     false),
        ('employee4',   'test',     '123-45-6789', 'Jeremy',        'Neutron',  false),
        ('employee5',   'test',     '123-45-6789', 'Corporate',     'Greed',    false);

CREATE TABLE reservation (
    res_num INT NOT NULL AUTO_INCREMENT,
    customer_username VARCHAR(20) NOT NULL,
    trip_id INT NOT NULL,
    origin_station INT NOT NULL,
    destination_station INT NOT NULL,
    total_fare FLOAT NOT NULL,
    seat_num INT NOT NULL,
    seat_class VARCHAR(10) NOT NULL,
    date_made DATE NOT NULL,
    booking_fee FLOAT NOT NULL,
    employee_username VARCHAR(20),
    PRIMARY KEY (res_num),
    FOREIGN KEY (customer_username) REFERENCES customer(username) ON DELETE CASCADE,
    FOREIGN KEY (trip_id) REFERENCES trip(id),
    FOREIGN KEY (origin_station) REFERENCES station(id),
    FOREIGN KEY (destination_station) REFERENCES station(id),
    FOREIGN KEY (employee_username) REFERENCES employee(username) ON DELETE SET NULL
);

INSERT INTO reservation
VALUES  (1, 'test', 1, 1, 2, 12.0, 1, 'FIRST',      '2020-04-15', 2.0, 'test'),
        (2, 'test', 2, 1, 2, 12.0, 1, 'FIRST',      '2020-04-17', 2.0, 'test'),
        (3, 'test', 3, 1, 2, 12.0, 1, 'ECONOMY',    '2020-04-09', 2.0, 'test'),
        (4, 'test', 4, 1, 2, 12.0, 1, 'ECONOMY',    '2020-04-15', 2.0, NULL),
        (5, 'test', 5, 1, 2, 12.0, 1, 'ECONOMY',    '2020-04-15', 2.0, NULL),


        (6, 'customer1', 1, 1, 2, 10.0, 2, 'FIRST',     '2020-04-09', 2.0, 'test'),
        (7, 'customer2', 1, 1, 2, 10.0, 3, 'FIRST',     '2020-04-12', 2.0, 'employee1'),
        (8, 'customer3', 1, 1, 2, 10.0, 4, 'ECONOMY',   '2020-04-12', 2.0, 'employee2'),
        (9, 'customer4', 1, 1, 2, 10.0, 5, 'ECONOMY',   '2020-04-12', 2.0, NULL),
        
        (10, 'customer1', 2, 1, 2, 10.0, 2, 'ECONOMY',     '2020-04-09', 2.0, 'test'),
        (11, 'customer2', 2, 1, 2, 10.0, 3, 'FIRST',     '2020-04-12', 2.0, 'test'),
        (12, 'customer3', 2, 1, 2, 10.0, 4, 'ECONOMY',   '2020-04-17', 2.0, 'employee2'),
        (13, 'customer4', 2, 1, 2, 10.0, 5, 'ECONOMY',   '2020-04-12', 2.0, NULL),
        
        (14, 'customer1', 3, 1, 2, 10.0, 2, 'FIRST',     '2020-04-09', 2.0, 'test'),
        (15, 'customer2', 3, 1, 2, 10.0, 3, 'FIRST',     '2020-04-15', 2.0, 'test'),
        (16, 'customer3', 3, 1, 2, 10.0, 4, 'ECONOMY',   '2020-04-16', 2.0, 'employee4'),
        (17, 'customer4', 3, 1, 2, 10.0, 5, 'FIRST',   '2020-04-16', 2.0, NULL);

CREATE TABLE message (
    id INT NOT NULL AUTO_INCREMENT,
    text TEXT NOT NULL,
    time DATETIME NOT NULL,
    customer_username VARCHAR(20),
    PRIMARY KEY (id),
    FOREIGN KEY (customer_username) REFERENCES customer(username) ON DELETE SET NULL
);

INSERT INTO message
VALUES  (1, 'How many trains do you maintain?',                                     '2020-03-19 02:30:00', 'test'),
        (2, 'What time does the website close?',                                    '2020-02-25 05:30:00', 'test'),
        (3, 'How long does it take to get from New Brunswick to New York City',     '2020-01-08 12:30:00', 'test'),
        (4, 'Am I alone in the universe?',                                          '2020-03-21 12:30:00', 'customer1'),
        (5, 'Who built your database management system?',                           '2020-03-07 12:30:00', 'customer1'),
        (6, 'Do you provide refunds?',                                              '2020-02-15 11:30:00', 'test'),
        (7, 'Do you provide discounts for children or the elderly?',                '2020-02-16 16:30:00', 'test'),
        (8, 'This is not a question you just have a very nice website!',            '2020-01-21 17:30:00', 'customer2'),
        (9, 'How can I make a reservation?',                                        '2020-03-28 24:30:00', 'customer3');

CREATE TABLE responds_to (
    employee_username VARCHAR(20),
    message_id INT NOT NULL,
    text TEXT NOT NULL,
    time DATETIME NOT NULL,
    PRIMARY KEY (employee_username, message_id, time),
    FOREIGN KEY (employee_username) REFERENCES employee(username) ON DELETE CASCADE,
    FOREIGN KEY (message_id) REFERENCES message(id) ON DELETE CASCADE
);

INSERT INTO responds_to
VALUES  ('test',        1, 'We currently have roughly 20 trains available',                             '2020-03-19 08:00:00'),
        ('test',        2, 'Silly! We never close!',                                                    '2020-02-26 07:15:00'),
        ('test',        3, 'It will take about 1 hour.',                                                '2020-01-08 22:15:00'),
        ('employee1',   4, 'It depends on how you define alone.',                                       '2020-03-24 16:30:00'),
        ('employee2',   5, 'A team of highly-skilled and professional database engineers, of course!',  '2020-03-07 12:00:00');
