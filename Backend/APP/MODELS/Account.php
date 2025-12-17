<?php

namespace MODELS;

require_once(__DIR__ ."/City.php");
require_once(__DIR__ ."/../CORE/Geolocation.php");

use CORE\Geolocation;
use MODELS\City;

class Account{
    private string $username;
    private string $fullname;
    private string $email;
    private City $city;
    private string $role;
    private Geolocation $current_location;
    private string $profile_picture_address;

}
