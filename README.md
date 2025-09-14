# SQL_Project-Uncovering Coffee Trends with SQL
## Overview | 概览

This SQL exercise applies multiple analytical methods to explore coffee shop operations data in Southeast Asia.  
本次 SQL 练习运用了多种分析方法，探索了东南亚咖啡店的运营数据。  
##Dataset | 数据集
1.baristacoffeesalestbl
Sourced from https://www.kaggle.com/datasets/yashparab/barista-coffee-sales-data-for-eda-csv
2.caffeine_intake_tracker
Sourced from https://www.kaggle.com/datasets/prekshad2166/caffeine-intake-tracker-csv
3.coffeesales
Sourced from https://www.kaggle.com/datasets/visabelsarahsargunar/coffee-sales-dataset
added columns:
coffeeID
shopID
customer_id
4.consumerpreference
Sourced from https://datadryad.org/dataset/doi:10.25338/B8993H
5.list_coffee_shops_in_kota_bogor
Sourced from https://www.kaggle.com/datasets/mrbuitenzorg/list-coffee-shops-in-kota-bogor
6.top-rated-coffee
Sourced from https://www.kaggle.com/datasets/asimmahmudov/top-rated-coffee

---

### Methods Used | 使用的方法
- **Basic Aggregations 基本聚合**: COUNT, SUM, AVG, DISTINCT  
- **Grouping & Filtering 分组与筛选**: GROUP BY, HAVING, WHERE (with AND/OR)  
- **CTEs & Joins 公共表表达式与表连接**: multi-level grouping and multi-table analysis 多层次分组与跨表分析  
- **Window Functions 窗口函数**: ROW_NUMBER() for top-N ranking 每月门店Top-N排名  
- **Data Transformation 数据转换**: CONVERT, CAST, EXTRACT, STR_TO_DATE, CASE WHEN  
- **Union Operations 合并查询**: combining multiple results 合并不同条件下的结果  

---

### Analytical Goals | 分析目标
- **Product Structure 产品结构**: count and distribution of product categories 统计并分析产品类别分布  
- **Customer Characteristics 顾客特征**: gender, loyalty, repeat customers 按性别、会员类型、回头客分层  
- **Sales Performance 销售表现**: discovery source, time period, sales amount 按发现渠道、时间段、金额分析  
- **Behavioral Insights 消费行为洞察**: impact of coffee on focus and sleep quality 咖啡对专注度和睡眠的影响  
- **Data Quality Checks 数据质量检查**: duplicate records identification 检查并找出重复记录  
- **Consumer Preferences 消费者偏好**: taste evaluation across pH levels 不同酸碱度下的口感评价  
- **Store Performance 门店表现**: monthly top 3 stores by revenue 每月销售额前三的门店  
