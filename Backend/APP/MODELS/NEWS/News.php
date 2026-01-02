<?php

namespace MODELS;

class News
{
    #region FIELDS
    private int $id;
    private string $title;
    private string $slug;
    private string $content;
    private string $thumbnail;
    private string $status;
    private string $author_username;
    private string $created_at;
    private string $updated_at;
    #endregion

    #region CONSTRUCTOR
    public function __construct(
        int $id = 0,
        string $title = '',
        string $slug = '',
        string $content = '',
        string $thumbnail = '',
        string $status = 'draft',
        string $author_username = '',
        string $created_at = '',
        string $updated_at = ''
    ) {
        $this->id = $id;
        $this->title = $title;
        $this->slug = $slug;
        $this->content = $content;
        $this->thumbnail = $thumbnail;
        $this->status = $status;
        $this->author_username = $author_username;
        $this->created_at = $created_at ?: date('Y-m-d H:i:s');
        $this->updated_at = $updated_at ?: date('Y-m-d H:i:s');
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

    public function getThumbnail(): string
    {
        return $this->thumbnail;
    }

    public function getStatus(): string
    {
        return $this->status;
    }

    public function getAuthorUsername(): string
    {
        return $this->author_username;
    }

    public function getCreatedAt(): string
    {
        return $this->created_at;
    }

    public function getUpdatedAt(): string
    {
        return $this->updated_at;
    }
    #endregion

    #region SETTERS
    public function setTitle(string $title): void
    {
        $this->title = $title;
        $this->touch();
    }

    public function setSlug(string $slug): void
    {
        $this->slug = $slug;
        $this->touch();
    }

    public function setContent(string $content): void
    {
        $this->content = $content;
        $this->touch();
    }

    public function setThumbnail(string $thumbnail): void
    {
        $this->thumbnail = $thumbnail;
        $this->touch();
    }

    public function setStatus(string $status): void
    {
        $this->status = $status;
        $this->touch();
    }

    public function setAuthorUsername(string $author_username): void
    {
        $this->author_username = $author_username;
    }

    public function setUpdatedAt(string $updated_at): void
    {
        $this->updated_at = $updated_at;
    }
    #endregion

    #region HELPERS
    public function isPublished(): bool
    {
        return $this->status === 'published';
    }

    private function touch(): void
    {
        $this->updated_at = date('Y-m-d H:i:s');
    }
    #endregion
}
