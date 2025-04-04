<?php
require_once  '../vendor/autoload.php';

use Abya\PointOfSales\Routes\Routes;

$routes = Routes::getRoutes();
$request = trim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/');

if (isset($routes[$request])) {
    list($controllerName, $method) = explode('@', $routes[$request]);

    if (class_exists($controllerName)) {
        $controller = new $controllerName();

        if (method_exists($controller, $method)) {
            echo $controller->$method();
        } else {
            http_response_code(500);
            echo "Method '$method' not found in controller '$controllerName'";
        }
    } else {
        http_response_code(500);
        echo "Controller '$controllerName' not found";
    }
} 

