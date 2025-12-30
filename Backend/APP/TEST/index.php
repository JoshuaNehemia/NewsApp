<?php

require_once(__DIR__ . "/../MODELS/City.php");
use MODELS\City;

echo "<pre>";
testCity();
echo "</pre>";

#region City 
function testCity()
{
    $cit = new City();
    $arr = $cit->selectAllCitiesFromDatabase();
    print_r($arr);
    print_r($arr[0]->toArray());
    //VERDICT: SUCCESFULLL
}
#endregion
?>