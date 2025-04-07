<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\Database;
use Respect\Validation\Validator as V;
use Respect\Validation\Exceptions\NestedValidationException;
use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Models\Product;
use Abya\PointOfSales\Config\SmartyConfig;

class ProductController {

    public function index() {
        $smarty = SmartyConfig::getInstance();
        $data = new Product(Database::getConnection());
        $find = $data->findAll();
        LoggerConfig::getInstance()->debug('Get Products Page', compact('find'));
        $smarty->assign('products', $find);
        $smarty->assign('page', 'Products Page');
        $smarty->display('pages/product.tpl');
    }

    public function getProducts() {
        $products = new Product(Database::getConnection());
        $find = $products->findAll();
        Helper::sendResponse(200, 'success', 'Success get Data', $find);
    }

    public function getProductByName() {
        $name = $_POST['name'];
        LoggerConfig::getInstance()->debug('Get Product By Name', compact('name'));
        $products = new Product(Database::getConnection());
        $find = $products->findByName($name);
        LoggerConfig::getInstance()->debug('Found Product by Name', $find);
        Helper::sendResponse(200, 'success', 'Success get Data', $find);
    }

    public function manageProducts() {
        LoggerConfig::getInstance()->debug('Get Manage Products Page');
        Helper::sendResponse(200, 'success', 'Success get Data', ['data' => ['product 1', 'product 2', 'product 3']]);
    }

    public function search() {
        header('Content-Type: application/json');
        try {
            $keyword = $_POST['keyword'];

            LoggerConfig::getInstance()->debug('Search data with keyword', compact('keyword'));

            V::stringType()->length(2, 50)->assert($keyword);
            $data = new Product(Database::getConnection());

            $result = $data->search($keyword);

            LoggerConfig::getInstance()->debug('Result Searching Data', compact('result'));
            Helper::sendResponse(200, 'success', 'Success get Data', $result);
        } catch (NestedValidationException $exception) {
            $errors = $exception->getMessages();
            if (!is_array($errors)) {
                $errors = [$errors];
            }
            Helper::sendResponse(400, 'error', 'Bad Request', ['Error: ' => $errors]);
        } catch (\Exception $exception) {
            $errors = $exception->getMessage();
            if (!is_array($errors)) {
                $errors = [$errors];
            }
            Helper::sendResponse(500, 'error', 'Internal Server Error', ['Error: ' => $errors]);
        }
    }
}
