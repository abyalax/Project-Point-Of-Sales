<?php

namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Abya\PointOfSales\Config\LoggerConfig;

class TransactionController {

    public function index() {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('Get Transaction Page');
        $smarty->assign('page', 'Transaction Page');
        $smarty->display('pages/transaction.tpl');
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
