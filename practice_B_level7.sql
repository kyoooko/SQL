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