<?php

namespace MODELS;
use Exception;

class Country
{
    // Fields
    private $id;
    private $name;
    private $code;

    // Constructor
    public function __construct(int $id = null, string $name = null, string $code = null)
    {
        if ($this->id != null)
            $this->setId($id);
        if ($name != null)
            $this->setName($name);
        if ($code != null)
            $this->setCode($code);
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

    public function getCode(): string
    {
        return $this->code;
    }

    // Setter
    public function setId(int $id): Country
    {
        if ($id <= 0)
            throw new Exception("Country id can't be lower than equal zero");
        $this->id = $id;
        return $this;
    }
    public function setName(string $name): Country
    {
        if (empty($name))
            throw new Exception("Country name can't be empty");
        $this->name = $name;
        return $this;
    }

    public function setCode(string $code): Country
    {
        if (empty($code))
            throw new Exception("Country code can't be empty");
        if (strlen($code) != 3)
            throw new Exception("Country code must be 3 letters length");
        $this->code = $code;
        return $this;
    }

    public function to_array(): array
    {
        return array(
            "id"=>$this->id,
            "name"=>$this->name,
            "code"=>$this->code
        );
    }
}