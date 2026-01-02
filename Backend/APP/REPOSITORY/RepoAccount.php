<?php

namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/ACCOUNT/Account.php");
require_once(__DIR__ . "/../MODELS/ACCOUNT/Media.php");
require_once(__DIR__ . "/../MODELS/ACCOUNT/User.php");
require_once(__DIR__ . "/../MODELS/ACCOUNT/Writer.php");
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
#endregion

#region USE

use Exception;
use MODELS\ACCOUNT\Account;
use MODELS\ACCOUNT\uSER;
use MODELS\ACCOUNT\Writer;
use MODELS\ACCOUNT\Media;
use MODELS\CORE\DatabaseConnection;
#endregion

class RepoAccount
{
    #region FIELDS
    private $db;
    #endregion

    #region CONSTRUCTOR
    public function __construct()
    {
        $this->db = new DatabaseConnection();
    }
    #endregion

    #region LOGIN
    public function login(string $username, string $password)
    {
        $sqlQuery = "
        SELECT
            a.username,
            a.password,
            a.fullname,
            a.email,
            a.role,
            a.is_active,
            a.locked_until,

            u.birthdate         AS user_birthdate,
            u.gender            AS user_gender,
            u.phone_number      AS user_phone_number,
            u.biography         AS user_biography,

            cu.id               AS user_country_id,
            cu.code             AS user_country_code,
            cu.name             AS user_country_name,
            cu.telephone        AS user_country_telephone,

            w.biography         AS writer_biography,
            w.is_verified       AS writer_is_verified,

            m.id                AS media_id,
            m.name              AS media_name,
            m.slug              AS media_slug,
            m.company_name      AS media_company_name,
            m.media_type        AS media_type,
            m.picture_ext       AS media_picture_ext,
            m.logo_ext          AS media_logo_ext,
            m.website           AS media_website,
            m.email             AS media_email,
            m.description       AS media_description,

            ct.id               AS media_city_id,
            ct.name             AS media_city_name,
            ct.latitude         AS media_city_latitude,
            ct.longitude        AS media_city_longitude,

            cd.id               AS media_country_division_id,
            cd.name             AS media_country_division_name,

            cm.id               AS media_country_id,
            cm.code             AS media_country_code,
            cm.name             AS media_country_name

        FROM accounts a
        LEFT JOIN users u
            ON u.username = a.username AND a.role = 'user'
        LEFT JOIN countries cu
            ON cu.id = u.country_id
        LEFT JOIN writers w
            ON w.username = a.username AND a.role = 'writer'
        LEFT JOIN medias m
            ON m.id = w.media_id
        LEFT JOIN cities ct
            ON ct.id = m.city_id
        LEFT JOIN country_divisions cd
            ON cd.id = ct.country_division_id
        LEFT JOIN countries cm
            ON cm.id = cd.country_id
        WHERE a.username = ?
        LIMIT 1
    ";

        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sqlQuery);

            if (!$stmt) {
                throw new Exception($connection->error);
            }

            $stmt->bind_param("s", $username);
            $stmt->execute();

            $result = $stmt->get_result();
            $row = $result->fetch_assoc();

            if (!$row) {
                throw new Exception("Invalid username or password");
            }

            if (!password_verify($password, $row['password'])) {
                throw new Exception("Invalid username or password");
            }

            //if (!$row['is_active']) {
                //throw new Exception("Account is inactive");
            //}

            //if ($row['locked_until'] !== null && strtotime($row['locked_until']) > time()) {
             //   throw new Exception("Account is temporarily locked");
            //}

            $account = new Account();
            $account->setUsername($row['username'])
                ->setFullname($row['fullname'])
                ->setEmail($row['email'])
                ->setRole($row['role']);

            if ($row['role'] === 'user') {

                $country = null;
                if ($row['user_country_id']) {
                    $country = (new Country())
                        ->setId((int) $row['user_country_id'])
                        ->setCode($row['user_country_code'])
                        ->setName($row['user_country_name'])
                        ->setTelephone($row['user_country_telephone']);
                }

                $user = (new User())
                    ->setAccount($account)
                    ->setBirthdate($row['user_birthdate'])
                    ->setGender($row['user_gender'])
                    ->setPhoneNumber($row['user_phone_number'])
                    ->setBiography($row['user_biography'])
                    ->setCountry($country);

                return $user;
            }

            if ($row['role'] === 'writer') {

                $country = (new Country())
                    ->setId((int) $row['media_country_id'])
                    ->setCode($row['media_country_code'])
                    ->setName($row['media_country_name']);

                $countryDivision = (new CountryDivision())
                    ->setId((int) $row['media_country_division_id'])
                    ->setName($row['media_country_division_name'])
                    ->setCountry($country);

                $city = (new City())
                    ->setId((int) $row['media_city_id'])
                    ->setName($row['media_city_name'])
                    ->setGeolocation(
                        new Geolocation(
                            (float) $row['media_city_latitude'],
                            (float) $row['media_city_longitude']
                        )
                    )
                    ->setCountryDivision($countryDivision);

                $media = (new Media())
                    ->setId((int) $row['media_id'])
                    ->setName($row['media_name'])
                    ->setSlug($row['media_slug'])
                    ->setCompanyName($row['media_company_name'])
                    ->setType($row['media_type'])
                    ->setWebsite($row['media_website'])
                    ->setEmail($row['media_email'])
                    ->setDescription($row['media_description'])
                    ->setCity($city);

                $writer = (new Writer())
                    ->setAccount($account)
                    ->setBiography($row['writer_biography'])
                    ->setIsVerified((bool) $row['writer_is_verified'])
                    ->setMedia($media);

                return $writer;
            }

            throw new Exception("Unknown account role");

        } finally {
            $this->db->close();
        }
    }

    #endregion
}