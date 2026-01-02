<?php

namespace MODELS\GEOGRAPHY;

require_once(__DIR__ . "/Country.php");

use MODELS\GEOGRAPHY\Country;
use Exception;

class CountryDivision
{
    // Fields
    private int $id;
    private string $name;
    private Country $country;

    // Constructor
    public function __construct()
    {
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
    public function setId(int $id): self
    {
        if($id <=0) throw new Exception("CountryDivision id can't be lower than equal 0");
        $this->id = $id;
        return $this;
    }

    public function setName(string $name): self
    {
        if(empty($name)) throw new Exception("CountryDivision name can't be empty");
        $this->name = $name;
        return $this;
    }

    public function setCountry(Country $country): self
    {
        if($country == null) throw new Exception("CountryDivision country can't be null");
        $this->country = $country;
        return $this;
    }

    public function toArray(): array
    {
        return array(
            "id" => $this->id,
            "name" => $this->name,
            "country" => $this->country->toArray()
        );
    }

}