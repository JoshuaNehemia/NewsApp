<?php

namespace MODELS\NEWS;

#region REQUIRE
require_once(__DIR__ . "/../CORE/Geolocation.php");
require_once(__DIR__ . "/../ACCOUNT/Writer.php");
#endregion

#region USE
use MODELS\CORE\Geolocation;
use MODELS\ACCOUNT\Writer;
use Exception;
#endregion
class News
{
    #region FIELDS
    private int $id;
    private string $title;
    private string $slug;
    private string $content;
    private array $images = [];
    private Writer $author;
    private Geolocation $location;
    private string $category;
    private int $view_count;
    private string $created_at;
    private string $updated_at;
    #endregion

    #region CONSTRUCTOR
    public function __construct()
    {
    }
    #endregion

    #region GETTERS
    public function getId(): int
    {
        return $this->id;
    }

    public function getTitle(): string
    {
        return $this->title;
    }

    public function getSlug(): string
    {
        return $this->slug;
    }

    public function getContent(): string
    {
        return $this->content;
    }

    public function getImages(): array
    {
        return $this->images;
    }

    public function getAuthor(): Writer
    {
        return $this->author;
    }

    public function getLocation(): Geolocation
    {
        return $this->location;
    }

    public function getCategory(): string
    {
        return $this->category;
    }

    public function getCreatedAt(): string
    {
        return $this->created_at;
    }

    public function getUpdatedAt(): string
    {
        return $this->updated_at;
    }

    public function getViewCount(): int
    {
        return $this->view_count;
    }
    #endregion

    #region SETTERS
    public function setId(int $id): self
    {
        if ($id <= 0) {
            throw new Exception("Invalid news ID");
        }
        $this->id = $id;
        return $this;
    }

    public function setTitle(string $title): self
    {
        $title = trim($title);

        if ($title === '') {
            throw new Exception("Title cannot be empty");
        }

        $this->title = $title;
        return $this;
    }

    public function setSlug(string $slug): self
    {
        if (!preg_match('/^[a-z0-9-]+$/', $slug)) {
            throw new Exception("Invalid slug format");
        }

        $this->slug = $slug;
        return $this;
    }

    public function setContent(string $content): self
    {
        if (trim($content) === '') {
            throw new Exception("Content cannot be empty");
        }

        $this->content = $content;
        return $this;
    }

    public function setImages(array $images): self
    {
        $this->images = $images;
        return $this;
    }

    public function addImage(string $image): self
    {
        $this->images[] = $image;
        return $this;
    }

    public function setAuthor(Writer $author): self
    {
        $this->author = $author;
        return $this;
    }

    public function setLocation(Geolocation $location): self
    {
        $this->location = $location;
        return $this;
    }

    public function setCategory(string $category): self
    {
        if (trim($category) === '') {
            throw new Exception("News category cannot be empty");
        }
        $this->category = $category;
        return $this;
    }

    public function setCreatedAt(string $created_at): self
    {
        $this->created_at = $created_at;
        return $this;
    }

    public function setUpdatedAt(string $updated_at): self
    {
        $this->updated_at = $updated_at;
        return $this;
    }
    public function setViewCount(int $view_count): self
    {
        if ($view_count < 0)
            throw new Exception("News view count can't be negative");
        $this->view_count = $view_count;
        return $this;
    }
    #endregion

    #region UTILITIES
    public function toArray(): array
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'slug' => $this->slug,
            'content' => $this->content,
            'images' => $this->images,
            'category' => $this->category,
            'view_count' => $this->view_count,
            'author' => $this->author->toArray(),
            'location' => $this->location->toArray(),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
    #endregion
}
