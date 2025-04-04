<?php

namespace Abya\PointOfSales\Routes;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Controllers\AnalyticsController;
use Abya\PointOfSales\Controllers\HomeController;
use Abya\PointOfSales\Controllers\DashboardController;
use Abya\PointOfSales\Controllers\InventarisController;
use Abya\PointOfSales\Controllers\KaryawanController;
use Abya\PointOfSales\Controllers\MemberController;
use Abya\PointOfSales\Controllers\PaymentController;
use Abya\PointOfSales\Controllers\ProductController;
use Abya\PointOfSales\Controllers\SettingController;
use Abya\PointOfSales\Controllers\SupplierController;
use Abya\PointOfSales\Controllers\TransactionController;
use Abya\PointOfSales\Controllers\AuthController;

use Abya\PointOfSales\Middlewares\AuthMiddleware;
use Abya\PointOfSales\Middlewares\RBACMiddleware;

class WebRoutes {
    public static function get() {
        return [
            'GET' => [
                // Tanpa middleware
                '' => [
                    [HomeController::class, 'index']
                ],
                'dashboard' => [
                    [DashboardController::class, 'index']
                ],
                // // Dengan middleware (dieksekusi berurutan)
                // 'settings' => [
                //     [AuthMiddleware::class, 'checkSession'],  // Middleware 1
                //     // [RBACMiddleware::class, 'checkAdmin'],    // Middleware 2 
                //     [SettingController::class, 'index']       // Controller utama
                // ],
                // Dynamic route /number
                'products/(\d+)' => [
                    [ProductController::class, 'manageProducts']
                ],
                // Dynamic route /word
                'products/(\w+)' => [
                    [ProductController::class, 'manageProducts']
                ],

                'login' => [
                    [AuthController::class, 'loginView']
                ],

                'register' => [
                    [AuthController::class, 'registerView']
                ],

                'transactions' => [
                    [TransactionController::class, 'index']
                ],
                'inventaris' => [
                    [InventarisController::class, 'index']
                ],
                'analytics' => [
                    [AnalyticsController::class, 'index']
                ],
                'suppliers' => [
                    [SupplierController::class, 'index']
                ],
                'members' => [
                    [MemberController::class, 'index']
                ],
                'karyawans' => [
                    [KaryawanController::class, 'index']
                ],
                'products' => [
                    [ProductController::class, 'index']
                ],
                'payments' => [
                    [PaymentController::class, 'index']
                ],
                'settings' => [
                    [SettingController::class, 'index']
                ],
            ],
            'POST' => [
                'login' => [
                    [AuthController::class, 'login']
                ]
            ]
        ];
    }
}