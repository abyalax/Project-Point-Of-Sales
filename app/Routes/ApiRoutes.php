<?php

namespace Abya\PointOfSales\Routes;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Controllers\AuthController;
use Abya\PointOfSales\Controllers\ConfigController;
use Abya\PointOfSales\Controllers\UserController;
use Abya\PointOfSales\Controllers\HomeController;
use Abya\PointOfSales\Controllers\ProductController;
use Abya\PointOfSales\Controllers\TransactionController;
use Abya\PointOfSales\Middlewares\AuthMiddleware;

class ApiRoutes {
    public static function get() {
        return [
            'GET' => [
                'api/config' => [
                    [ConfigController::class, 'config'],
                ],
                'api/session' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [AuthController::class, 'getUserSession'],
                ],
                'api/users' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [UserController::class, 'getAllUsers'],
                ],
                'api/home' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [HomeController::class, 'dummyPagination'],
                ],
                'api/products' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [ProductController::class, 'getProducts'],
                ],
                'api/product/categories' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [ProductController::class, 'getCategories'],
                ],
            ],
            'POST' => [
                'api/home' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [HomeController::class, 'insert'],
                ],
                'api/login' => [
                    [AuthController::class, 'login'],
                ],
                'api/logout' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [AuthController::class, 'logout'],
                ],
                'api/products' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [ProductController::class, 'search'],
                ],
                'api/product/create' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [ProductController::class, 'createProducts'],
                ],
                'api/transaction/create' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [TransactionController::class, 'createTransaction'],
                ],
                'api/product/name' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [ProductController::class, 'getProductByName'],
                ],
                'api/product/id' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [ProductController::class, 'getProductByID'],
                ],
                'api/product/category/create' => [
                    [AuthMiddleware::class, 'checkSession'],
                    [ProductController::class, 'addCategoryProducts'],
                ],
            ],
        ];
    }
}
