<?php

namespace Abya\PointOfSales\Config;

use ReflectionMethod;

class Helper {
    static function sendResponse(int $statusCode, string $status, string $message, ?array $data = null) {
        http_response_code($statusCode);
        echo json_encode([
            'status' => $status,
            'message' => $message,
            'data' => $data
        ]);
        exit;
    }

    static function handleMatchQuery($routePattern, $handlers, $path, $query) {
        if (preg_match("#^{$routePattern}$#", $path, $matches)) {
            
            // Eksekusi semua handler berurutan
            foreach ($handlers as $handler) {
                $controller = new $handler[0](); 
                $method = $handler[1];            
                $args = [];
                
                // Handle parameter matching (untuk controller utama)
                if ($handler === end($handlers)) {
                    $refMethod = new ReflectionMethod($controller, $method);
                    foreach ($refMethod->getParameters() as $param) {
                        if (isset($matches[$param->getPosition() + 1])) {
                            $args[] = $matches[$param->getPosition() + 1];
                        }
                    }
                }
                
                // Panggil middleware/controller
                $result = $controller->{$method}(...$args);
                
                // Jika middleware return false, hentikan eksekusi
                if ($result === false) {
                    Helper::sendResponse(403, 'error', 'Forbidden');
                    exit;
                }
            }
            return true;
        }
        return false;
    }
}
