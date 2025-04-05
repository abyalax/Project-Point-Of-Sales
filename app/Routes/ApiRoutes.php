<?php

namespace Abya\PointOfSales\Routes;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Controllers\AuthController;
use Abya\PointOfSales\Controllers\UserController;
use Abya\PointOfSales\Controllers\HomeController;
use Abya\PointOfSales\Controllers\ProductController;

class ApiRoutes {
    public static function get() {
        return [
            'GET' => [
                'api/users' => [
                    [UserController::class, 'getAllUsers'],
                ],
                'api/home' => [
                    [HomeController::class, 'dummyPagination'],
                ],
                'api/products' => [
                    [ProductController::class, 'search'],
                ],
            ],
            'POST' => [
                'api/home' => [
                    [HomeController::class, 'insert'],
                ],
                'api/login' => [
                    [AuthController::class, 'login'],
                ],
                'api/logout' => [
                    [AuthController::class, 'logout'],
                ]
            ],
        ];
    }
}
