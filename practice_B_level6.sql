-- ◆55
SELECT 商品コード, 商品名,単価,(SELECT SUM(数量) FROM 注文 WHERE 商品コード = 'S0604')AS 数量
  FROM 商品
  WHERE 商品コード = 'S0604'

-- ◆解答
-- 正解

-- ◆56
UPDATE 注文
SET 商品コード = (SELECT 商品コード FROM 商品 WHERE 商品区分='2' AND 商品名 LIKE '%ブーツ%'AND 商品名 LIKE '%雨%'AND 商品名 LIKE '%安心%')
WHERE 注文番号= '201803150014' AND 注文枝番= 1

-- ◆解答
-- 正解(注文日は特にいらないのでは）

UPDATE 注文
   SET 商品コード = (SELECT 商品コード
                     FROM 商品
		            WHERE 商品区分 = '2'
					  AND 商品名 LIKE '%ブーツ%'
					  AND 商品名 LIKE '%安心%'
				      AND 商品名 LIKE '%雨%')
 WHERE 注文日 = '2018-03-15'
   AND 注文番号 = '201803150014'
   AND 注文枝番 = 1


-- ◆57
SELECT 注文日 AS 日付, 商品コード
  FROM 注文
  WHERE 商品コード IN (SELECT 商品コード FROM 商品 WHERE 商品名 LIKE '%あったか%')
ORDER BY 注文日

-- ◆解答
-- 正解

-- ◆58
SELECT 商品コード, SUM(数量) AS 販売数量
  FROM 注文
GROUP BY 商品コード
HAVING  SUM(数量) >= ALL (SELECT SUM(数量) FROM 注文 GROUP BY 商品コード)


-- ◆解答
-- 結果は同じになった
SELECT 商品コード, SUM(数量) AS 数量
  FROM 注文
 GROUP BY 商品コード
HAVING SUM(数量) >ALL (SELECT AVG(数量)
                         FROM 注文
						GROUP BY 商品コード)

-- ❓：AVGとSUMの混合？

-- ◆59
-- 副問合せ使ってない
SELECT COUNT(クーポン割引料) AS 割引による販売量, TRUNC(AVG(クーポン割引料),0)AS 平均割引額
          FROM 注文
          WHERE 商品コード='W0746' AND クーポン割引料 IS NOT NULL

-- ◆⭐️解答
-- 結果は同じになった
          SELECT A.数量合計 AS 割引による販売数,
       TRUNC(A.割引料合計 / A.数量合計, 0) AS 平均割引額
  FROM (SELECT SUM(数量) AS 数量合計,
               SUM(クーポン割引料) AS 割引料合計
          FROM 注文
         WHERE 商品コード = 'W0746'
		   AND クーポン割引料 IS NOT NULL) AS A

-- COUNT(クーポン割引料)だと販売数量にならないので✖️だった


-- ◆60
INSERT INTO 注文
SELECT 注文日,注文番号,注文枝番 + 1 AS 注文枝番,商品コード,数量,クーポン割引料
FROM 注文
WHERE 注文日 = '2018-03-21'
   AND 注文番号 = '201803210080'
   AND 注文枝番 = 注文枝番 + 1
   AND 商品コード = 'S1003'
   AND 数量 = 1
   AND クーポン割引料 IS NULL;

INSERT INTO 注文
SELECT 注文日,注文番号,注文枝番 + 1 AS 注文枝番,商品コード,数量,クーポン割引料
FROM 注文
WHERE 注文日 = '2018-03-22'
   AND 注文番号 = '201803220901'
   AND 注文枝番 = 注文枝番 + 1
   AND 商品コード = 'AA0052'
   AND 数量 = 2
   AND クーポン割引料 =500;

-- ◆解答
INSERT INTO 注文
SELECT 注文日, 注文番号, MAX(注文枝番) + 1, 'S1003', 1, NULL
  FROM 注文
 WHERE 注文日 = '2018-03-21'
   AND 注文番号 = '201803210080'
 GROUP BY 注文日, 注文番号;
INSERT INTO 注文
SELECT 注文日, 注文番号, MAX(注文枝番) + 1, 'A0052', 2, 500
  FROM 注文
 WHERE 注文日 = '2018-03-22'
   AND 注文番号 = '201803220901'
 GROUP BY 注文日, 注文番号;

--  注文番号 = '201803210080'の注文は何個もあるかもしれない＝注文枝番多数を想定しなければいけない