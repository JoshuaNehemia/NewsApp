<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Handle preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../APP/config.php';
require_once '../APP/MODELS/ACCOUNT/User.php';
require_once '../APP/MODELS/GEOGRAPHY/Country.php';
require_once '../APP/REPOSITORY/RepoAccount.php';
require_once '../APP/REPOSITORY/RepoCountry.php';

use REPOSITORY\RepoAccount;
use MODELS\ACCOUNT\User;
use MODELS\GEOGRAPHY\Country;
use REPOSITORY\RepoCountry;

$input = json_decode(file_get_contents('php://input'), true);

try {
    // Check if username or email already exists
    $repo = new RepoAccount();
    if ($repo->findAccountByUsername($input['username'] ?? '')) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => "Username sudah terdaftar!"
        ]);
        exit;
    }
    if ($repo->findAccountByEmail($input['email'] ?? '')) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => "Email sudah terdaftar!"
        ]);
        exit;
    }

    $user = new User();
    if (isset($input['username'])) $user->setUsername($input['username']);
    if (isset($input['fullname'])) $user->setFullname($input['fullname']);
    if (isset($input['email'])) $user->setEmail($input['email']);
    $user->setRole('USER'); 
    $defaultPic = isset($input['profile_picture_address']) ? $input['profile_picture_address'] : "";
    $user->setProfilePictureAddress($defaultPic);
    if (isset($input['birthdate'])) $user->setBirthdate($input['birthdate']);
    if (isset($input['phone_number'])) $user->setPhoneNumber($input['phone_number']);
    if (isset($input['gender'])) $user->setGender($input['gender']);
    if (isset($input['biography'])) $user->setBiography($input['biography']);
    if (!empty($input['country_id']) && $input['country_id'] !== null) {
        $repoCountry = new RepoCountry();
        $foundCountry = $repoCountry->findCountryById((int)$input['country_id']);
        if ($foundCountry) {
            $user->setCountry($foundCountry);
        } else {
            http_response_code(400);
            echo json_encode([
                'status' => 'error',
                'message' => "Country ID " . $input['country_id'] . " Not Found"
            ]);
            exit;
        }
    }

    if (empty($input['password'])) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => "Password cannot be empty"
        ]);
        exit;
    }
    $hashedPassword = password_hash($input['password'], PASSWORD_DEFAULT);
    $repo = new RepoAccount();
    if ($repo->createUser($user, $hashedPassword)) {
        echo json_encode([
            'status' => 'success',
            'message' => 'User berhasil didaftarkan',
            'data' => $user->toArray()
        ]);
    } else {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'Gagal mendaftarkan user (mungkin username/email duplikat)'
        ]);
    }

} catch (Exception $e) {
    http_response_code(400);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}