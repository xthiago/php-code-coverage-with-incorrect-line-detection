<?php

declare(strict_types=1);

namespace Xthiago;

use Assert\Assert;

class Sample
{
    public function __construct(string $latitude, string $longitude)
    {
        Assert::lazy()
            ->that($latitude, 'latitude')->range(-90, 90)
            ->that($longitude, 'longitude')->range(-140, 140)
            ->verifyNow();
    }
}
