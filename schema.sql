CREATE TABLE stations (
    station_id INT NOT NULL,
    state VARCHAR(15),
    name VARCHAR(30),
    city VARCHAR(30)
);

INSERT INTO stations
VALUES  (1, 'NJ', 'New Brunswick Train Station', 'New Brunswick'),
        (2, 'NY', 'New York Penn Station', 'New York'),
        (3, 'PA', 'Philadelphia Train Station', 'Philadelphia'),
        (4, 'NJ', 'Clifton Train Station', 'Clifton'),
        (5, 'NJ', 'Burlington River Line', 'Burlington');

CREATE TABLE routes (
    route_id INT NOT NULL,
    transit_line_name VARCHAR(30),
    travel_time INT,
    standard_fare FLOAT,
    depart_time TIME,
    arrival_time TIME,
    origin_station_id INT NOT NULL,
    destination_station_id INT NOT NULL,
    PRIMARY KEY (route_id),
    FOREIGN KEY (origin_station_id) REFERENCES stations(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES stations(station_id)
);

INSERT INTO routes
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
    station_id INT,
    arrival_time TIME,
    departure_time TIME,
    PRIMARY KEY (route_id, station_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (station_id) REFERENCES stations(station_id)
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
        

CREATE TABLE trains (
    train_id INT NOT NULL,
    total_seats INT,
    total_cars INT,
    route_id INT,
    PRIMARY KEY (train_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id)
);

/*
INSERT INTO trains
VALUES (1, 60, 3);
*/

CREATE TABLE trips (
    trip_id INT NOT NULL,
    available_seats INT,
    trip_date DATE,
    delay INT,
    route_id INT,
    train_id INT,
    PRIMARY KEY (trip_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (train_id) REFERENCES train(train_id)
);

CREATE TABLE reservations (
    reservation_num INT NOT NULL,
    total_fare FLOAT,
    seat_num INT,
    seat_class VARCHAR(10),
    date_made DATE,
    booking_fee FLOAT,
    res_period VARCHAR(10),
    customer_username VARCHAR(20),
    employee_username VARCHAR(20),
    PRIMARY KEY (reservation_num),
    FOREIGN KEY (customer_username) REFERENCES customers(username),
    FOREIGN KEY (employee_username) REFERENCES employees(username)
);

CREATE TABLE reserves_seat (
    reservation_num INT NOT NULL,
    trip_id INT NOT NULL,
    PRIMARY KEY (reservation_num, trip_id),
    FOREIGN KEY (reservation_num) REFERENCES reservations(reservation_num),
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
);

CREATE TABLE customers (
    username VARCHAR(20) NOT NULL,
    password VARCHAR(50) NOT NULL,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    address VARCHAR(30),
    city VARCHAR(20),
    state VARCHAR(15),
    zip INT,
    phone VARCHAR(15),
    email VARCHAR(30),
    PRIMARY KEY (username)
);

CREATE TABLE messages (
    message_id INT NOT NULL,
    text VARCHAR(MAX) NOT NULL,
    message_time DATETIME(),
    customer_username VARCHAR(20),
    employee_username VARCHAR(20),
    PRIMARY KEY (message_id),
    FOREIGN KEY (customer_username) REFERENCES customers(username)
);

CREATE TABLE employees (
    username VARCHAR(20),
    password VARCHAR(50),
    ssn VARCHAR(12),
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    is_manager BOOLEAN
);

CREATE TABLE responds_to (
    employee_username VARCHAR(20),
    message_id INT,
    PRIMARY KEY (employee_username, message_id),
    FOREIGN KEY (employee_username) REFERENCES employees(username),
    FOREIGN KEY (message_id) REFERENCES messages(message_id)
);
