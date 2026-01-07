<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

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

function sendResponse($status, $message, $data = null) {
    echo json_encode([
        'status' => $status,
        'message' => $message,
        'data' => $data
    ]);
    exit;
}
//nanti hapus 
if (!$input) {
    sendResponse('error', 'Tidak ada data yang dikirim atau format JSON salah');
}

try {
    $user = new User();
    // Username: 6-30 karakter, alfanumerik + underscore
    if (isset($input['username'])) $user->setUsername($input['username']);
    
    // Fullname: 3-100 karakter
    if (isset($input['fullname'])) $user->setFullname($input['fullname']);
    
    // Email: Format email valid
    if (isset($input['email'])) $user->setEmail($input['email']);
    
    // Role: Harus 'USER' (karena kita pakai createUser)
    $user->setRole('USER'); 

    // Profile Picture: Tidak boleh kosong di Account.php
    $defaultPic = isset($input['profile_picture_address']) ? $input['profile_picture_address'] : 'default_user.jpg';
    $user->setProfilePictureAddress($defaultPic);

    // Birthdate: Format YYYY-MM-DD
    if (isset($input['birthdate'])) $user->setBirthdate($input['birthdate']);
    
    // Phone: 8-15 digit
    if (isset($input['phone_number'])) $user->setPhoneNumber($input['phone_number']);
    
    // Gender: MALE, FEMALE, atau OTHER (Sesuai config.php)
    if (isset($input['gender'])) $user->setGender($input['gender']);
    
    // Biography: Maks 500 karakter
    if (isset($input['biography'])) $user->setBiography($input['biography']);

    if (isset($input['country_id'])) {
        $repoCountry = new RepoCountry();
        $foundCountry = $repoCountry->findCountryById((int)$input['country_id']);
        if ($foundCountry) {
            $user->setCountry($foundCountry);
        } else {
            throw new Exception("Country ID " . $input['country_id'] . " Not Found");
        }
    } else {
        throw new Exception("Country ID should field!");
    }

    if (empty($input['password'])) {
        throw new Exception("Password cannot be empty");
    }
    $hashedPassword = password_hash($input['password'], PASSWORD_DEFAULT);


    // 4. Simpan ke Database via RepoAccount
    $repo = new RepoAccount();
    
    // Panggil method createUser (ini akan mengisi tabel accounts DAN users)
    if ($repo->createUser($user, $hashedPassword)) {
        sendResponse('success', 'User berhasil didaftarkan', $user->toArray());
    } else {
        sendResponse('error', 'Gagal mendaftarkan user (mungkin username/email duplikat)');
    }

} catch (Exception $e) {
    http_response_code(400); // Bad Request
    sendResponse('error', $e->getMessage());
}
?>