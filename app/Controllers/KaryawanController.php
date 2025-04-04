<?php
namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Abya\PointOfSales\Config\LoggerConfig;

class KaryawanController {

    public function index() {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('Get Karyawan Page');
        $smarty->assign('page', 'Karyawan Page');
        $smarty->display('pages/karyawan.tpl');
    }

};
