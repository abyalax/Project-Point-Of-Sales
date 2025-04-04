<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Respect\Validation\Exceptions\NestedValidationException;
use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Models\User;

class UserController {
    public function index() { }

    public function getAllUsers() {
        LoggerConfig::getInstance()->debug('Masuk Controller Get All Users');
        header('Content-Type: application/json');
        try {
            if ($_SERVER['REQUEST_METHOD'] === 'GET') {

                $data = new User();
                $result = $data->findAll();

                LoggerConfig::getInstance()->debug('Result Searching Data', compact('result'));
                Helper::sendResponse(200, 'success', 'Success get data', $result);
            } else {
                Helper::sendResponse(405, 'error', 'Method not allowed');
            }
        } catch (NestedValidationException $exception) {
            $errors = $exception->getMessages();
            if (!is_array($errors)) {
                $errors = [$errors];
            }
            Helper::sendResponse(400, 'error', 'Bad Request', $errors);
        } catch (\Exception $exception) {
            $errors = $exception->getMessage();
            if (!is_array($errors)) {
                $errors = [$errors];
            }
            Helper::sendResponse(500, 'error', 'Internal Server Error', $errors);
        }
    }
}
