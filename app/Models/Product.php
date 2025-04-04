<?php

namespace Abya\PointOfSales\Models;

use Abya\PointOfSales\Config\Database;
use Abya\PointOfSales\Config\LoggerConfig;
use PDO;

class Product {
    private $db;

    public function __construct() {
        $this->db = Database::getConnection();
    }

    public function findAll() {
        $stmt = $this->db->prepare("SELECT * FROM products");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_OBJ);
    }

    public function search($keyword) {
        $stmt = $this->db->prepare("SELECT name FROM products WHERE name LIKE :keyword LIMIT 10");
        $stmt->execute(['keyword' => "%$keyword%"]);
        $result = $stmt->fetchAll(PDO::FETCH_COLUMN);
        LoggerConfig::getInstance()->debug('Success query data', compact('result'));
        return $result;
    }
}
