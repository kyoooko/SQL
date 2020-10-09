-- ◆65
SELECT 口座番号,日付, B.取引事由名,取引金額
FROM 取引
WHERE 口座番号 IN ('0311240','1234161','2750902')
JOIN 取引事由 AS B
ON 取引.取引事由ID = 取引事由.ID
ORDER BY 取引番号

-- ◆解答
SELECT T.口座番号, T.日付, J.取引事由名,
       COALESCE(T.入金額, T.出金額) AS 取引金額
  FROM 取引 AS T
  JOIN 取引事由 AS J
    ON T.取引事由ID = J.取引事由ID
 WHERE T.口座番号 IN ('0311240', '1234161', '2750902')
 ORDER BY T.口座番号, T.取引番号

--  ◆66
SELECT K.口座番号, K.名義,K.残高, T.日付,T.入金額,T.出金額
  FROM 口座 AS K
  JOIN 取引 AS T
    ON K.口座番号= T.口座番号
 WHERE K.口座番号 ='0887132'
 ORDER BY T.日付

-- ◆解答
SELECT K.口座番号, K.名義, K.残高,
       T.日付, T.入金額, T.出金額
  FROM 口座 AS K
  JOIN 取引 AS T
    ON K.口座番号 = T.口座番号
 WHERE K.口座番号 = '0887132'
 ORDER BY T.取引番号

 -- 惜しい。同日もあるかもしれないからORDER BY T.取引番号


-- ◆67
SELECT T.口座番号, K.名義, K.残高
  FROM 取引 AS T
  JOIN 口座 AS K
    ON T.口座番号 = K.口座番号
 WHERE T.日付 = '2016-03-01'
 EXCEPT
 SELECT 口座番号,名義,解約時残高
 FROM 廃止口座

 -- ◆解答
 SELECT T.口座番号, K.名義, K.残高
  FROM 取引 AS T
  JOIN 口座 AS K
    ON T.口座番号 = K.口座番号
 WHERE T.日付 = '2016-03-01'

--  口座テーブルはそもそも現在有効な口座を登録する口座なのでEXCEPTは不要


-- ◆68
  SELECT T.口座番号, K.名義, K.残高
  FROM 取引 AS T
  JOIN 口座 AS K
    ON T.口座番号 = K.口座番号
   WHERE T.日付 = '2016-03-01'
 UNION
 SELECT 口座番号,'解約済み' AS 名義, 0 AS 解約時残高
 FROM 廃止口座

--  ◆解答
SELECT T.口座番号,
       COALESCE(K.名義, '解約済み') AS 名義,
       COALESCE(K.残高, 0) AS 残高
  FROM 取引 AS T
  LEFT JOIN 口座 AS K
         ON T.口座番号 = K.口座番号
 WHERE T.日付 = '2016-03-01'

--  UNIONだと2016-03-01の取引に限定する方法がない