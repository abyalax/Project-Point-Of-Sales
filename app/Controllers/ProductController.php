<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Respect\Validation\Validator as V;
use Respect\Validation\Exceptions\NestedValidationException;
use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Models\Product;
use Abya\PointOfSales\Config\BaseController;
use Monolog\Logger;

class ProductController extends BaseController {

    public function index() {
        $data = new Product();
        $find = $data->findAll();
        LoggerConfig::getInstance()->debug('Get Products Page', compact('find'));
        $this->smarty->assign('products', $find);
        $this->smarty->assign('page', 'Products Page');
        $this->smarty->display('pages/product/index.tpl');
    }

    public function create() {
        LoggerConfig::getInstance()->debug('Get Create Products Page');
        $this->smarty->assign('page', 'Create Products Page');
        $this->smarty->display('pages/product/create.tpl');
    }

    public function update($paramID) {
        LoggerConfig::getInstance()->debug('Get Update Products Page', ['param ID' => $paramID]);
        $product = new Product();
        $data = $product->findById($paramID);
        $this->smarty->assign('product', $data);
        $this->smarty->assign('page', 'Update Products Page');
        $this->smarty->display('pages/product/update.tpl');
    }

    public function createProducts() {
        try {
            $json = file_get_contents('php://input');
            $data = json_decode($json, true);
            if (!$data) {
                Helper::sendResponse(400, 'error', 'Invalid JSON');
                return;
            }
            LoggerConfig::getInstance()->debug('Creating Product', compact('data'));
            $product = new Product();
            $add = $product->insert($data);
            if ($add) {
                Helper::sendResponse(200, 'success', 'Product created successfully');
            } else {
                Helper::sendResponse(400, 'error', 'Failed add new product');
            }
        } catch (\Throwable $th) {
            LoggerConfig::getInstance()->debug('Error addProducts', compact('th'));
            Helper::sendResponse(500, 'error', 'Internal Server Error');
        }
    }

    public function getProducts() {
        $products = new Product();
        $find = $products->findAll();
        Helper::sendResponse(200, 'success', 'Success get Data', $find);
    }

    public function getProductByID() {
        $id = $_POST['id'];
        LoggerConfig::getInstance()->debug('Get Product By ID', compact('id'));
        $product = new Product();
        $find = $product->findById($id);
        LoggerConfig::getInstance()->debug('Found Product by ID', $find);
        Helper::sendResponse(200, 'success', 'Success get Data', $find);
    }

    public function getProductByName() {
        $name = $_POST['name'];
        LoggerConfig::getInstance()->debug('Get Product By Name', compact('name'));
        $products = new Product();
        $find = $products->findByName($name);
        LoggerConfig::getInstance()->debug('Found Product by Name', $find);
        Helper::sendResponse(200, 'success', 'Success get Data', $find);
    }

    public function getCategories() {
        $categories = new Product();
        $find = $categories->findAllCategories();
        Helper::sendResponse(200, 'success', 'Success get Data', $find);
    }

    public function addCategoryProducts() {
        try {
            $json = file_get_contents('php://input');
            $data = json_decode($json, true);
            LoggerConfig::getInstance()->debug('POST Add Category Products Page', $data);
            if (!$data) {
                Helper::sendResponse(400, 'error', 'Invalid JSON');
                return;
            }
            LoggerConfig::getInstance()->debug('Creating Category', compact('data'));
            $product = new Product();
            $add = $product->addCategoryProducts($data['name']);
            if ($add) {
                Helper::sendResponse(200, 'success', 'Success add category', ['data' => $add]);
            } else {
                Helper::sendResponse(400, 'error', 'Failed add new category', ['data' => $add]);
            }
        } catch (\Throwable $th) {
            LoggerConfig::getInstance()->debug('Error addCategoryProducts', compact('th'));
            Helper::sendResponse(500, 'error', 'Internal Server Error');
        }
    }

    public function manageProducts($first, $second) {
        LoggerConfig::getInstance()->debug('Get Manage Products Page');
        Helper::sendResponse(200, 'success', 'Success get Data', ['fisrt' => $first, 'second' => $second]);
    }

    public function search() {
        header('Content-Type: application/json');
        try {
            $keyword = $_POST['keyword'];

            LoggerConfig::getInstance()->debug('Search data with keyword', compact('keyword'));

            V::stringType()->length(2, 50)->assert($keyword);
            $data = new Product();

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
