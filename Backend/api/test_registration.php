<?php
header("Content-Type: application/json; charset=UTF-8");

echo "=== Testing Registration with NULL country_id ===\n\n";

// Test 1: Register with NULL country_id
echo "Test 1: Registration with country_id = null\n";
echo "----------------------------------------\n";

$data1 = [
    'username' => 'testuser_' . time(),
    'password' => '12345678',
    'fullname' => 'Test Null Country',
    'email' => 'test_' . time() . '@example.com',
    'birthdate' => '2000-01-15',
    'gender' => 'MALE',
    'phone_number' => '08123456789',
    'biography' => 'Testing null country',
    'country_id' => null,
    'profile_picture_address' => 'default.png'
];

$ch = curl_init('http://localhost/NewsApp2/Backend/api/register.php');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data1));

$response1 = curl_exec($ch);
$httpCode1 = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

echo "HTTP Status: $httpCode1\n";
echo "Response: " . ($response1 ? $response1 : 'No response') . "\n\n";

// Test 2: Get countries to check if endpoint works
echo "Test 2: Get Countries Endpoint\n";
echo "----------------------------------------\n";

$ch2 = curl_init('http://localhost/NewsApp2/Backend/api/get_countries.php');
curl_setopt($ch2, CURLOPT_RETURNTRANSFER, true);

$response2 = curl_exec($ch2);
$httpCode2 = curl_getinfo($ch2, CURLINFO_HTTP_CODE);
curl_close($ch2);

echo "HTTP Status: $httpCode2\n";
echo "Response: " . ($response2 ? substr($response2, 0, 200) . '...' : 'No response') . "\n\n";

// Test 3: If countries exist, try registering with a valid country_id  
$countriesData = json_decode($response2, true);
if ($countriesData && isset($countriesData['data']) && count($countriesData['data']) > 0) {
    echo "Test 3: Registration with valid country_id\n";
    echo "----------------------------------------\n";
    
    $firstCountryId = $countriesData['data'][0]['id'];
    
    $data3 = [
        'username' => 'testuser2_' . time(),
        'password' => '12345678',
        'fullname' => 'Test With Country',
        'email' => 'test2_' . time() . '@example.com',
        'birthdate' => '2000-01-15',
        'gender' => 'FEMALE',
        'phone_number' => '08123456789',
        'biography' => 'Testing with country',
        'country_id' => $firstCountryId,
        'profile_picture_address' => 'default.png'
    ];
    
    $ch3 = curl_init('http://localhost/NewsApp2/Backend/api/register.php');
    curl_setopt($ch3, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch3, CURLOPT_POST, true);
    curl_setopt($ch3, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
    curl_setopt($ch3, CURLOPT_POSTFIELDS, json_encode($data3));
    
    $response3 = curl_exec($ch3);
    $httpCode3 = curl_getinfo($ch3, CURLINFO_HTTP_CODE);
    curl_close($ch3);
    
    echo "HTTP Status: $httpCode3\n";
    echo "Response: " . ($response3 ? $response3 : 'No response') . "\n\n";
} else {
    echo "Test 3: Skipped (no countries in database)\n\n";
}

echo "=== Testing Complete ===\n";
?>
