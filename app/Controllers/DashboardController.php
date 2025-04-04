<?php
namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Abya\PointOfSales\Config\LoggerConfig;

class DashboardController {
    public function index() {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('Get Dashboard Page');
        $smarty->assign('title', 'Dashboard POS');
        $smarty->display('pages/dashboard.tpl');
    }
    public function detail( string $id, ?array $query =  null) {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('DashboardController: ', ['id' => $id, 'page' => $query['page']]);
        $smarty->display('pages/dashboard.tpl');
    }
};
