-- ◆１
SELECT ID,名称,職業コード,HP,MP,状態コード
FROM パーティー

-- ◆解答
 正解

-- ◆2
SELECT 名称 AS 名前,HP AS 現在のHP,MP AS 現在のMP
FROM パーティー


-- ◆解答
--  正解

-- ◆3
SELECT *
FROM イベント

-- ◆解答
--  正解

-- ◆4
SELECT イベント番号 AS 番号,イベント名称 AS 場面
FROM イベント

-- ◆解答
--  正解

-- 5
INSERT INTO パーティー
VALUES ('A01','スガワラ','21',131,232,'03');
INSERT INTO パーティー
     VALUES ('A02', 'オーエ', '10', 156, 84, '00');
INSERT INTO パーティー
     VALUES ('A03', 'イズミ', '20', 84, 190, '00');

-- ◆解答
 正解

 -- 6
SELECT *
FROM パーティー
WHERE ID = 'C02'

-- ◆解答
 正解


-- 7
UPDATE パーティー
SET HP = 120
WHERE ID = 'A01'

-- ◆解答
 正解


 -- 8
SELECT ID,名称,HP
FROM パーティー
WHERE HP < 100

-- ◆解答
 正解

-- 9
SELECT ID,名称,HP
FROM パーティー
WHERE HP >= 100

-- ◆解答
 正解

-- 10
SELECT イベント番号,イベント名称,タイプ
FROM イベント
WHERE タイプ <> '3'

-- ◆解答
 正解

-- 11
SELECT イベント番号,イベント名称
FROM イベント
WHERE イベント番号 <= 5

-- ◆解答
 正解


-- 12
SELECT イベント番号,イベント名称
FROM イベント
WHERE イベント番号 > 20

-- ◆解答
 正解

 -- 13
SELECT イベント番号,イベント名称
FROM イベント
WHERE 前提イベント番号 IS NULL

-- ◆解答
 正解

-- 14
SELECT イベント番号,イベント名称,後続イベント番号
FROM イベント
WHERE 後続イベント番号 IS NOT NULL

-- ◆解答
 正解

-- 15
UPDATE パーティー
   SET 状態コード = '01'
 WHERE 名称 LIKE '%ミ%'

-- ◆解答
 正解