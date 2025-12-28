-- Getting city and all it parents.
SELECT 
	c.`id` AS 'city_id', 
	c.`name` AS 'city_name', 
	c.`latitude` AS 'city_latitude', 
	c.`longitude` AS 'city_longitude',
    cd.`id` AS 'cd_id',
    cd.`name` AS 'cd_name',
    ct.`id` AS 'ct_id',
    ct.`name` AS 'ct_name',
    ct.`code` AS 'ct_code'
		FROM tcities c 
			INNER JOIN tcountry_divisions cd 
				ON c.country_division_id = cd.id
			INNER JOIN tcountries ct
				ON cd.country_id = ct.id;
