<?php
namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Abya\PointOfSales\Config\LoggerConfig;

class SupplierController {

    public function index() {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('Get Supplier Page');
        $smarty->assign('page', 'Supplier Page');
        $smarty->display('pages/supplier.tpl');
    }

};
