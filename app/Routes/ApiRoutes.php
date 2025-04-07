<?php

namespace Abya\PointOfSales\Routes;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Controllers\AuthController;
use Abya\PointOfSales\Controllers\UserController;
use Abya\PointOfSales\Controllers\HomeController;
use Abya\PointOfSales\Controllers\ProductController;
use Abya\PointOfSales\Controllers\TransactionController;

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
                    [ProductController::class, 'getProducts'],
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
                ],
                'api/products' => [
                    [ProductController::class, 'search'],
                ],
                'api/transactions' => [
                    [TransactionController::class, 'addToCart'],
                ],
                'api/product/name' => [
                    [ProductController::class, 'getProductByName'],
                ],
            ],
        ];
    }
}
