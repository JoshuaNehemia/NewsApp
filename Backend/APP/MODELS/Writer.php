<?php
//TODO: Make it extends account
namespace MODELS;

class Writer
{
    #region FIELDS
    private int $id;
    private string $username;
    private string $full_name;
    private string $email;
    private string $bio;
    private string $avatar;
    private string $status;
    private string $created_at;
    private string $updated_at;
    #endregion

    #region CONSTRUCTOR
    public function __construct(
        int $id = 0,
        string $username = '',
        string $full_name = '',
        string $email = '',
        string $bio = '',
        string $avatar = '',
        string $status = 'active',
        string $created_at = '',
        string $updated_at = ''
    ) {
        $this->id = $id;
        $this->username = $username;
        $this->full_name = $full_name;
        $this->email = $email;
        $this->bio = $bio;
        $this->avatar = $avatar;
        $this->status = $status;
        $this->created_at = $created_at ?: date('Y-m-d H:i:s');
        $this->updated_at = $updated_at ?: date('Y-m-d H:i:s');
    }
    #endregion

    #region GETTERS
    public function getId(): int
    {
        return $this->id;
    }

    public function getUsername(): string
    {
        return $this->username;
    }

    public function getFullName(): string
    {
        return $this->full_name;
    }

    public function getEmail(): string
    {
        return $this->email;
    }

    public function getBio(): string
    {
        return $this->bio;
    }

    public function getAvatar(): string
    {
        return $this->avatar;
    }

    public function getStatus(): string
    {
        return $this->status;
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
    public function setFullName(string $full_name): void
    {
        $this->full_name = $full_name;
        $this->touch();
    }

    public function setEmail(string $email): void
    {
        $this->email = $email;
        $this->touch();
    }

    public function setBio(string $bio): void
    {
        $this->bio = $bio;
        $this->touch();
    }

    public function setAvatar(string $avatar): void
    {
        $this->avatar = $avatar;
        $this->touch();
    }

    public function setStatus(string $status): void
    {
        $this->status = $status;
        $this->touch();
    }

    public function setUpdatedAt(string $updated_at): void
    {
        $this->updated_at = $updated_at;
    }
    #endregion

    #region HELPERS
    public function isActive(): bool
    {
        return $this->status === 'active';
    }

    private function touch(): void
    {
        $this->updated_at = date('Y-m-d H:i:s');
    }
    #endregion
}
