<?php

use REPOSITORY\repoCity;

require_once(__DIR__ . "/../REPOSITORY/RepoCity.php");
use MODELS\GEOGRAPHY\City;

echo "<pre>";
testRepoCity();
echo "</pre>";

#region City 
function testRepoCity()
{   
    $repoCity = new repoCity();
    print_r($repoCity->selectAllCitiesFromDatabase());
}
#endregion
?>