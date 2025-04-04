<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Services\AuthService;
use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Config\SmartyConfig;

class AuthController {

    public function loginView() {
        SmartyConfig::getInstance()->display('pages/auth/login.tpl');
    }

    public function registerView() {
        SmartyConfig::getInstance()->display('pages/auth/register.tpl');
    }

    public function login() {
        if (AuthService::login($_POST['email'], $_POST['password'])) {
            header('Location: /dashboard');
        } else {
            Helper::sendResponse(403, 'error', 'Email atau password salah');
        }
    }

    public function logout() {
        AuthService::logout();
        header('Location: /login');
    }
}
