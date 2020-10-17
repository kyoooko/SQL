-- ◆61
SELECT T.注文番号,T.注文枝番,T.商品コード,S.商品名,T.数量
  FROM 注文 AS T
JOIN 商品 AS S
ON T.商品コード = S.商品コード
  WHERE  T.注文番号 = '201801130115'
ORDER BY T.注文番号,T.注文枝番

-- ◆解答
-- 正解
-- 商品コードNOT NULLだからLEFT JOINなどしなくていい


-- ◆62
SELECT T.注文日, T.注文番号, T.注文枝番, T.数量,
       H.単価 * T.数量 AS 注文金額
  FROM 注文 AS T
  JOIN 廃番商品 AS H
    ON T.商品コード = H.商品コード
 WHERE T.商品コード = 'A0009'
   AND T.注文日 > H.廃番日

-- ◆解答
-- 正解

-- ◆63
  SELECT S.商品コード,S.商品名,S.単価,T.注文日,T.注文番号,T.数量, S.単価 * T.数量 AS 売上金額
  FROM 商品 AS S
  LEFT JOIN 注文 AS T
  ON S.商品コード = T.商品コード
  WHERE  S.商品コード = 'S0604'
  ORDER BY T.注文日

  -- 商品はあるけど注文がまだないパターンもあるので

-- ◆解答
SELECT S.商品コード, S.商品名, S.単価,
       T.注文日, T.注文番号, T.数量,
	   S.単価 * T.数量 AS 売上金額
  FROM 商品 AS S
  JOIN 注文 AS T
    ON S.商品コード = T.商品コード
 WHERE S.商品コード = 'S0604'
 ORDER BY T.注文番号

-- ❓：注文日だと被るかもなので注文番号
-- LEFT JOINでなくてよかった。この問題では商品コード = 'S0604'のみの抽出で注文あることわかってえるので


-- ◆64
  SELECT S.商品コード,S.商品名
  FROM 商品 AS S
  LEFT JOIN 注文 AS T
  ON S.商品コード = T.商品コード
  WHERE  T.注文日 >= '2016-08-01' AND T.注文日 <= '2016-08-31'
  --  WHERE  T.注文日 BETWEEN '2016-08-01' AND '2016-08-31'

-- ◆解答
SELECT T.商品コード, S.商品名
  FROM 注文 AS T
  JOIN 商品 AS S
    ON T.商品コード = S.商品コード
 WHERE T.注文日 >= '2016-08-01'
   AND T.注文日 < '2016-09-01'

  -- ◆65
SELECT T.商品コード, CASE WHEN  S.商品名 IS NOT NULL THEN S.商品名 ELSE '廃番' END AS 商品名
  FROM 注文 AS T
  LEFT JOIN 商品 AS S
    ON T.商品コード = S.商品コード
  JOIN 廃番商品 AS H
    ON T.商品コード = H.商品コード
 WHERE T.注文日 >= '2016-08-01'
   AND T.注文日 < '2016-09-01'


-- ◆解答
SELECT T.商品コード, COALESCE(S.商品名, '廃番') AS 商品名
  FROM 注文 AS T
  LEFT JOIN 商品 AS S
         ON T.商品コード = S.商品コード
 WHERE T.注文日 >= '2016-08-01'
   AND T.注文日 < '2016-09-01'

  --  LEFT JOINを使うのはあってた


-- ◆66
SELECT T.注文日,S.商品コード || ':' || S.商品名 AS 商品, COALESCE(T.数量, 0 ) AS 数量
  FROM 商品 AS S
  LEFT JOIN 注文 AS T
    ON S.商品コード = T.商品コード
 WHERE S.商品区分 = 3

-- ◆解答
SELECT T.注文日, S.商品コード || ':' || S.商品名 AS 商品,
       COALESCE(T.数量, 0) AS 数量
  FROM 注文 AS T
 RIGHT JOIN 商品 AS S
         ON T.商品コード = S.商品コード
	  WHERE S.商品区分 = '3'

    -- どっちのテーブルを主テーブルにするかの違い

