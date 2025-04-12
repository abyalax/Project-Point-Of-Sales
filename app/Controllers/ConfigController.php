<?php
namespace Abya\PointOfSales\Controllers;

require_once __DIR__ . '/../../vendor/autoload.php';
use Abya\PointOfSales\Config\Helper;
use Abya\PointOfSales\Config\Config;

class ConfigController {
    
    public function config() {
        Helper::sendResponse(200, 'success', 'Success get config', [
            ['base_url' => Config::getBaseUrl()]
        ]);
    }
}