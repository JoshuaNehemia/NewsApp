<?php

namespace MODELS;

#region REQUIRE
require_once(__DIR__ . "/City.php");
require_once(__DIR__ . "/../config.php");
require_once(__DIR__ . "/../CORE/DatabaseConnection.php");
#endregion

#region USE
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

    #region CONSTRUCTOR
    public function __construct(){

    }
    #endregion

    #region GETTER

    #endregion

    #region SETTER

    #endregion
}