<?php

namespace MODELS\GEOGRAPHY;
#region COUNTRY
use Exception;
#endregion

class Country
{
    #region FIELDS
    private $id;
    private $name;
    private $code;
    private $telephone;
    #endregion

    #region CONSTRUCT
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

    public function getCode(): string
    {
        return $this->code;
    }

    public function getTelephone(): string
    {
        return $this->telephone;
    }
    #endregion

    #region SETTER
    public function setId(int $id): self
    {
        if ($id <= 0)
            throw new Exception("Country id can't be lower than equal zero");
        $this->id = $id;
        return $this;
    }
    public function setName(string $name): self
    {
        if (empty($name))
            throw new Exception("Country name can't be empty");
        $this->name = $name;
        return $this;
    }

    public function setCode(string $code): self
    {
        if (empty($code))
            throw new Exception("Country code can't be empty");
        if (strlen($code) != 3)
            throw new Exception("Country code must be 3 letters length");
        $this->code = $code;
        return $this;
    }

    public function setTelephone(string $telephone): self
    {
        if (empty($telephone))
            throw new Exception("Country telephone can't be empty");
        $this->telephone = $telephone;
        return $this;
    }
    #endregion

    #region UTILITIES
    public function toArray(): array
    {
        return array(
            "id" => $this->id,
            "name" => $this->name,
            "code" => $this->code,
            "telephone" => $this->telephone
        );
    }
    #endregion
}