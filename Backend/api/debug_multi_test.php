<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/MODELS/NEWS/News.php';
require_once '../APP/MODELS/ACCOUNT/Writer.php';
require_once '../APP/MODELS/ACCOUNT/Media.php';
require_once '../APP/MODELS/GEOGRAPHY/City.php';
require_once '../APP/REPOSITORY/RepoNews.php';

use MODELS\NEWS\News;
use MODELS\ACCOUNT\Writer;
use MODELS\ACCOUNT\Media;
use MODELS\GEOGRAPHY\City;
use REPOSITORY\RepoNews;

// Mock Data
$title = "Debug Multi Cat " . time();
$content = "Content debug";
$writerUsername = "john_writer"; // Ensure this exists or use valid one
$cats = [3, 4]; // Ent, World

try {
    $repo = new RepoNews();

    // Check if writer exists logic bypassed for test if FK allows
    // Usually valid writer needed. I'll assume john_writer exists from previous debug output (Step 444 payload)

    $writer = new Writer();
    $writer->setUsername('john_writer');
    
    $media = new Media(); $media->setId(1); $writer->setMedia($media);
    $city = new City(); $city->setId(1);

    $news = new News();
    $news->setTitle($title);
    $news->setContent($content);
    $news->setSlug(strtolower(str_replace(' ', '-', $title)));
    $news->setAuthor($writer);
    $news->setCity($city);
    $news->setCategory(['id' => 3, 'name' => 'Ent']); 
    $news->setMedia($media);

    // Create
    $id = $repo->CreateNews($news, $cats);

    echo "Created ID: $id\n";

    // Read Back via findNewsById
    $fetched = $repo->findNewsById($id);
    
    if ($fetched) {
        echo "Fetched Title: " . $fetched->getTitle() . "\n";
        echo "Categories Count: " . count($fetched->getCategories()) . "\n";
        echo "Categories: " . implode(', ', $fetched->getCategories()) . "\n";
        
        // Read Back via findAllNews
        $all = $repo->findAllNews(1, 0); // Last 1
        $first = $all[0];
        if ($first['id'] == $id) {
             echo "List View Categories: " . json_encode($first['categories']) . "\n";
             echo "List View Categories Names: " . ($first['news_categories_names'] ?? 'N/A') . "\n"; // news_categories_names not in toArray output unless I allow it?
             // Wait, mapSQLResultToNewsObject sets $news->categories. toArray uses it.
        }

    } else {
        echo "Failed to fetch news";
    }

} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
