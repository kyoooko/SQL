-- ◆46
SELECT SUM(数量)
  FROM 注文

-- ◆解答
-- 正解

-- ◆47
SELECT SUM(数量)
  FROM 注文
GROUP BY 注文日
ORDER BY 注文日

-- ◆解答
SELECT 注文日, SUM(数量) AS 数量合計
  FROM 注文
 GROUP BY 注文日
 ORDER BY 注文日

--  ⭐️GROUP BY でくくったカラム名をSELECTの選択列に入れること


-- ◆48
SELECT 商品区分,MAX(単価),MIN(単価)
  FROM 商品
GROUP BY 商品区分
ORDER BY 商品区分

-- ◆解答
-- 正解
SELECT 商品区分, MIN(単価) AS 最小額, MAX(単価) AS 最高額
  FROM 商品
 GROUP BY 商品区分
 ORDER BY 商品区分

 -- ◆49
SELECT 商品コード,SUM(数量) AS 合計
  FROM 注文
GROUP BY 商品コード
ORDER BY 商品コード

-- ◆解答
-- 正解


-- ◆50
SELECT 商品コード,SUM(数量)
  FROM 注文
GROUP BY 商品コード
ORDER BY SUM(数量) DESC, 商品コード
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY


-- ◆解答
-- 正解
SELECT 商品コード, SUM(数量) AS 数量合計
  FROM 注文
 GROUP BY 商品コード
 ORDER BY 数量合計 DESC, 商品コード
OFFSET 0
 FETCH FIRST 10 ROWS ONLY

--  ⭐️ASは繰り返しの省略になる


-- ◆51
SELECT 商品コード,SUM(数量) AS 数量合計
  FROM 注文
GROUP BY 商品コード
HAVING SUM(数量) < 5

-- ◆解答
-- 正解


-- ◆52
SELECT COUNT(クーポン割引料) AS 割引件数, SUM(クーポン割引料) AS 割引額合計
  FROM 注文

-- ◆解答
-- 正解

-- ◆53
SELECT SUBSTRING(CAST(注文日 AS VARCHAR),1,4) || SUBSTRING(CAST(注文日 AS VARCHAR),6,2) AS 年月, COUNT(*) AS 注文件数
  FROM 注文
GROUP BY 年月
 ORDER BY 注文日 DESC

-- だとできなくて
SELECT SUBSTRING(CAST(注文日 AS VARCHAR),1,4) || SUBSTRING(CAST(注文日 AS VARCHAR),6,2) AS 年月, COUNT(*) AS 注文件数
  FROM 注文
GROUP BY 年月,注文日
 ORDER BY 注文日 DESC
--  GROUP BY 年月,注文日おかしい

-- ◆解答
SELECT SUBSTRING(注文番号, 1, 6) AS 年月, COUNT(*) AS 注文件数
  FROM 注文
 WHERE 注文枝番 = 1
 GROUP BY SUBSTRING(注文番号, 1, 6)
 ORDER BY SUBSTRING(注文番号, 1, 6)

 -- ◆54
SELECT 商品コード
  FROM 注文
  WHERE SUBSTRING(商品コード,1,1) = 'z'
GROUP BY 商品コード
 HAVING SUM(数量) >= 100

-- ◆解答
SELECT 商品コード
  FROM 注文
 WHERE 商品コード LIKE 'Z%'
 GROUP BY 商品コード
 HAVING SUM(数量) >= 100

--  ⭐️=は文字列では使えず、文字列の場合はLIKE使う

