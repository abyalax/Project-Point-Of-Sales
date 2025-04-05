<?php

namespace Abya\PointOfSales\Middlewares;

use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Config\LoggerConfig;

class AuthMiddleware {
    public function checkSession() {
        session_start();
        if (!isset($_SESSION['user_id'])) {
            LoggerConfig::getInstance()->debug('Block from auth middleware');
            Helper::sendResponse(302, 'redirect', 'Unauthorized', null, '/point-of-sales/login');
            return false; // Blok eksekusi handler berikutnya
        }
        LoggerConfig::getInstance()->debug('Pass auth middleware');
        return true; // Lanjutkan eksekusi handler berikutnya
    }
}