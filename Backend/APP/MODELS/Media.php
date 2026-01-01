<?php

namespace MODELS;

use Exception;

require_once(__DIR__ . "/City.php");

class Media
{
    #region FIELDS
    private int $id;
    private string $name;
    private string $slug;
    private string $company_name;
    private string $type;
    private ?string $logo_address = null;
    private ?string $picture_address = null;
    private ?string $website = null;
    private string $email;
    private ?string $description = null;
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

    public function getLogoAddress(): ?string
    {
        return $this->logo_address;
    }

    public function getPictureAddress(): ?string
    {
        return $this->picture_address;
    }

    public function getWebsite(): ?string
    {
        return $this->website;
    }

    public function getEmail(): string
    {
        return $this->email;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function getCity(): City
    {
        return $this->city;
    }
    #endregion

    #region SETTER
    public function setId(int $id): void
    {
        if ($id < 0) {
            throw new Exception("ID must be a positive integer");
        }
        $this->id = $id;
    }

    public function setName(string $name): void
    {
        if ($name === '') {
            throw new Exception("Name cannot be empty");
        }
        $this->name = $name;
    }

    public function setSlug(string $slug): void
    {
        if ($slug === '') {
            throw new Exception("Slug cannot be empty");
        }
        $this->slug = $slug;
    }

    public function setCompanyName(string $companyName): void
    {
        if ($companyName === '') {
            throw new Exception("Company name cannot be empty");
        }
        $this->company_name = $companyName;
    }

    public function setType(string $type): void
    {
        if ($type === '') {
            throw new Exception("Type cannot be empty");
        }
        $this->type = $type;
    }

    public function setLogoAddress(?string $logoAddress): void
    {
        $this->logo_address = $logoAddress;
    }

    public function setPictureAddress(?string $pictureAddress): void
    {
        $this->picture_address = $pictureAddress;
    }

    public function setWebsite(?string $website): void
    {
        if ($website !== null && !filter_var($website, FILTER_VALIDATE_URL)) {
            throw new Exception("Invalid website URL");
        }
        $this->website = $website;
    }

    public function setEmail(string $email): void
    {
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new Exception("Invalid email address");
        }
        $this->email = $email;
    }

    public function setDescription(?string $description): void
    {
        $this->description = $description;
    }

    public function setCity(City $city): void
    {
        $this->city = $city;
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
            'city' => $this->city->toArray(),
        ];
    }
    #endregion
}
