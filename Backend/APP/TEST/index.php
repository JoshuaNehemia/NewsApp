<?php

require_once(__DIR__ . "/../REPOSITORY/RepoCity.php");
require_once(__DIR__ . "/../REPOSITORY/RepoAccount.php");
require_once(__DIR__ . "/../REPOSITORY/RepoNews.php");

use REPOSITORY\repoCity;
use REPOSITORY\RepoAccount;
use REPOSITORY\RepoNews;


echo "<pre>";
testRepoNews();
echo "</pre>";

function testRepoCity()
{
    $repoCity = new repoCity();
    print_r($repoCity->findAllCitiesFromDatabase());
}

function testRepoAccount()
{
    $repo = new repoAccount();
    print_r($repo->login("najwa123", "password"));
}

function testRepoNews()
{
    $repoNews = new repoNews();
    print_r($repoNews->findNewsById(2));
}
?>