<?php

namespace Abya\PointOfSales\Middlewares;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Services\RBACService;

class RBACMiddleware {
    public static function handle($requiredPermission) {
        if (!isset($_SESSION['roles'])) {
            Helper::sendResponse(403, 'error', 'Unauthorized');
            exit;
        }
        
        if (!RBACService::check($_SESSION['roles'], $requiredPermission)) {
            Helper::sendResponse(403, 'error', 'Access Denied');
            exit;
        }
    }
}