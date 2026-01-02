<?php

namespace MODELS\ACCOUNT;

#region REQUIRE
require_once(__DIR__ . "/../GEOGRAPHY/City.php");
require_once(__DIR__ . "/../../config.php");
#endregion

#region USE
use MODELS\GEOGRAPHY\City;
use Exception;
#endregion

class Account
{
    #region FIELDS
    private string $username;
    private string $fullname;
    private string $email;
    private City $city;
    private string $role;
    private string $profile_picture_address;
    private bool $is_subscribing;
    #endregion

    #region CONSTRUCTOR
    public function __construct(
    ) {
    }
    #endregion

    #region GETTERS
    public function getUsername(): string
    {
        return $this->username;
    }
    public function getFullname(): string
    {
        return $this->fullname;
    }
    public function getEmail(): string
    {
        return $this->email;
    }
    public function getCity(): City
    {
        return $this->city;
    }
    public function getRole(): string
    {
        return $this->role;
    }
    public function getProfilePictureAddress(): string
    {
        return $this->profile_picture_address;
    }

    public function getIsSubscribing(): bool
    {
        return $this->is_subscribing;
    }
    #endregion

    #region SETTERS
    public function setUsername(string $username): self
    {
        $username = trim($username);

        if ($username === '')
            throw new Exception("Account username cannot be empty");

        if (!preg_match('/^[a-zA-Z0-9_]$/', $username))
            throw new Exception("Account username must contain only letters, numbers, and underscores");

        if (strlen($username) < 6 || strlen($username) > USERNAME_MAX_LENGTH)
            throw new Exception("Account username length must between 6 - 30 digits");

        $this->username = $username;
        return $this;
    }

    public function setFullname(string $fullname): self
    {
        $fullname = trim($fullname);
        if (strlen($fullname) < 3 || strlen($fullname) > 200) {
            throw new Exception("Account full name must be between 3 and 100 characters");
        }
        $this->fullname = $fullname;
        return $this;
    }

    public function setEmail(string $email): self
    {
        $email = trim($email);
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new Exception("Account have an invalid email format");
        }
        $this->email = $email;
        return $this;
    }

    public function setCity(City $city): self
    {
        if(!($city instanceof City)) throw new Exception("Account city must be an instance of City");
        $this->city = $city;
        return $this;
    }

    public function setRole(string $role): self
    {
        if (!in_array($role, ACCOUNT_ROLES, true))
            throw new Exception("Account have an invalid role");
        $this->role = $role;
        return $this;
    }

    public function setProfilePictureAddress(string $address): self
    {
        $address = trim($address);
        if ($address === '')
            throw new Exception("Account profile picture address cannot be empty");

        $this->profile_picture_address = $address;
        return $this;
    }


    public function setIsSubscribing(bool $is_subscribing): self
    {
        $this->is_subscribing = $is_subscribing;
        return $this;
    }
    #endregion

    #region UTILITIES
    public function toArray(): array
    {
        return [
            'username' => $this->username,
            'fullname' => $this->fullname,
            'email' => $this->email,
            'city' => $this->city->toArray(),
            'role' => $this->role,
            'profile_picture_address' => $this->profile_picture_address
        ];
    }
    #endregion
}
