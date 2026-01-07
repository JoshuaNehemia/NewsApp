<?php

namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
require_once(__DIR__ . "/../MODELS/GEOGRAPHY/Country.php");
#endregion

#region USE
use MODELS\CORE\DatabaseConnection;
use MODELS\GEOGRAPHY\Country;
use Exception;
#endregion

class RepoCountry
{
    #region FIELDS
    private DatabaseConnection $db;
    #endregion

    #region CONSTRUCTOR
    public function __construct()
    {
        $this->db = new DatabaseConnection();
    }
    #endregion

    #region RETRIEVE
    public function findCountryById(int $id): ?Country
    {
        $sql = "SELECT id, name, code, telephone FROM countries WHERE id = ? LIMIT 1";
        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare country fetch statement: " . $conn->error);
            }

            $stmt->bind_param("i", $id);

            if ($stmt->execute()) {
                $result = $stmt->get_result();
                if ($row = $result->fetch_assoc()) {
                    $country = new Country();
                    $country->setId((int)$row['id'])
                            ->setName($row['name'])
                            ->setCode($row['code'])
                            ->setTelephone($row['telephone']);
                    return $country;
                }
            }
            return null;
        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) $stmt->close();
            if ($conn) $conn->close();
        }
    }
    #endregion
}