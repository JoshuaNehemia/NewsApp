<?php

namespace MODELS;

require_once(__DIR__ . "/Country.php");

use MODELS\Country;
use Exception;

class CountryDivision
{
    // Fields
    private int $id;
    private string $name;
    private Country $country;

    // Constructor
    public function __construct(int $id = null, string $name = null, Country $country = null)
    {
        if($id != null) $this->setId($id);
        if($name != null) $this->setName($name);
        if($country != null) $this->setCountry($country);
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

    public function getCountry(): Country
    {
        return $this->country;
    }

    // Setter
    public function setId(int $id): CountryDivision
    {
        if($id <=0) throw new Exception("CountryDivision id can't be lower than equal 0");
        $this->id = $id;
        return $this;
    }

    public function setName(string $name): CountryDivision
    {
        if(empty($name)) throw new Exception("CountryDivision name can't be empty");
        $this->name = $name;
        return $this;
    }

    public function setCountry(Country $country): CountryDivision
    {
        if($country == null) throw new Exception("CountryDivision country can't be null");
        $this->country = $country;
        return $this;
    }

    public function to_array(): array
    {
        return array(
            "id" => $this->id,
            "name" => $this->name,
            "country" => $this->country->to_array()
        );
    }

}