<?php

namespace MODELS;

require_once(__DIR__ . "/CountryDivision.php");
require_once(__DIR__ . "/../CORE/Geolocation.php");
require_once(__DIR__ . "/../CORE/DatabaseConnection.php");

use MODELS\CountryDivision;
use CORE\Geolocation;
use CORE\DatabaseConnection;
use Exception;

class City extends DatabaseConnection
{
    #region FIELDS
    private int $id;
    private string $name;
    private CountryDivision $country_division;
    private Geolocation $geolocation;
    #endregion

    #region CONSTRUCTOR
    public function __construct(int $id = null, string $name = null, CountryDivision $country_division = null, Geolocation $geolocation = null)
    {
        if ($id != null)
            $this->setId($id);
        if ($name != null)
            $this->setName($name);
        if ($country_division != null)
            $this->setCountryDivision($country_division);
        if ($geolocation != null)
            $this->setGeolocation($geolocation);
    }
    #endregion

    #region GETTER
    public function getId(): int
    {
        return $this->id;
    }
    public function getName(): string
    {
        return $this->name;
    }

    public function getCountry(): CountryDivision
    {
        return $this->country_division;
    }

    public function getGeolocation(): Geolocation
    {
        return $this->geolocation;
    }
    #endregion

    #region SETTER
    public function setId(int $id): City
    {
        if ($id <= 0)
            throw new Exception("City id can't be lower than equal 0");
        $this->id = $id;
        return $this;
    }

    public function setName(string $name): City
    {
        if (empty($name))
            throw new Exception("City name can't be empty");
        $this->name = $name;
        return $this;
    }

    public function setCountryDivision(CountryDivision $country_division): City
    {
        if ($country_division == null)
            throw new Exception("City country_division can't be null");
        $this->country_division = $country_division;
        return $this;
    }

    public function setGeolocation(Geolocation $geolocation): City
    {
        if ($geolocation == null)
            throw new Exception("City geolocation can't be empty");
        $this->geolocation = $geolocation;
        return $this;
    }
    #endregion

    #region FUNCTION
    public function toArray(): array
    {
        return array(
            "id" => $this->id,
            "name" => $this->name,
            "country_division" => $this->country_division->toArray(),
            "geolocation" => $this->geolocation->toArray()
        );
    }
    #endregion

    #region DATABASE
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
                        ct.code AS ct_code
                    FROM tcities c
                    INNER JOIN tcountry_divisions cd ON c.country_division_id = cd.id
                    INNER JOIN tcountries ct ON cd.country_id = ct.id";

        $cities = [];
        try {

            $this->startConnection();
            $stmt = $this->conn->prepare($sqlQuery);

            if (!$stmt) {
                throw new Exception($this->conn->error);
            }

            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {

                $country = new Country(
                    (int) $row['ct_id'],
                    $row['ct_name'],
                    $row['ct_code']
                );

                $countryDivision = new CountryDivision(
                    (int) $row['cd_id'],
                    $row['cd_name'],
                    $country
                );

                $geolocation = new Geolocation(
                    (float) $row['city_latitude'],
                    (float) $row['city_longitude']
                );

                $city = new City(
                    (int) $row['city_id'],
                    $row['city_name'],
                    $countryDivision,
                    $geolocation
                );
                $cities[] = $city;
            }
            $stmt->close();
        } catch (Exception $e) {
            throw $e;
        } finally {
            $this->closeConnection();
        }
        return $cities;
    }
    #endregion

}