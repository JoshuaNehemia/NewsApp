<?php

namespace MODELS;

require_once(__DIR__ . "/City.php");
require_once(__DIR__ . "/Account.php");
require_once(__DIR__ . "/../CORE/Geolocation.php");

use MODELS\Account;
use CORE\Geolocation;
use Exception;

class User extends Account
{
    #region FIELDS
    private string $birthdate;
    private string $phone_number;
    private string $gender;
    private string $biography;
    #endregion

    #region CONSTRUCTOR
    public function __construct(
        ?string $username = null,
        ?string $fullname = null,
        ?string $email = null,
        ?City $city = null,
        ?string $role = null,
        ?string $profile_picture_address = null,
        ?Geolocation $currentUserLocation = null,
        ?string $birthdate = null,
        ?string $phone_number = null,
        ?string $gender = null,
        ?string $biography = null
    ) {
        parent::__construct(
            $username,
            $fullname,
            $email,
            $city,
            $role,
            $profile_picture_address,
            $currentUserLocation
        );

        if ($birthdate !== null)
            $this->setBirthdate($birthdate);
        if ($phone_number !== null)
            $this->setPhoneNumber($phone_number);
        if ($gender !== null)
            $this->setGender($gender);
        if ($biography !== null)
            $this->setBiography($biography);
    }
    #endregion

    #region GETTERS
    public function getBirthdate(): string
    {
        return $this->birthdate;
    }

    public function getPhoneNumber(): string
    {
        return $this->phone_number;
    }

    public function getGender(): string
    {
        return $this->gender;
    }

    public function getBiography(): string
    {
        return $this->biography;
    }
    #endregion

    #region SETTERS
    public function setBirthdate(string $birthdate): self
    {
        if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $birthdate))
            throw new Exception("Birthdate must be in YYYY-MM-DD format");

        if (strtotime($birthdate) >= time())
            throw new Exception("Birthdate must be in the past");

        $this->birthdate = $birthdate;
        return $this;
    }

    public function setPhoneNumber(string $phone_number): self
    {
        $phone_number = preg_replace('/\s+/', '', $phone_number);
        if (!preg_match('/^[0-9]{8,15}$/', $phone_number))
            throw new Exception("Phone number must contain 8–15 digits");
        $this->phone_number = $phone_number;
        return $this;
    }

    public function setGender(string $gender): self
    {
        if (!in_array($gender, USER_GENDERS, true)) 
            throw new Exception("Invalid gender value");
        $this->gender = $gender;
        return $this;
    }

    public function setBiography(string $biography): self
    {
        $biography = trim($biography);
        if (strlen($biography) > 500)
            throw new Exception("Biography must not exceed 500 characters");
        $this->biography = $biography;
        return $this;
    }
    #endregion
}
