<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Models\Product;
use Abya\PointOfSales\Config\Database;
use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Config\BaseController;
use Respect\Validation\Validator as V;

class TransactionController extends BaseController {

    public function index() {
        LoggerConfig::getInstance()->debug('Get Transaction Page');
        $this->smarty->assign('page', 'Transaction Page');
        $this->smarty->display('pages/transaction.tpl');
    }

    public function createTransaction() {
        $json = file_get_contents('php://input');
        $data = json_decode($json, true);
        if (!$data) {
            Helper::sendResponse(400, 'error', 'Invalid JSON');
            return;
        }
        LoggerConfig::getInstance()->debug('Creating Transaction', compact('data'));
        // note simpan ke database
        Helper::sendResponse(200, 'success', 'Transaction created successfully');
    }
};