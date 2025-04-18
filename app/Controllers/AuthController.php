<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Services\AuthService;
use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Config\BaseController;
use Abya\PointOfSales\Config\Database;
use Abya\PointOfSales\Models\User;
use Respect\Validation\Validator as V;
use Respect\Validation\Exceptions\NestedValidationException;

class AuthController extends BaseController {

    public function getUserSession() {
        $id = $_SESSION['user_id'];
        $user = new User(Database::getConnection());
        $data = $user->findById($id);
        LoggerConfig::getInstance()->debug('Get User Session', compact('data'));
        Helper::sendResponse(200, 'success', 'Success get data', $data);
    }

    public function loginView() {
        $this->smarty->display('pages/auth/login.tpl');
    }

    public function registerView() {
        $this->smarty->display('pages/auth/register.tpl');
    }

    public function login() {
        try {
            LoggerConfig::getInstance()->debug('Masuk Login Controller');

            $email = $_POST['email'] ?? null;
            $password = $_POST['password'] ?? null;

            // V::stringType()->length(6, 30)
            //     ->length(8, 30)->setTemplate('Password setidaknya memiliki panjang 6 karakter')
            //     ->regex('/[A-Z]/')->setTemplate('Password setidaknya memiliki huruf besar')
            //     ->regex('/[a-z]/')->setTemplate('Password setidaknya memiliki huruf kecil')
            //     ->regex('/[0-9]/')->setTemplate('Password setidaknya memiliki angka')
            //     ->assert($password);
            
            
            V::stringType()->length(6, 30)->assert($password);
            V::email()->assert($email);

            if (AuthService::login($email, $password)) {
                LoggerConfig::getInstance()->debug('Controller: Login berhasil');
                Helper::sendResponse(302, 'redirect', 'Login berhasil', null, '/point-of-sales/');
            } else {
                Helper::sendResponse(403, 'error', 'Email atau password salah');
            }
        } catch (NestedValidationException $exception) {
            $errors = $exception->getMessages();
            if (!is_array($errors)) {
                $errors = [$errors];
            }
            LoggerConfig::getInstance()->debug('Validation error', $exception->getMessages());
            Helper::sendResponse(400, 'error', 'Validation error', $errors);
        } catch (\Exception $exception) {
            $errors = $exception->getMessage();
            if (!is_array($errors)) {
                $errors = [$errors];
            }
            LoggerConfig::getInstance()->debug('Validation error', $errors);
            Helper::sendResponse(400, 'error', 'Validation error', $errors);
        }
    }

    public function logout() {
        AuthService::logout();
        Helper::sendResponse(302, 'redirect', 'Logout berhasil', null, '/point-of-sales/login');
    }
}
