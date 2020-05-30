SELECT
    stn_orgn.name as Origin_Station_name,
    stn_dest.name as Destingation_Station_name,
    rt.transit_line_name as Line_Name,
    rt.travel_time as Travel_Time,
    rt.standard_fare as Standard_Fare,
    rt.depart_time AS Departure_Time,
    rt.arrival_time AS Arrival_Time
FROM route rt
 left join station stn_orgn on stn_orgn.id = rt.origin_station_id
 left join station stn_dest on stn_dest.id = rt.destination_station_id
	WHERE 
		stn_orgn.name = 'New York Penn Station'
        or
        stn_dest.name = 'New York Penn Station'
ORDER BY stn_orgn.name;