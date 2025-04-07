<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Models\Product;
use Abya\PointOfSales\Config\Database;
use Abya\PointOfSales\Config\Helper;
use Respect\Validation\Validator as V;

class TransactionController {

    public function index() {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('Get Transaction Page');
        // $products = new Product(Database::getConnection());
        // $find = $products->findAll();
        // LoggerConfig::getInstance()->debug('Get Products Page', compact('find'));
        // $smarty->assign('products', $find);
        // $arr = array(1 => 'Product Tennis', 2 => 'Product Swimming', 3 => 'Product Coding');
        // $arr = array('Product Tennis','Product Swimming','Product Coding');
        // $smarty->assign('products', $arr);
        // $product = [
        //     ['id' => 1, 'name' => 'Product 1', 'price' => 10000],
        //     ['id' => 2, 'name' => 'Product 2', 'price' => 10400],
        // ];
        // $smarty->assign('product', $product);
        $smarty->assign('page', 'Transaction Page');
        $smarty->display('pages/transaction.tpl');
    }

    public function addToCart() {
        $productName = $_POST['productName'];
        LoggerConfig::getInstance()->debug('Adding Cart to products: ', compact('productName'));

        V::stringType()->length(2, 50)->assert($productName);
        $data = new Product(Database::getConnection());
        $result = $data->search($productName);

        Helper::sendResponse(200, 'success', 'Adding data to cart', ['data' => $result]);
    }

    public function getPaginatedTransactions($query = []) {
        $page = $query['page'] ?? 1;
        $perPage = $query['per_page'] ?? 10;

        // Contoh implementasi dengan mock data
        $totalItems = 57;
        $mockData = [];

        for ($i = 0; $i < $perPage; $i++) {
            $itemId = (($page - 1) * $perPage) + $i + 1;
            if ($itemId > $totalItems) break;

            $mockData[] = [
                'id' => $itemId,
                'order_number' => 'ORD-' . str_pad($itemId, 5, '0', STR_PAD_LEFT),
                'amount' => rand(100, 5000) / 100,
                'status' => ['Pending', 'Processing', 'Completed'][rand(0, 2)]
            ];
        }

        return [
            'success' => true,
            'data' => $mockData,
            'pagination' => [
                'total' => $totalItems,
                'current_page' => $page,
                'per_page' => $perPage,
                'last_page' => ceil($totalItems / $perPage)
            ]
        ];
    }
};
