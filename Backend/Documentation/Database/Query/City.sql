SELECT
    c.id AS city_id,
    c.name AS city_name,
    c.latitude AS city_latitude,
    c.longitude AS city_longitude,
    cd.id AS cd_id,
    cd.name AS cd_name,
    ct.id AS ct_id,
    ct.name AS ct_name,
    ct.code AS ct_code,
    ct.telephone AS ct_telephone
FROM
    cities c
    INNER JOIN country_divisions cd ON c.country_division_id = cd.id
    INNER JOIN countries ct ON cd.country_id = ct.id;