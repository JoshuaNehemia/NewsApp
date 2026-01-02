<?php

use REPOSITORY\repoCity;
use REPOSITORY\RepoAccount;

require_once(__DIR__ . "/../REPOSITORY/RepoCity.php");
require_once(__DIR__ . "/../REPOSITORY/RepoAccount.php");

echo "<pre>";
testRepoAccount();
echo "</pre>";

function testRepoCity()
{   
    $repoCity = new repoCity();
    print_r($repoCity->selectAllCitiesFromDatabase());
}

function testRepoAccount()
{   
    $repo = new repoAccount();
    print_r($repo->login("najwa123","password"));
}
?>