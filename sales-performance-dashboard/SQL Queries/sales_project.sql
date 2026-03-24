USE sales_project

SELECT TOP 10 * FROM sales

SELECT COUNT(*) FROM sales 

SELECT DISTINCT category FROM sales

SELECT DISTINCT Segment FROM sales;

SELECT MIN(order_date), MAX(order_date) FROM sales;

-- Checking missing values:

SELECT *
FROM sales 
WHERE Sales IS NULL OR Customer_ID IS NULL

-- Any Duplicates

SELECT Order_ID, COUNT(*)
FROM sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;

-- Main queries:

-- Total Revenue

SELECT
    SUM(Sales) AS total_revenue
FROM sales

-- Total orders

SELECT 
    COUNT(DISTINCT order_id) AS Total_orders
FROM sales

-- Avg order value

SELECT
    SUM(Sales) * 1.0 / COUNT(DISTINCT Order_ID) AS avg_order_value
FROM sales

-- Monthly trend revenue

SELECT
    FORMAT(Order_Date, 'yyyy-MM') AS month,
    SUM(Sales) AS revenue
FROM sales
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY revenue DESC

-- Top products

SELECT
    TOP 10 Product_Name,
    SUM(Sales) AS revenue_per_product
FROM sales
GROUP BY Product_Name
ORDER BY revenue_per_product DESC

-- Revenue per category

SELECT
    Category,
    SUM(Sales) AS revenue_per_category
FROM sales
GROUP BY Category
ORDER BY revenue_per_category DESC

-- Segment analysis

SELECT
    Segment,
    SUM(Sales) AS segment_revenue_analysis
FROM sales
GROUP BY Segment
ORDER BY segment_revenue_analysis DESC

-- Regional performance

SELECT
    Region,
    SUM(Sales) AS regional_performance
FROM sales
GROUP BY Region
ORDER BY regional_performance DESC

-- Top customers

SELECT top 10
    Customer_Name,
    SUM(Sales) AS Sales_per_customer
FROM sales
GROUP BY Customer_Name
ORDER BY Sales_per_customer DESC

-- Monthly_growth

WITH monthly_sales AS(
    SELECT
        FORMAT(Order_Date, 'yyyy-MM') AS month,
        ROUND(SUM(Sales), 2) AS revenue
    FROM sales
    GROUP BY FORMAT(Order_Date, 'yyyy-MM')
)
SELECT
    month,
    revenue,
    ISNULL(LAG(revenue) OVER (ORDER BY month), 0) AS prev_month,
    revenue - ISNULL(LAG(revenue) OVER (ORDER BY month), 0) AS growth
FROM monthly_sales
