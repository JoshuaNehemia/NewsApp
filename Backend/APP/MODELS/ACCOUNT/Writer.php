<?php

namespace MODELS\ACCOUNT;

#region REQUIRE
require_once(__DIR__ . "/Account.php");
require_once(__DIR__ . "/Media.php");
#endregion

#region USE
use MODELS\ACCOUNT\Account;
use MODELS\ACCOUNT\Media;
use Exception;
#endregion

class Writer extends Account
{
    #region FIELDS
    private Media $media;
    private string $biography;
    private bool $is_verified;
    #endregion

    #region CONSTRUCTOR
    public function __construct(
    ) {
        parent::__construct();
    }
    #endregion

    #region GETTERS
    public function getMedia(): Media
    {
        return $this->media;
    }

    public function getBiography(): string
    {
        return $this->biography;
    }

    public function isVerified(): bool
    {
        return $this->is_verified;
    }
    #endregion

    #region SETTERS
    public function setMedia(Media $media): self
    {
        if (!($media instanceof Media))
            throw new Exception("Writer media must be instance of media");
        $this->media = $media;
        return $this;
    }

    public function setBiography(string $biography): self
    {
        $biography = trim($biography);

        if (strlen($biography) > 500) {
            throw new Exception("Writer Biography too long");
        }

        $this->biography = $biography;
        return $this;
    }

    public function setIsVerified(bool $isVerified): self
    {
        $this->is_verified = $isVerified;
        return $this;
    }
    #endregion

    #region UTILITIES
    public function toArray(): array
    {
        return array_merge(parent::toArray(), [
            "media" => $this->media->toArray(),
            "biography" => $this->biography,
            "is_verified" => $this->is_verified
        ]);
    }
    #endregion
}
