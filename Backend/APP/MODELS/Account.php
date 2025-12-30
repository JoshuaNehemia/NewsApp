<?php

namespace MODELS;

#region REQUIRE
require_once(__DIR__ . "/City.php");
require_once(__DIR__ . "/../config.php");
require_once(__DIR__ . "/../CORE/Geolocation.php");
#endregion

#region USE
use CORE\Geolocation;
use MODELS\City;
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
    private Geolocation $currentUserLocation;
    #endregion

    #region CONSTRUCTOR
    public function __construct(
        ?string $username = null,
        ?string $fullname = null,
        ?string $email = null,
        ?City $city = null,
        ?string $role = null,
        ?string $profile_picture_address = null,
        ?Geolocation $currentUserLocation = null
    ) {
        if ($username !== null)
            $this->setUsername($username);
        if ($fullname !== null)
            $this->setFullname($fullname);
        if ($email !== null)
            $this->setEmail($email);
        if ($city !== null)
            $this->setCity($city);
        if ($role !== null)
            $this->setRole($role);
        if ($profile_picture_address !== null)
            $this->setProfilePictureAddress($profile_picture_address);
        if ($currentUserLocation !== null)
            $this->setCurrentUserLocation($currentUserLocation);
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
    public function getCurrentUserLocation(): Geolocation
    {
        return $this->currentUserLocation;
    }
    #endregion

    #region SETTERS
    public function setUsername(string $username): self
    {
        $username = trim($username);

        if ($username === '')
            throw new Exception("Username cannot be empty");

        if (!preg_match('/^[a-zA-Z0-9_]$/', $username))
            throw new Exception("Username must contain only letters, numbers, and underscores");

        if (strlen($username) < 6 || strlen($username) > USERNAME_MAX_LENGTH)
            throw new Exception("Username length must between 6 - 30 digits");

        $this->username = $username;
        return $this;
    }

    public function setFullname(string $fullname): self
    {
        $fullname = trim($fullname);
        if (strlen($fullname) < 3 || strlen($fullname) > 200) {
            throw new Exception("Full name must be between 3 and 100 characters");
        }
        $this->fullname = $fullname;
        return $this;
    }

    public function setEmail(string $email): self
    {
        $email = trim($email);
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new Exception("Invalid email format");
        }
        $this->email = $email;
        return $this;
    }

    public function setCity(City $city): self
    {
        $this->city = $city;
        return $this;
    }

    public function setRole(string $role): self
    {
        if (!in_array($role, ACCOUNT_ROLES, true))
            throw new Exception("Invalid role");
        $this->role = $role;
        return $this;
    }

    public function setProfilePictureAddress(string $address): self
    {
        $address = trim($address);
        if ($address === '')
            throw new Exception("Profile picture address cannot be empty");

        $this->profile_picture_address = $address;
        return $this;
    }

    public function setCurrentUserLocation(Geolocation $location): self
    {
        $this->currentUserLocation = $location;
        return $this;
    }
    #endregion

    #region DATABASE

    #endregion
}
