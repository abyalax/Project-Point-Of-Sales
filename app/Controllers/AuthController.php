<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Services\AuthService;
use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Config\SmartyConfig;

class AuthController {

    public function loginView() {
        SmartyConfig::getInstance()->display('pages/auth/login.tpl');
    }

    public function registerView() {
        SmartyConfig::getInstance()->display('pages/auth/register.tpl');
    }

    public function login() {
        LoggerConfig::getInstance()->debug('Masuk Login Controller');
        if (AuthService::login($_POST['email'], $_POST['password'])) {
            LoggerConfig::getInstance()->debug('Controller: Login berhasil');
            Helper::sendResponse(302, 'redirect', 'Login berhasil', null, '/point-of-sales/');
        } else {
            Helper::sendResponse(403, 'error', 'Email atau password salah');
        }
    }

    public function logout() {
        AuthService::logout();
        Helper::sendResponse(302, 'redirect', 'Logout berhasil', null, '/point-of-sales/login');
    }
}
