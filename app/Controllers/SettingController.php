<?php
namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Abya\PointOfSales\Config\LoggerConfig;

class SettingController {

    public function index() {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('Get Settings Page');
        $smarty->assign('page', 'Settings Page');
        $smarty->display('pages/setting.tpl');
    }

};
