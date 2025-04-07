<?php
require_once '../vendor/autoload.php';

use Abya\PointOfSales\Config\LoggerConfig;
use Abya\PointOfSales\Routes\Routes;

$method = $_SERVER['REQUEST_METHOD'];
$url = $_SERVER['REQUEST_URI'];
$parsed = parse_url($url);
$path = $parsed['path'] ?? '/';

$queryParams = [];
if (!empty($parsed['query'])) {
    parse_str($parsed['query'], $queryParams);
}

$prefix = '/point-of-sales/';
$path = trim(substr($path, strlen($prefix)), '/');

LoggerConfig::getInstance()->debug('Request Entry Point: ', [
    'method' => $method,
    'path' => $path,
    'query' => $queryParams
]);

// Routes::webRoutes($method, $path, $queryParams);

$method = $_SERVER['REQUEST_METHOD'];
$path = trim(substr($parsed['path'], strlen($prefix)), '/');

// Pisahkan route SSR dan API
if (str_starts_with($path, 'api/')) {
    // Handle API request
    header('Content-Type: application/json');
    Routes::apiRoutes($method, $path, $queryParams);
} else {
    // Handle SSR request
    Routes::webRoutes($method, $path, $queryParams);
}