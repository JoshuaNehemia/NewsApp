<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

require_once '../APP/config.php';
require_once '../APP/MODELS/ACCOUNT/User.php';
require_once '../APP/REPOSITORY/RepoAccount.php';

use REPOSITORY\RepoAccount;

$input = json_decode(file_get_contents('php://input'), true);

if (isset($input['username']) && isset($input['password'])) {
    try {
        $repo = new RepoAccount(); 
        
        $user = $repo->login($input['username'], $input['password']);

        if ($user) {
            echo json_encode([
                'status' => 'success',
                'data' => $user->toArray() 
            ]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Login gagal (Username/Password salah)']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Data email atau password tidak lengkap']);
}
?>