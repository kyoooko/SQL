-- ◆59 →単数行
UPDATE 口座
SET 残高 = 残高 + (
  SELECT 入金額
  FROM 取引
  WHERE 日付='2018-01-11' AND  口座番号='0351333'
) -
(
  SELECT 出金額
  FROM 取引
  WHERE 日付='2018-01-11' AND  口座番号='0351333'
)
WHERE 口座番号='0351333'

-- ◆解答
UPDATE 口座
   SET 残高 = 残高 + (SELECT COALESCE(SUM(入金額) - SUM(出金額), 0)
                       FROM 取引
                      WHERE 口座番号 = '0351333'
                        AND 日付 = '2018-01-11'),
       更新日 = '2018-01-11'
 WHERE 口座番号 = '0351333'

--  SUMのNULLの扱い（p216):NULLは集計に影響しないが全行がNULLならNULLを返す
--  入金や出勤は複数あるかもしれないのでSUM使用しないと
-- COALESCE：NULLの場合値を変換する
-- ⭐SUM(入金額) - SUM(出金額)がNULL-3000の時NULLにならないのか？→NULL-3000は-3000らしい


-- ◆60  →単数行
SELECT 残高 AS 現在の残高, (
  SELECT COALESCE(SUM(入金額) - SUM(出金額), 0)
  FROM 取引
  WHERE 口座='1115600' AND 取引日='2017-12-28'
) AS 入出金額の合計
FROM 口座
WHERE 口座='1115600' AND 取引日='2017-12-28'

-- ◆解答
SELECT 残高,
       (SELECT SUM(入金額)
          FROM 取引
		 WHERE 口座番号 = '1115600'
		   AND 日付     = '2017-12-28') AS 入金額合計,
       (SELECT SUM(出金額)
          FROM 取引
		 WHERE 口座番号 = '1115600'
		   AND 日付     = '2017-12-28') AS 出金額合計
  FROM 口座
 WHERE 口座番号 = '1115600'


--  ◆61  →複数行
SELECT 口座番号, 名義, 残高
FROM 口座
WHERE 口座番号 IN( 
  SELECT 口座番号
  FROM 取引
  WHERE 入金額 >= 1000000
)
-- ◆解答
正解


-- ◆62 →複数行
SELECT *
FROM 口座
GROUP BY 口座番号
HAVING 更新日 > ALL( 
  SELECT 日付
  FROM 取引
)
-- ◆解答
SELECT * FROM 口座
 WHERE 更新日 >ALL (SELECT 日付 FROM 取引)

-- 口座テーブルに置いて口座は一意なのでGROUP BY にする必要なかった
-- SELECT 日付 FROM 取引の日付のどれよりも新しい更新日
-- 口座ごとの話でなく全体において！！


-- ◆63 →単１行,表
SELECT A.日付, A.MAX(入金額), A.MAX(出金額)
FROM (
  SELECT *
  FROM 取引
  WHERE 口座番号= '2761055' AND 入金額 IS NOT NULL AND 出金額 IS NOT NULL
) AS A
 WHERE 口座番号= '2761055'

 -- ◆解答
SELECT A. 日付,
       (SELECT MAX(入金額) FROM 取引 WHERE 口座番号 = '3104451') AS 最大入金額,
       (SELECT MAX(出金額) FROM 取引 WHERE 口座番号 = '3104451') AS 最大出金額
  FROM (SELECT 日付
          FROM 取引
         WHERE 口座番号 = '3104451'
         GROUP BY 日付
        HAVING SUM(入金額) > 0 AND SUM(出金額) > 0) AS A

-- SUM(入金額) > 0 ：全行NULLの場合はNULL

-- ◆64 →表
INSERT INTO 廃止口座
SELECT *
FROM 口座
WHERE 口座番号='2761055'

DELETE FROM 口座
WHERE 口座番号='2761055'

 -- ◆解答
INSERT INTO 廃止口座
SELECT * FROM 口座
 WHERE 口座番号 = '2761055';
DELETE FROM 口座
 WHERE 口座番号 = '2761055';

--  ２つSQL文書くとき;必要