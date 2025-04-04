<?php
namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';

use Abya\PointOfSales\Config\SmartyConfig;
use Abya\PointOfSales\Config\LoggerConfig;

class MemberController {

    public function index() {
        $smarty = SmartyConfig::getInstance();
        LoggerConfig::getInstance()->debug('Get Member Page');
        $smarty->assign('page', 'Member Page');
        $smarty->display('pages/member.tpl');
    }

};
