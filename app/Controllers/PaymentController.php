<?php
namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Abya\PointOfSales\Config\LoggerConfig;

class PaymentController {

    public function index() {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('Get Payments Page');
        $smarty->assign('page', 'Payments Page');
        $smarty->display('pages/payment.tpl');
    }

};
