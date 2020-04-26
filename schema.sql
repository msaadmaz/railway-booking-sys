CREATE TABLE station (
    station_id INT NOT NULL,
    state VARCHAR(15) NOT NULL,
    name VARCHAR(30) NOT NULL,
    city VARCHAR(30) NOT NULL
);

INSERT INTO station
VALUES  (1, 'NJ', 'New Brunswick Train Station',    'New Brunswick'),
        (2, 'NY', 'New York Penn Station',          'New York'),
        (3, 'PA', 'Philadelphia Train Station',     'Philadelphia'),
        (4, 'NJ', 'Clifton Train Station',          'Clifton'),
        (5, 'NJ', 'Burlington River Line',          'Burlington');

CREATE TABLE route (
    route_id INT NOT NULL,
    transit_line_name VARCHAR(30) NOT NULL,
    travel_time INT NOT NULL,
    standard_fare FLOAT NOT NULL,
    depart_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    origin_station_id INT NOT NULL,
    destination_station_id INT NOT NULL,
    PRIMARY KEY (route_id),
    FOREIGN KEY (origin_station_id) REFERENCES station(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES station(station_id)
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
    FOREIGN KEY (route_id) REFERENCES route(route_id),
    FOREIGN KEY (station_id) REFERENCES station(station_id)
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
    train_id INT NOT NULL,
    total_seats INT NOT NULL,
    total_cars INT,
    route_id INT NOT NULL,
    PRIMARY KEY (train_id),
    FOREIGN KEY (route_id) REFERENCES route(route_id)
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
    trip_id INT NOT NULL,
    available_seats INT NOT NULL,
    trip_date DATE NOT NULL,
    delay INT NOT NULL,
    route_id INT NOT NULL,
    train_id INT NOT NULL,
    PRIMARY KEY (trip_id),
    FOREIGN KEY (route_id) REFERENCES route(route_id),
    FOREIGN KEY (train_id) REFERENCES train(train_id)
);

INSERT INTO trip
VALUES  (1, 60, '2020-05-01', 0, 1, 1),
        (2, 60, '2020-05-02', 0, 1, 1),
        (3, 60, '2020-05-03', 0, 1, 1),
        (4, 60, '2020-05-04', 0, 1, 1),
        (5, 60, '2020-05-05', 0, 1, 1),
        
        (6, 60, '2020-05-01', 0, 2, 2),
        (7, 60, '2020-05-02', 0, 2, 2),
        (8, 60, '2020-05-03', 0, 2, 2),
        (9, 60, '2020-05-04', 0, 2, 2),
        
        (10, 60, '2020-05-01', 0, 3, 3),
        (11, 60, '2020-05-02', 0, 3, 3),
        (12, 60, '2020-05-03', 0, 3, 3),
        (13, 60, '2020-05-04', 0, 3, 3),
        (14, 60, '2020-05-05', 0, 3, 3),
        
        (15, 60, '2020-05-03', 0, 4, 4),
        (16, 60, '2020-05-04', 0, 4, 4),
        (17, 60, '2020-05-05', 0, 4, 4),
        (18, 60, '2020-05-06', 0, 4, 4),
        (19, 60, '2020-05-07', 0, 4, 4),
        
        (20, 60, '2020-05-03', 0, 5, 5),
        (21, 60, '2020-05-04', 0, 5, 5),
        (22, 60, '2020-05-05', 0, 5, 5),
        (23, 60, '2020-05-06', 0, 5, 5),
        
        (24, 120, '2020-05-06', 0, 6, 6),
        (25, 120, '2020-05-07', 0, 6, 6),
        (26, 120, '2020-05-08', 0, 6, 6),
        (27, 120, '2020-05-09', 0, 6, 6),
        
        (28, 120, '2020-06-07', 0, 7, 7),
        (29, 120, '2020-06-08', 0, 7, 7),
        (30, 120, '2020-06-09', 0, 7, 7),
        (31, 120, '2020-06-10', 0, 7, 7),
        (32, 120, '2020-06-11', 0, 7, 7),
        
        (33, 120, '2020-06-10', 0, 8, 8),
        (34, 120, '2020-06-11', 0, 8, 8),
        (35, 120, '2020-06-12', 0, 8, 8),
        (36, 120, '2020-06-13', 0, 8, 8),
        (37, 120, '2020-06-14', 0, 8, 8),
        
        (38, 120, '2020-06-11', 0, 9, 9),
        (39, 120, '2020-06-12', 0, 9, 9),
        (40, 120, '2020-06-13', 0, 9, 9),
        (41, 120, '2020-06-14', 0, 9, 9),
        (42, 120, '2020-06-15', 0, 9, 9),
        
        (43, 120, '2020-05-18', 0, 10, 10),
        (44, 120, '2020-05-19', 0, 10, 10),
        (45, 120, '2020-05-20', 0, 10, 10),
        (46, 120, '2020-05-21', 0, 10, 10),
        
        (47, 120, '2020-05-17', 0, 11, 11),
        (48, 120, '2020-05-18', 0, 11, 11),
        (49, 120, '2020-05-19', 0, 11, 11),
        (50, 120, '2020-05-20', 0, 11, 11),
        (51, 120, '2020-05-21', 0, 11, 11);

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
VALUES  ('test',        'test',     'Test',         'Customer', '123 College Ave',  'New Brunswick',    'NJ', '08901', '123-456-7890', 'test@test.com',
        ('customer1',   'test',     'John',         'Smith',    '124 College Ave',  'New Brunswick',    'NJ', '08901', '123-456-7890', 'test@test.com',
        ('customer2',   'test123',  'Jessica',      'Jones',    '125 College Ave',  'New Brunswick',    'NJ', '08901', '123-456-7890', 'test@test.com',
        ('customer3',   'test456',  'Saad',         'Muzzy',    '26 East River Rd', 'Clifton',          'NJ', '07516', '123-456-7890', 'test@test.com',
        ('customer4',   'test789',  'Taha',         'Simp',     '27 East River Rd', 'Clifton',          'NJ', '07516', '123-456-7890', 'test@test.com',
        ('customer5',   'test',     'Jeremy',       'Neutron',  '28 East River Rd', 'Clifton',          'NJ', '07516', '123-456-7890', 'test@test.com',
        ('customer6',   'test',     'Gabrielle',    'Johnson',  '4 Yeet Street',    'New Nork',         'NY', '09231', '123-456-7890', 'test@test.com',
        ('customer7',   'test',     'Jason',        'Istired',  '5 Yeet Street',    'New York',         'NY', '09231', '123-456-7890', 'test@test.com',
        ('customer8',   'test',     'Vanessa',      'Customer', '6 Yeet Street',    'New York',         'NY', '09231', '123-456-7890', 'test@test.com',
        ('customer9',   'test',     'Absolute',     'Unit',     '7 Yeet Street',    'New York',         'NY', '09231', '123-456-7890', 'test@test.com',
);

CREATE TABLE employee (
    username VARCHAR(20) NOT NULL,
    password VARCHAR(50) NOT NULL,
    ssn VARCHAR(12) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    is_manager BOOLEAN NOT NULL,
    PRIMARY KEY (username)
);


CREATE TABLE reservation (
    reservation_num INT NOT NULL,
    customer_username VARCHAR(20) NOT NULL,
    origin_station INT NOT NULL,
    destination_station INT NOT NULL,
    total_fare FLOAT NOT NULL,
    seat_num INT NOT NULL,
    seat_class VARCHAR(10) NOT NULL,
    date_made DATE NOT NULL,
    booking_fee FLOAT NOT NULL,
    res_period VARCHAR(10) NOT NULL,
    employee_username VARCHAR(20),
    PRIMARY KEY (reservation_num),
    FOREIGN KEY (customer_username) REFERENCES customer(username) ON DELETE CASCADE,
    FOREIGN KEY (origin_station) REFERENCES station(station_id),
    FOREIGN KEY (destination_station) REFERENCES station(station_id),
    FOREIGN KEY (employee_username) REFERENCES employee(username) ON DELETE SET NULL
);

CREATE TABLE message (
    message_id INT NOT NULL,
    text VARCHAR(MAX) NOT NULL,
    message_time DATETIME() NOT NULL,
    customer_username VARCHAR(20),
    PRIMARY KEY (message_id),
    FOREIGN KEY (customer_username) REFERENCES customer(username) ON DELETE SET NULL
);

CREATE TABLE responds_to (
    employee_username VARCHAR(20),
    message_id INT NOT NULL,
    PRIMARY KEY (employee_username, message_id),
    FOREIGN KEY (employee_username) REFERENCES employee(username) ON DELETE CASCADE,
    FOREIGN KEY (message_id) REFERENCES message(message_id) ON DELETE CASCADE
);
