<?php

namespace MODELS\CORE;

use Exception;

class Geolocation {
    private float $latitude;
    private float $longitude;

    public function __construct(float $latitude, float $longitude) {
        $this->setLatitude($latitude);
        $this->setLongitude($longitude);
    }

    public function getLatitude(): float {
        return $this->latitude;
    }

    public function getLongitude(): float {
        return $this->longitude;
    }
    
    public function setLatitude(float $latitude): self {
        if ($latitude < -90 || $latitude > 90) {
            throw new Exception('Geolocation latitude must be between -90 and 90.');
        }
        $this->latitude = $latitude;
        return $this;
    }

    public function setLongitude(float $longitude): self {
        if ($longitude < -180 || $longitude > 180) {
            throw new Exception('Longitude must be between -180 and 180.');
        }
        $this->longitude = $longitude;
        return $this;
    }

    public function toArray(): array {
        return [
            'latitude' => $this->latitude,
            'longitude' => $this->longitude,
        ];
    }

    public function calculateDistanceTo(Geolocation $destination): float {
        $earthRadius = 6371;
        $latFrom = deg2rad($this->latitude);
        $lonFrom = deg2rad($this->longitude);
        $latTo   = deg2rad($destination->latitude);
        $lonTo   = deg2rad($destination->longitude);

        $latDelta = $latTo - $latFrom;
        $lonDelta = $lonTo - $lonFrom;

        $angle = 2 * asin(sqrt(
            pow(sin($latDelta / 2), 2) +
            cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)
        ));

        return $angle * $earthRadius; // distance in kilomeeters
    }
}
