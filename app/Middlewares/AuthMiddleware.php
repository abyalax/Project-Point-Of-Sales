<?php

namespace Abya\PointOfSales\Middlewares;

use Abya\PointOfSales\Config\LoggerConfig;

class AuthMiddleware {
    public function checkSession() {
        session_start();
        if (!isset($_SESSION['user_id'])) {
            header('Location: /login');
            LoggerConfig::getInstance()->debug('Block from auth middleware');
            return false; // Blok eksekusi handler berikutnya
        }
        LoggerConfig::getInstance()->debug('Pass auth middleware');
        return true; // Lanjut ke handler selanjutnya
    }
}