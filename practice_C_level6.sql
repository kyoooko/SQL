-- ◆53
SELECT 名称 AS なまえ, HP  AS 現在のHP, ROUND(HP / (SELECT AVG(HP)
FROM パーティー) * 100, 1 ) AS パーティーでの割合
FROM パーティー
WHERE 職業コード = '01'


-- ◆解答
SELECT 名称 AS なまえ, HP AS 現在のHP,
       ROUND(CAST(HP AS NUMERIC) / (SELECT SUM(HP) FROM パーティー) * 100, 1) AS パーティーでの割合
  FROM パーティー
 WHERE 職業コード = '01'

-- NUMERICにしないといけない
-- 今回はGROUP BYは使わない(勇者は一人しかいないし)


-- ◆54
UPDATE パーティー
SET MP = ROUND(CAST(MP AS NUMERIC) + (SELECT SUM(MP) FROM パーティー WHERE 職業コード <> '20') * 0.1 ,0)
WHERE 職業コード = '20'

-- ◆解答
多分正解
UPDATE パーティー
   SET MP = MP + (SELECT ROUND(SUM(MP * 0.1))
                    FROM パーティー
                   WHERE 職業コード <> '20')
 WHERE 職業コード = '20'

-- 小数点四捨五入なのでNUMERICここではいらない

-- ◆55
SELECT イベント番号, クリア結果
FROM 経験イベント
WHERE イベント番号 IN(SELECT イベント番号 FROM イベント WHERE タイプ IN('1','3'))

-- ◆解答
SELECT イベント番号, クリア結果
  FROM 経験イベント
 WHERE クリア区分 = '1'
   AND イベント番号 IN (SELECT イベント番号
                       FROM イベント
                      WHERE タイプ IN ('1', '3'))
-- クリア区分 = '1'忘れてた


-- ◆56
SELECT 名称,MP
FROM パーティー
WHERE MP >=ALL(SELECT MP FROM パーティー)

-- ◆解答
-- 答えは正解
SELECT 名称, MP
  FROM パーティー
 WHERE MP = (SELECT MAX(MP)
               FROM パーティー)

-- ◆57
SELECT イベント番号,イベント名称
FROM イベント
WHERE イベント番号 <> ALL(SELECT イベント番号 FROM 経験イベント)
-- WHERE イベント番号 NOT IN(SELECT イベント番号 FROM 経験イベント)

-- ◆解答
正解


-- ⭐️◆58
-- SELECT (COUNT(イベント番号) - COUNT(SELECT イベント番号 FROM 経験イベント)) AS 着手していないイベント数
-- FROM イベント
-- 上記ではうまくいかず
SELECT COUNT(イベント番号) AS 着手していないイベント数
FROM イベント
WHERE イベント番号 NOT IN(SELECT イベント番号 FROM 経験イベント)


-- ◆解答
-- 結果は同じ
SELECT COUNT(*) AS 未着手イベントの数
  FROM (SELECT イベント番号
          FROM イベント 
        EXCEPT
        SELECT イベント番号
          FROM 経験イベント) AS SUB


-- ◆59
SELECT イベント番号,イベント名称
  FROM イベント
WHERE  イベント番号 <
(SELECT イベント番号
  FROM 経験イベント
  ORDER BY イベント番号
  OFFSET 4ROWS
  FETCH NEXT 1ROWS ONLY)

-- ◆解答
-- 結果は同じ
SELECT イベント番号, イベント名称
  FROM イベント
 WHERE イベント番号 <ALL (SELECT イベント番号
                         FROM 経験イベント
                        WHERE ルート番号 = 5)


-- ◆60
-- 副問合せ使わず
  SELECT K.イベント番号,I.イベント名称,I.前提イベント番号
  FROM 経験イベント AS K
  JOIN イベント AS I
  ON I.イベント番号 = K.イベント番号 
    WHERE K.クリア区分 = '1'

  -- 副問合せ使う
  SELECT SUB.イベント番号,SUB.イベント名称,SUB.前提イベント番号
  FROM (SELECT イベント番号, イベント名称,前提イベント番号
  FROM イベント
  UNION
  SELECT イベント番号, NULL,NULL
  FROM 経験イベント) AS SUB
--  ??
  SELECT SUB.イベント番号,SUB.イベント名称,SUB.前提イベント番号
  FROM (SELECT イベント番号, イベント名称,前提イベント番号
  FROM イベント
  INTERSECT
  SELECT イベント番号, NULL,NULL
  FROM 経験イベント) AS SUB

-- ◆解答
SELECT イベント番号, イベント名称, 前提イベント番号
  FROM イベント
 WHERE 前提イベント番号 =ANY (SELECT イベント番号
                            FROM 経験イベント
                           WHERE クリア区分 = '1')
--  日本語の問題

-- ◆61
UPDATE 経験イベント
SET  クリア区分= '1',クリア結果 = 'B'
WHERE イベント番号 = 9;

INSERT INTO 経験イベント(イベント番号,クリア区分,クリア結果,ルート番号)
SELECT 後続イベント番号,'0',NULL,'9'
FROM イベント
WHERE イベント番号 = 9;

-- ◆解答
-- 結果は同じ
/* イベント番号9の更新 */
UPDATE 経験イベント
   SET クリア区分 = '1',
       クリア結果 = 'B'
 WHERE イベント番号 = 9;
/* 後続イベントの登録 */
 INSERT INTO 経験イベント
      VALUES ((SELECT イベント番号 FROM イベント WHERE 前提イベント番号 = 9),
              '0', NULL,
              (SELECT MAX(ルート番号) + 1 FROM 経験イベント));

-- ❓：ルート番号
