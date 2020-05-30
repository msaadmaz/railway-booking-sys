-- username is already known,
-- LOOKUP all that users reservations so the rep can cancel or edit them
SELECT
	rsv.res_num AS reservation_res_num,
    rsv.customer_username AS rsv_username,
    stn_origin.name AS stn_origin_name,
    stn_destination.name AS stn_destination_name,
    rt.depart_time AS route_depart_time,
    rt.arrival_time AS route_arrival_time,
    rsv.seat_num AS reservation_seat,
    rsv.date_made AS reservation_date_made
FROM reservation rsv
		LEFT JOIN station stn_origin on rsv.origin_station = stn_origin.id
		LEFT JOIN station stn_destination on rsv.destination_station = stn_destination.id
        LEFT JOIN trip trp on rsv.trip_id = trp.id
        LEFT JOIN route rt on trp.route_id = rt.id
WHERE
	rsv.customer_username = 'customer1';
        