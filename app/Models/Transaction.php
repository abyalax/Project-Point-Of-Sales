<?php

namespace Abya\PointOfSales\Models;

use Abya\PointOfSales\Config\Database;
use Abya\PointOfSales\Config\LoggerConfig;
use PDO;
use PDOException;

class Transaction {
    private $db;

    public function __construct() {
        $this->db = Database::getConnection();
    }

    public function insert($data) {
        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("
                INSERT INTO
                    transactions (user_id, transaction_id, status, payment_method, subtotal, total_discount, 
                    total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes)
                VALUES
                    (:user_id, :transaction_id, :status, :payment_method, :subtotal, :total_discount, 
                    :total_price, :total_profit, :total_tax, :last_price, :pay_received, :pay_return, :notes);
            ");

            $stmt->execute([
                'user_id'         => $data['cashier']['id'],
                'transaction_id'  => $data['transaction_id'],
                'status'          => $data['status'],
                'payment_method'  => $data['payment_method'],
                'subtotal'        => $data['subtotal'],
                'total_discount'  => $data['total_discount'],
                'total_price'     => $data['total_price'],
                'total_profit'    => $data['total_profit'],
                'total_tax'       => $data['total_tax'],
                'last_price'      => $data['last_price'],
                'pay_received'    => $data['pay_received'],
                'pay_return'      => $data['pay_return'],
                'notes'           => $data['notes'],
            ]);


            $transactionId = $this->db->lastInsertId();

            /**
             * INSERT INTO
             *     transaction_items (transaction_id, product_id, barcode, name, quantity, cost_price, sell_price, discount, tax_rate, final_price)
             * VALUES
             *     (1, 1, '8991001101234', 'Biskuit Roma Kelapa 300g', 1, 8500.00, 12000.00, 0.00, 0.10, 13200.00);
             */

            $stmtItems = $this->db->prepare("
                INSERT INTO transaction_items (
                    transaction_id, product_id, barcode, name,
                    quantity, cost_price, sell_price, discount, tax_rate, final_price
                ) VALUES (
                    :transaction_id, :product_id, :barcode, :name,
                    :quantity, :cost_price, :sell_price, :discount, :tax_rate, :final_price
                )   
            ");

            foreach ($data['item'] as $item) {
                $stmtItems->execute([
                    'transaction_id' => $transactionId,
                    'product_id'     => $item['product_id'],
                    'barcode'        => $item['barcode'],
                    'name'           => $item['name'],
                    'quantity'       => $item['qty'],
                    'cost_price'     => $item['cost_price'],
                    'sell_price'     => $item['price'],
                    'discount'       => $item['discount'] * $item['qty'],
                    'tax_rate'       => $item['tax_rate'],
                    'final_price'    => $item['summary']['last_price'],
                ]);
            }

            $this->db->commit();

            return ['transaction_id' => $data['transaction_id']];
        } catch (PDOException $e) {
            LoggerConfig::getInstance()->debug('Error Query insert product ', compact('e'));
            $this->db->rollBack();
            throw $e;
        }
    }

    public function findAll() {
        try {
            $stmt = $this->db->prepare("SELECT * FROM transactions LIMIT 25");
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            LoggerConfig::getInstance()->debug('Error Query findAll transactions', compact('e'));
            throw $e;
        }
    }
}
