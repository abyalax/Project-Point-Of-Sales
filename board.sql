SELECT
    category,
    SUM(final_price) as total_revenue,
    SUM(sell_price) as total_sales,
    SUM(sell_price - cost_price - discount) as total_profit,
    SUM(quantity) as total_qty
FROM
    transaction_items
GROUP BY
    category;