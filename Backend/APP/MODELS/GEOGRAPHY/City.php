<?php

namespace MODELS\GEOGRAPHY;

require_once(__DIR__ . "/CountryDivision.php");
require_once(__DIR__ . "/../CORE/Geolocation.php");
require_once(__DIR__ . "/../CORE/DatabaseConnection.php");

use MODELS\GEOGRAPHY\CountryDivision;
use MODELS\CORE\Geolocation;
use Exception;

class City
{
    #region FIELDS
    private int $id;
    private string $name;
    private CountryDivision $country_division;
    private Geolocation $geolocation;
    #endregion

    #region CONSTRUCTOR
    public function __construct()
    {
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

    public function getCountryDivision(): CountryDivision
    {
        return $this->country_division;
    }

    public function getGeolocation(): Geolocation
    {
        return $this->geolocation;
    }
    #endregion

    #region SETTER
    public function setId(int $id): self
    {
        if ($id <= 0)
            throw new Exception("City id can't be lower than equal 0");
        $this->id = $id;
        return $this;
    }

    public function setName(string $name): self
    {
        if (empty($name))
            throw new Exception("City name can't be empty");
        $this->name = $name;
        return $this;
    }

    public function setCountryDivision(CountryDivision $country_division): self
    {
        $this->country_division = $country_division;
        return $this;
    }

    public function setGeolocation(Geolocation $geolocation): self
    {
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

}