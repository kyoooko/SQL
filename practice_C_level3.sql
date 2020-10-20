 -- 23
SELECT DISTINCT 状況コード
FROM パーティー

-- ◆解答
--  正解

-- 24
SELECT ID,名称
FROM パーティー
ORDER BY ID

-- ◆解答
--  正解

-- 25
SELECT 名称,職業コード
FROM パーティー
ORDER BY 名称 DESC

-- ◆解答
--  正解

-- 26
SELECT 名称,HP,状態コード
FROM パーティー
ORDER BY 状態コード,HP DESC

-- ◆解答
--  正解

-- 27
SELECT タイプ,イベント番号,イベント名称,前提イベント番号,後続イベント番号
FROM イベント
ORDER BY 1,2

-- ◆解答
--  正解

-- 28
SELECT *
FROM パーティー
ORDER BY HP 
OFFSET 0 ROWS
FETCH NEXT 3 ROWS ONLY

-- ◆解答
--  正解

-- 29
SELECT *
FROM パーティー
ORDER BY MP
OFFSET 2 ROWS
FETCH NEXT 1 ROWS ONLY

-- ◆解答
--  正解

-- 30
SELECT CASE WHEN 職業コード LIKE '1%' THEN 'S'
            WHEN 職業コード LIKE '2%' THEN 'M'
            ELSE 'A'
            END AS 職業区分,職業コード,ID,名称
FROM パーティー
ORDER BY 職業コード

-- ◆解答
--  正解

-- 31
SELECT イベント番号
FROM イベント
EXCEPT
SELECT イベント番号
FROM 経験イベント
ORDER BY イベント番号

-- ◆解答
--  正解

-- 32
SELECT イベント番号
FROM イベント
WHERE タイプ = '2'
INTERSECT
SELECT イベント番号
FROM 経験イベント
WHERE クリア結果 IS NOT NULL

-- ◆解答
--  正解(結果同じ)
   SELECT イベント番号
     FROM 経験イベント
    WHERE クリア区分 ='1'
INTERSECT
   SELECT イベント番号
     FROM イベント
    WHERE タイプ ='2'