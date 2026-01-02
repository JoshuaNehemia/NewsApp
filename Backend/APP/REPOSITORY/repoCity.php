<?php

namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
require_once(__DIR__ . "/../MODELS/CORE/Geolocation.php");
require_once(__DIR__ . "/../MODELS/GEOGRAPHY/City.php");
require_once(__DIR__ . "/../MODELS/GEOGRAPHY/CountryDivision.php");
require_once(__DIR__ . "/../MODELS/GEOGRAPHY/Country.php");
#endregion

#region USE
use MODELS\GEOGRAPHY\City;
use MODELS\GEOGRAPHY\CountryDivision;
use MODELS\GEOGRAPHY\Country;
use MODELS\CORE\DatabaseConnection;
use MODELS\CORE\Geolocation;
use Exception;
#endregion

class repoCity
{

    #region FIELDS
    private DatabaseConnection $db;
    #endregion

    #region CONSTRUCTOR
    public function __construct()
    {
        $this->db = new DatabaseConnection();
    }
    #endregion

    #region SELECT
    public function selectAllCitiesFromDatabase(): array
    {
        $sqlQuery = "SELECT 
                        c.id   AS city_id, 
                        c.name AS city_name, 
                        c.latitude  AS city_latitude, 
                        c.longitude AS city_longitude,
                        cd.id  AS cd_id,
                        cd.name AS cd_name,
                        ct.id  AS ct_id,
                        ct.name AS ct_name,
                        ct.code AS ct_code,
                        ct.telephone AS ct_telephone,
                    FROM tcities c
                    INNER JOIN tcountry_divisions cd ON c.country_division_id = cd.id
                    INNER JOIN tcountries ct ON cd.country_id = ct.id";
        $connection = null;
        $cities = [];
        try {

            $connection = $this->db->connect();
            $stmt = $connection->prepare($sqlQuery);

            if (!$stmt) {
                throw new Exception($connection->error);
            }

            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {

                $country = new Country()
                    ->setId((int) $row["id"])
                    ->setName($row['ct_name'])
                    ->setCode($row['ct_code'])
                    ->setTelephone($row['ct_telephone']);

                $countryDivision = new CountryDivision()
                    ->setId((int) $row['cd_id'])
                    ->setName($row['cd_name'])
                    ->setCountry($country);

                $geolocation = new Geolocation(
                    (float) $row['city_latitude'],
                    (float) $row['city_longitude']
                );

                $city = new City()
                    ->setId((int) $row['city_id'])
                    ->setName($row['city_name'])
                    ->setGeolocation($geolocation);
                    
                $cities[] = $city;
            }
            $stmt->close();
        } catch (Exception $e) {
            throw $e;
        } finally {
            $connection->close();
        }
        return $cities;
    }
    #endregion
}