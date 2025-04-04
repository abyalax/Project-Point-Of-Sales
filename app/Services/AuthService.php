<?php

namespace Abya\PointOfSales\Services;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Models\User;
use Abya\PointOfSales\Models\Role;

class AuthService {
    public static function login($email, $password) {
        $user = (new User())->findByEmail($email);
        
        if ($user && password_verify($password, $user['password'])) {
            session_start();
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['roles'] = Role::getUserRoles($user['id']);
            session_regenerate_id(true);
            return true;
        }
        return false;
    }

    public static function logout() {
        session_start();
        session_destroy();
    }
}