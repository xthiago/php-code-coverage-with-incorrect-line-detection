<?php

declare(strict_types=1);

namespace Xthiago;

use PHPUnit\Framework\TestCase;

final class SampleTest extends TestCase
{
    public function testCreatesSample(): void
    {
        $sample = new Sample('10', '10');

        $this->assertInstanceOf(Sample::class, $sample);
    }
}