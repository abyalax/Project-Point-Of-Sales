<?php

namespace Abya\PointOfSales\Config;

use ReflectionMethod;

class Helper {

    

    /**
     * Send HTTP response with optional redirect
     * 
     * @param int $statusCode HTTP status code
     * @param string $status Response status (success/error)
     * @param string $message Response message
     * @param array|null $data Additional data
     * @param string|null $redirectUrl URL for redirect (only for 302 status)
     */
    static function sendResponse(
            int $statusCode,
            string $status,
            string $message,
            ?array $data = null,
            ?string $redirectUrl = null
        ): void {
            http_response_code($statusCode);

            if ($statusCode === 302 && $redirectUrl) {
                // For AJAX requests, include redirect in JSON response
                if (self::isAjaxRequest()) {
                    header('Content-Type: application/json');
                    echo json_encode([
                        'status' => $status,
                        'message' => $message,
                        'data' => $data,
                        'redirect' => $redirectUrl
                    ]);
                    exit;
                }

                // For normal requests, do actual redirect
                header("Location: $redirectUrl");
                exit;
            }

            // Standard JSON response
            header('Content-Type: application/json');
            echo json_encode([
                'status' => $status,
                'message' => $message,
                'data' => $data
            ]);
            exit;
    }

    private static function isAjaxRequest(): bool {
        return !empty($_SERVER['HTTP_X_REQUESTED_WITH']) &&
            strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest';
    }

    static function handleMatchQuery($routePattern, $handlers, $path, $query) {
        if (preg_match("#^{$routePattern}$#", $path, $matches)) {

            foreach ($handlers as $handler) {
                // Handle middleware/controller instantiation
                $class = $handler[0];
                $methodWithParams = $handler[1];

                // Ekstrak method name dan parameter (jika ada)
                $methodParts = explode(':', $methodWithParams);
                $methodName = $methodParts[0];
                $param = $methodParts[1] ?? null;
                // Instansiasi class
                $instance = new $class();
                // Handle parameter passing
                $args = [];
                // Jika ini adalah controller utama (handler terakhir)
                if ($handler === end($handlers)) {
                    $refMethod = new ReflectionMethod($instance, $methodName);
                    foreach ($refMethod->getParameters() as $param) {
                        if (isset($matches[$param->getPosition() + 1])) {
                            $args[] = $matches[$param->getPosition() + 1];
                        }
                    }
                    $args[] = $query;
                }
                // Jika middleware dengan parameter
                elseif ($param !== null) {
                    $args[] = $param;
                    $args[] = $query;
                }
                LoggerConfig::getInstance()->debug('Call Method', compact('instance', 'methodName', 'args'));
                $result = $instance->{$methodName}(...$args);
                // Handle return value
                if ($result === false) {
                    Helper::sendResponse(403, 'error', 'Forbidden');
                    exit;
                }
            }
            return true;
        }
        return false;
    }

    // Untuk case SHA2 di MySQL:
    // Contoh penggunaan:
    // $isValid = verifySha256Password($_POST['password'], $user['password']);
    static function verifySha256Password($inputPassword, $storedHash) {
        return hash('sha256', $inputPassword) === $storedHash;
    }
}
