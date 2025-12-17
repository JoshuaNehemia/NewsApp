<?php

namespace CORE;

require_once(__DIR__ . "/../database.php");

use mysqli;
use Exception;

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

    private $database_address = DATABASE_ADDRESS;
    private $dtabase_schema = DATABASE_SCHEMA;
    private $database_username = DATABASE_USERNAME;
    private $database_password = DATABASE_PASSWORD;
    protected $conn;

    public function __construct(){}
    public function __destruct(){}

    protected function startConnection()
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
    }

    protected function closeConnection()
    {
        if ($this->conn !== null) {
            $this->conn->close();
            $this->conn = null;
        }
    }
}