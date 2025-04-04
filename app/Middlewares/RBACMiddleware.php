<?php

namespace Abya\PointOfSales\Middlewares;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Services\RBACService;

class RBACMiddleware {
    public static function handle($requiredPermission) {
        if (!isset($_SESSION['roles'])) {
            header('HTTP/1.0 403 Forbidden');
            exit;
        }

        if (!RBACService::check($_SESSION['roles'], $requiredPermission)) {
            header('HTTP/1.0 403 Forbidden');
            echo "Anda tidak punya akses!";
            exit;
        }
    }
}