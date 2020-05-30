SELECT 
	cst.first_name, 
    cst.last_name,
    rsv.trip_id AS Reservation_trip_id,
    trp.id AS Trip_id,
    rt.transit_line_name AS Route_transit_line_name,
    trp.train_id AS Train_id
FROM reservation rsv
		LEFT JOIN customer cst on rsv.customer_username = cst.username
        LEFT JOIN trip trp on rsv.trip_id = trp.id
        LEFT JOIN route rt on trp.route_id = rt.id
WHERE
	trp.train_id = 1001
    AND
    rt.transit_line_name = 'North Line'
ORDER BY cst.last_name;
    