<?php

namespace MODELS\ACCOUNT;

#region REQUIRE
require_once(__DIR__ . "/../GEOGRAPHY/City.php");
#endregion

#region USE
use MODELS\GEOGRAPHY\City;
use Exception;
#endregion

class Media
{
    #region FIELDS
    private int $id;
    private string $name;
    private string $slug;
    private string $company_name;
    private string $type;
    private string $logo_address;
    private string $picture_address;
    private string $website;
    private string $email;
    private string $description;
    private City $city;
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

    public function getSlug(): string
    {
        return $this->slug;
    }

    public function getCompanyName(): string
    {
        return $this->company_name;
    }

    public function getType(): string
    {
        return $this->type;
    }

    public function getLogoAddress(): string
    {
        return $this->logo_address;
    }

    public function getPictureAddress(): string
    {
        return $this->picture_address;
    }

    public function getWebsite(): string
    {
        return $this->website;
    }

    public function getEmail(): string
    {
        return $this->email;
    }

    public function getDescription(): string
    {
        return $this->description;
    }

    public function getCity(): City
    {
        return $this->city;
    }
    #endregion

    #region SETTER
    public function setId(int $id): self
    {
        if ($id < 0) {
            throw new Exception("Media id must be a positive integer");
        }
        $this->id = $id;
        return $this;
    }

    public function setName(string $name): self
    {
        if ($name === '') {
            throw new Exception("Media name cannot be empty");
        }
        $this->name = $name;
        return $this;
    }

    public function setSlug(string $slug): self
    {
        if ($slug === '') {
            throw new Exception("Media slug cannot be empty");
        }
        $this->slug = $slug;
        return $this;
    }

    public function setCompanyName(string $companyName): self
    {
        if ($companyName === '') {
            throw new Exception("Media company name cannot be empty");
        }
        $this->company_name = $companyName;
        return $this;
    }

    public function setType(string $type): self
    {
        if ($type === '') {
            throw new Exception("Media type cannot be empty");
        }
        $this->type = $type;
        return $this;
    }

    public function setLogoAddress(?string $logoAddress): self
    {
        $this->logo_address = $logoAddress;
        return $this;
    }

    public function setPictureAddress(?string $pictureAddress): self
    {
        $this->picture_address = $pictureAddress;
        return $this;
    }

    public function setWebsite(?string $website): self
    {
        if (empty($website))
            throw new Exception("Media website can't be empty");
        if ($website !== null && !filter_var($website, FILTER_VALIDATE_URL)) {
            throw new Exception("Media have an invalid website URL");
        }
        $this->website = $website;
        return $this;
    }

    public function setEmail(string $email): self
    {
        if (empty($website))
            throw new Exception("Media email can't be empty");
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new Exception("Media have an invalid email address");
        }
        $this->email = $email;
        return $this;
    }

    public function setDescription(?string $description): self
    {
        $this->description = $description;
        return $this;
    }

    public function setCity(City $city): self
    {
        $this->city = $city;
        return $this;
    }
    #endregion

    #region UTILITIES
    public function toArray(): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'slug' => $this->slug,
            'company_name' => $this->company_name,
            'type' => $this->type,
            'logo_address' => $this->logo_address,
            'picture_address' => $this->picture_address,
            'website' => $this->website,
            'email' => $this->email,
            'description' => $this->description,
            'city' => $this->city->toArray()
        ];
    }
    #endregion
}