-- ◆67
SELECT T.注文日, S.商品コード || ':' || COALESCE(S.商品名, '(廃番済み)') AS 商品名,
       COALESCE(T.数量, 0) AS 数量
  FROM 注文 AS T
 FULL JOIN 商品 AS S
         ON T.商品コード = S.商品コード
 LEFT JOIN 廃番商品 AS H
         ON T.商品コード = H.商品コード
	  WHERE S.商品区分 = '3'

もしくは

    SELECT T.注文日, S.商品コード || ':' || COALESCE(S.商品名, '(廃番済み)') AS 商品名,
       COALESCE(T.数量, 0) AS 数量
  FROM 注文 AS T
 FULL JOIN 商品 AS S
         ON T.商品コード = S.商品コード
	  WHERE S.商品区分 = '3'

-- ◆解答
SELECT T.注文日, S.商品コード || ':' || S.商品名 AS 商品, COALESCE(T.数量, 0) AS 数量
  FROM 注文 AS T
  RIGHT JOIN
  (SELECT 商品コード, 商品名, 商品区分 FROM 商品
    UNION
  SELECT 商品コード, '（廃番済み）' AS 商品名, 商品区分
  FROM 廃番商品) AS S
  ON T.商品コード = S.商品コード
  WHERE S.商品区分 = '3'

-- 自分の回答の仕方だとS.商品コードはおかしい

-- ◆68
SELECT T.注文日,T.注文番号,T.注文枝番, S.商品コード, S.商品名 ,S.単価,T.数量, (S.単価 * T.数量)-  COALESCE(T.クーポン割引料, 0) AS 注文金額
  FROM 注文 AS T
  RIGHT JOIN
  (SELECT 商品コード, 商品名, 単価 FROM 商品
    UNION
  SELECT 商品コード, 商品名, 単価  FROM 廃番商品) AS S
  ON T.商品コード = S.商品コード
  WHERE T.注文番号 = '201704030010'

-- ◆解答
SELECT T.注文日, T.注文番号, T.注文枝番, T.商品コード,
       COALESCE(S.商品名, H.商品名) AS 商品名,
       COALESCE(S.単価, H.単価) AS 単価,
	   T.数量 AS 数量,
       COALESCE(S.単価, H.単価) * T.数量 - COALESCE(T.クーポン割引料, 0) AS 注文金額
  FROM 注文 AS T
  LEFT JOIN 商品 AS S
         ON T.商品コード = S.商品コード
  LEFT JOIN 廃番商品 AS H
         ON T.商品コード = H.商品コード
 WHERE T.注文番号 = '201704030010'

--  結果はあってるが注文されてない商品や廃番商品は結果に含めないのでRIGHT JOINではなくJOINだと思う

-- ◆69
SELECT S.商品コード, S.商品名 ,S.単価,T.数量, S.単価 * T.数量 AS  総売上金額
  FROM 注文 AS T
  JOIN 商品 AS S
         ON T.商品コード = S.商品コード
  WHERE S.商品コード LIKE 'B%'
  ORDER BY S.商品コード

-- ◆解答
SELECT S.商品コード, S.商品名, S.単価, COALESCE(T.数量, 0) AS 売上数量,
       S.単価 * COALESCE(T.数量, 0) AS 総売上金額
  FROM 商品 AS S
  LEFT JOIN (SELECT 商品コード, SUM(数量) AS 数量
               FROM 注文
              WHERE 商品コード LIKE 'B%'
		      GROUP BY 商品コード) AS T
         ON S.商品コード = T.商品コード
 WHERE S.商品コード LIKE 'B%'
 ORDER BY S.商品コード

-- SUM(数量)をしないと同じ商品コードのものが別の列でとれてしまう
-- 注文されてないものも含むのでCOALESCE(T.数量, 0)とLEFT JOIN


-- ◆70
  SELECT S.商品コード, S.商品名 ,S.関連商品コード, K.商品名 AS 関連商品名
  FROM 商品 AS S
  JOIN 商品 AS K
         ON S.関連商品コード = K.商品コード

-- ◆解答
-- 正解(同じ)

SELECT S1.商品コード, S1.商品名,
       S2.商品コード AS 関連商品コード, S2.商品名 AS 関連商品名
  FROM 商品 AS S1
  JOIN 商品 AS S2
    ON S1.商品コード = S2.関連商品コード