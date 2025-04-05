<?php

namespace Abya\PointOfSales\Models;

use PDO;
use stdClass;
use Abya\PointOfSales\Config\Database;

class User {
    private $db;

    public function __construct() {
        $this->db = Database::getConnection();
    }

    public function findByEmail($email): array {
        $stmt = $this->db->prepare("SELECT * FROM users WHERE email = ?");
        $stmt->execute([$email]);
        return $stmt->fetch(PDO::FETCH_ASSOC) ?: [];
    }



    public function find($id): array {
        $stmt = $this->db->prepare("SELECT * FROM users WHERE id = ?");
        $stmt->execute([$id]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        return $result ?: []; // Pastikan selalu array, bukan null
    }
    
    
    public function findAll(): array {
        $stmt = $this->db->prepare("SELECT * FROM users LIMIT 10");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    
}
