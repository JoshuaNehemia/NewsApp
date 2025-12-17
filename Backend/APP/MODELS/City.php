<?php

namespace MODELS;

require_once(__DIR__ . "/CountryDivision.php");
require_once(__DIR__ . "/../CORE/Geolocation.php");

use MODELS\CountryDivision;
use CORE\Geolocation;
use Exception;

class City
{
    // Fields
    private int $id;
    private string $name;
    private CountryDivision $country_division;
    private Geolocation $geolocation;

    // Constructor
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

    // Getter
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

    // Setter
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

    public function to_array(): array
    {
        return array(
            "id" => $this->id,
            "name" => $this->name,
            "country_division" => $this->country_division->to_array(),
            "geolocation" => $this->geolocation->to_array()
        );
    }

}