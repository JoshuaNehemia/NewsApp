<?php

namespace MODELS;

class Comment
{
    #region FIELDS
    private int $id;
    private int $news_id;
    private string $username;
    private ?int $reply_to_id;
    private string $content;
    private string $created_at;
    private string $updated_at;
    #endregion

    #region CONSTRUCTOR
    public function __construct(
        int $id = 0,
        int $news_id = 0,
        string $username = '',
        ?int $reply_to_id = null,
        string $content = '',
        string $created_at = '',
        string $updated_at = ''
    ) {
        $this->id = $id;
        $this->news_id = $news_id;
        $this->username = $username;
        $this->reply_to_id = $reply_to_id;
        $this->content = $content;
        $this->created_at = $created_at ?: date('Y-m-d H:i:s');
        $this->updated_at = $updated_at ?: date('Y-m-d H:i:s');
    }
    #endregion

    #region GETTERS
    public function getId(): int
    {
        return $this->id;
    }

    public function getNewsId(): int
    {
        return $this->news_id;
    }

    public function getUsername(): string
    {
        return $this->username;
    }

    public function getReplyToId(): ?int
    {
        return $this->reply_to_id;
    }

    public function getContent(): string
    {
        return $this->content;
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
    public function setNewsId(int $news_id): void
    {
        $this->news_id = $news_id;
    }

    public function setUsername(string $username): void
    {
        $this->username = $username;
    }

    public function setReplyToId(?int $reply_to_id): void
    {
        $this->reply_to_id = $reply_to_id;
    }

    public function setContent(string $content): void
    {
        $this->content = $content;
        $this->touch();
    }

    public function setUpdatedAt(string $updated_at): void
    {
        $this->updated_at = $updated_at;
    }
    #endregion

    #region HELPERS
    public function isReply(): bool
    {
        return $this->reply_to_id !== null;
    }

    private function touch(): void
    {
        $this->updated_at = date('Y-m-d H:i:s');
    }
    #endregion
}
