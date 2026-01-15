<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");

$testDir = "../APP/DATABASE/IMAGE/WRITER/";
$testFile = $testDir . "test_write.txt";

$results = [
    'timestamp' => date('Y-m-d H:i:s'),
    'test_directory' => $testDir,
];

// Check if directory exists
if (file_exists($testDir)) {
    $results['directory_exists'] = 'YES';
    $results['directory_permissions'] = substr(sprintf('%o', fileperms($testDir)), -4);
    $results['directory_is_writable'] = is_writable($testDir) ? 'YES' : 'NO';
} else {
    $results['directory_exists'] = 'NO';
    $results['error'] = 'Directory does not exist: ' . $testDir;
}

// Try to create a test file
if (file_exists($testDir)) {
    if (file_put_contents($testFile, "Test write at " . date('Y-m-d H:i:s'))) {
        $results['write_test'] = 'SUCCESS';
        $results['test_file_created'] = $testFile;
        
        // Clean up
        unlink($testFile);
    } else {
        $results['write_test'] = 'FAILED';
        $results['write_error'] = error_get_last();
    }
}

// Check parent directories
$pathParts = explode('/', trim($testDir, '/'));
$currentPath = '../APP/';
foreach ($pathParts as $part) {
    if (empty($part)) continue;
    $currentPath .= $part . '/';
    if (file_exists($currentPath)) {
        $results['path_check'][$currentPath] = [
            'exists' => 'YES',
            'permissions' => substr(sprintf('%o', fileperms($currentPath)), -4),
            'writable' => is_writable($currentPath) ? 'YES' : 'NO'
        ];
    } else {
        $results['path_check'][$currentPath] = [
            'exists' => 'NO'
        ];
    }
}

echo json_encode($results, JSON_PRETTY_PRINT);
?>
