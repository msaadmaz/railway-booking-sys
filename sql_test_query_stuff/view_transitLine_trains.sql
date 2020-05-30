SELECT 
	rt.transit_line_name, 
	trn.id
FROM
	route rt
	left join train trn on rt.id = trn.route_id
	