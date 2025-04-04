<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Respect\Validation\Validator as V;
use Respect\Validation\Exceptions\NestedValidationException;
use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Config\Helper;

class HomeController {
    public function index() {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('Get index page');
        $smarty->assign('title', 'Halaman Utama');
        $smarty->display('pages/index.tpl');
    }

    public function detail(string $id, ?array $query =  null) {

        LoggerConfig::getInstance()->debug('HomeController: ', ['id' => $id, 'page' => $query['page'] ?? 'Page Null']);

        $smarty = SmartyConfig::getInstance();
        $smarty->assign('key', 'value');
        $smarty->display('pages/index.tpl');
    }

    public function dummyPagination() {
        $page = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
        $perPage = isset($_GET['per_page']) ? max(1, intval($_GET['per_page'])) : 10;
        $totalItems = 57;

        $mockData = [];
        for ($i = 0; $i < $perPage; $i++) {
            $itemId = (($page - 1) * $perPage) + $i + 1;

            if ($itemId > $totalItems) {
                break;
            }

            $mockData[] = [
                'id' => $itemId,
                'order_number' => 'ORD-' . str_pad($itemId, 5, '0', STR_PAD_LEFT),
                'customer_name' => 'Customer ' . chr(65 + ($i % 26)), // A, B, C, etc.
                'order_date' => date('Y-m-d', strtotime('-' . rand(0, 30) . ' days')),
                'status' => ['Pending', 'Processing', 'Shipped', 'Delivered'][rand(0, 3)],
                'amount' => number_format(rand(100, 5000) / 100),
                'payment_method' => ['Credit Card', 'PayPal', 'Bank Transfer', 'Cash'][rand(0, 3)]
            ];
        }
        $data = json_encode([
            'total' => $totalItems,
            'page' => $page,
            'per_page' => $perPage,
            'data' => $mockData
        ]);
        Helper::sendResponse(200, 'success', 'Success get data', ['data' => $data]);

    }

    // Belum diimplement real insert ke database
    public function insert() {
        header('Content-Type: application/json');
        try {
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {

                $id = $_POST['id'] ?? null;
                $name = $_POST['name'] ?? null;
                $email = $_POST['email'] ?? null;
                $phone = $_POST['phone'] ?? null;

                V::intVal()->min(1)->assert($id);
                V::stringType()->length(3, 100)->assert($name);
                V::email()->assert($email);
                V::stringType()->length(10, 20)->assert($phone);

                LoggerConfig::getInstance()->debug('Success insert data', compact('id', 'name', 'email', 'phone'));
                Helper::sendResponse(200, 'success', 'Data berhasil disimpan', compact('id', 'name', 'email', 'phone'));
            } else {
                Helper::sendResponse(405, 'error', 'Method not allowed');
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
}
