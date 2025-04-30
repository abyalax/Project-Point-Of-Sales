<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Config\BaseController;
use Abya\PointOfSales\Config\StatusResponse;
use Abya\PointOfSales\Models\Transaction;

class TransactionController extends BaseController {

    public function index() {
        LoggerConfig::getInstance()->debug('Get Transaction Page');
        $this->smarty->assign('page', 'Transaction Page');
        $this->smarty->display('pages/transaction/index.tpl');
    }

    public function get() {
        LoggerConfig::getInstance()->debug('Get Transaction List Page');
        $transaction = new Transaction();
        $data = $transaction->findAll();
        $this->smarty->assign('transactions', $data);
        $this->smarty->assign('page', 'Transaction List Page');
        $this->smarty->display('pages/transaction/get.tpl');
    }

    public function createTransaction() {
        $json = file_get_contents('php://input');
        $data = json_decode($json, true);
        if (!$data) {
            Helper::sendResponse(400, StatusResponse::badrequest);
            return;
        }
        LoggerConfig::getInstance()->debug('Creating Transaction', compact('data'));
        // note simpan ke database
        Helper::sendResponse(201, StatusResponse::created);
    }
};
