<?php

namespace MODELS\CORE;

#region REQUIRE
require_once(__DIR__ . "/../database.php");
#endregion

#region USE
use mysqli;
use Exception;
#endregion

/**
 * Class DatabaseConnection
 *
 * Kelas pembungkus (wrapper) untuk mengelola koneksi database MySQLi.
 * Kelas ini menangani inisialisasi dan pemutusan hubungan database
 * menggunakan kredensial yang dirahasiakan
 *
 * @package CORE
 */
class DatabaseConnection
{
    #region FIELDS
    private string $database_address = DATABASE_ADDRESS;
    private string $dtabase_schema = DATABASE_SCHEMA;
    private string $database_username = DATABASE_USERNAME;
    private string $database_password = DATABASE_PASSWORD;
    protected ?mysqli $conn;
    #endregion

    #region CONSTRUCTOR
    public function __construct()
    {
    }
    #endregion

    #region DESTRUCTOR
    public function __destruct()
    {
    }
    #endregion

    #region GETTER
    public function getConnection(): mysqli
    {
        return $this->conn;
    }
    #endregion


    #region BOOTSTRAP
    public function connect()
    {
        if ($this->conn == null) {
            $this->conn = new mysqli(
                $this->database_address,
                $this->database_username,
                $this->database_password,
                $this->dtabase_schema
            );

            if ($this->conn->connect_errno) {
                throw new Exception("Server unable to connect to database: " . $this->conn->connect_error);
            }
        }
        return $this->conn;
    }

    public function close()
    {
        if ($this->conn !== null) {
            $this->conn->close();
            $this->conn = null;
        }
    }
    #endregion
}