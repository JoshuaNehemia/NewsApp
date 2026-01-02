<?php

namespace MODELS\NEWS;

#region REQUIRE
require_once(__DIR__ . "/News.php");
require_once(__DIR__ . "/../ACCOUNT/User.php");
require_once(__DIR__ . "/../../config.php");
#endregion

#region USE
use MODELS\ACCOUNT\User;
use MODELS\NEWS\News;
use Exception;
#endregion

class Comment
{
    #region FIELDS
    private int $id;
    private News $news;
    private User $user;
    private ?int $reply_to_id = null;
    private string $content;
    private string $createdAt;
    #endregion

    #region CONSTRUCTOR
    public function __construct()
    {
    }
    #endregion

    #region GETTERS
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNews(): News
    {
        return $this->news;
    }

    public function getUser(): User
    {
        return $this->user;
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
        return $this->createdAt;
    }
    #endregion

    #region SETTERS
    public function setId(int $id): self
    {
        if ($id <= 0) {
            throw new Exception("Comment has invalid comment ID");
        }
        $this->id = $id;
        return $this;
    }

    public function setNews(News $news): self
    {
        $this->news = $news;
        return $this;
    }

    public function setUser(User $user): self
    {
        $this->user = $user;
        return $this;
    }

    public function setReplyToId(?int $commentId): self
    {
        if ($commentId !== null && $commentId <= 0) {
            throw new Exception("Comment has invalid parent comment ID");
        }

        if ($this->id !== null && $commentId === $this->id) {
            throw new Exception("Comment cannot reply to itself");
        }

        $this->reply_to_id = $commentId;
        return $this;
    }

    public function setContent(string $content): self
    {
        $content = trim($content);

        if ($content === '') {
            throw new Exception("Comment content cannot be empty");
        }

        if (mb_strlen($content) > 2000) {
            throw new Exception("Comment content exceeds 2000 characters");
        }

        $this->content = $content;
        return $this;
    }

    public function setCreatedAt(string $createdAt): self
    {

        if (!preg_match(REGEX_DATE_TIME, $createdAt)) {
            throw new Exception("Comment has invalid datetime format. Expected YYYY-MM-DD HH:mm:SS");
        }

        $this->createdAt = $createdAt;
        return $this;
    }
    #endregion

    #region UTILITIES
    public function toArray(): array
    {
        return [
            'id' => $this->id,
            'news' => $this->news->toArray(),
            'user' => $this->user->toArray(),
            'reply_to_id' => $this->reply_to_id,
            'content' => $this->content,
            'created_at' => $this->createdAt,
        ];
    }
    #endregion

}
