<?php
require_once  '../vendor/autoload.php';

use Abya\PointOfSales\Routes\Routes;

$method = $_SERVER['REQUEST_METHOD'];

Routes::apiRoutes($method);