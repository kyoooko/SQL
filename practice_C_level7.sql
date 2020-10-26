
-- ◆⭐️62
SELECT K.ルート番号,K.イベント番号, I.イベント名称, K.クリア結果
  FROM イベント AS I
  JOIN 経験イベント AS K
  ON K.イベント番号 = I.イベント番号
  WHERE K.クリア区分 = '1'
ORDER BY K.ルート番号

-- 副問合せで書くと
SELECT K.ルート番号,K.イベント番号, (SELECT イベント名称 FROM イベント AS I WHERE  K.イベント番号 = I.イベント番号) AS イベント名称, K.クリア結果
  FROM 経験イベント AS K
  WHERE K.クリア区分 = '1'
ORDER BY K.ルート番号

-- ◆解答
--  正解


-- ◆63
SELECT I.イベント番号, I.イベント名称, K.クリア区分
  FROM イベント AS I
  JOIN 経験イベント AS K
  ON K.イベント番号 = I.イベント番号
  WHERE I.タイプ = '1'

  -- →未着手のイベントは考慮しなくて良い＝JOIN
-- ◆解答
--  正解

-- ◆64
SELECT I.イベント番号, I.イベント名称, COALESCE(K.クリア区分, '未クリア') AS クリア区分
  FROM イベント AS I
  LEFT JOIN 経験イベント AS K
  ON K.イベント番号 = I.イベント番号
  WHERE I.タイプ = '1'

-- ◆解答
--  正解

-- ◆65(JOINの副問い合わせC：表)
SELECT P.ID AS ID, P.名称 AS 名前, CS.コード名称 AS 職業, CJ.コード名称 AS 状態
  FROM パーティー AS P
  JOIN (SELECT コード名称 FROM コード WHERE コード種別 = '1') AS CS
  ON CS.コード値 = P.職業コード
  JOIN (SELECT コード名称 FROM コード WHERE  CJ.コード種別 = '2') AS CJ
  ON CJ.コード値 = P.状態コード
  -- できず→JOIN (SELECT にコード値必要だった

  -- 副問合せ
  SELECT P.ID AS ID, P.名称 AS 名前, 
  (SELECT コード名称 FROM コード AS C WHERE  C.コード種別 = 1) AS 職業, (SELECT コード名称 FROM コード AS C WHERE  C.コード種別 = 2) AS 状態
  FROM パーティー AS P
  -- できず
  -- ERROR: more than one row returned by a subquery used as an expression

-- ◆解答
SELECT P.ID, P.名称 AS なまえ,
       S.コード名称 AS 職業, J.コード名称 AS 状態
  FROM パーティー P
  JOIN (SELECT コード値, コード名称
          FROM コード
         WHERE コード種別 ='1') S
    ON P.職業コード = S.コード値
  JOIN (SELECT コード値, コード名称
          FROM コード
         WHERE コード種別 ='2') J
    ON P.状態コード = J.コード値
 ORDER BY ID

-- JOIN (SELECT コード値, コード名称〜)にコード値ないとONで繋げないので必要 P.262o

-- ◆66
SELECT P.ID, COALESCE(P.名称,'仲間になっていない！') AS なまえ, S.コード名称 AS 職業
  FROM パーティー AS P
  RIGHT JOIN (SELECT コード値, コード名称
          FROM コード
         WHERE コード種別 ='1') AS S
    ON P.職業コード = S.コード値

-- ◆解答
-- 正解

-- ◆67
SELECT K.イベント番号,K.クリア区分, C.コード値 || ':'|| C.コード名称 AS クリア結果
  FROM 経験イベント AS K
   RIGHT JOIN (SELECT コード値, コード名称
          FROM コード
         WHERE コード種別 ='4') AS C
    ON K.クリア結果 = C.コード値

-- ◆解答
-- 正解
SELECT E.イベント番号, E.クリア区分,
       C.コード値 || '：' || C.コード名称 AS クリア結果
  FROM 経験イベント E
  FULL JOIN (SELECT コード値, コード名称
               FROM コード
              WHERE コード種別 ='4') C
         ON E.クリア結果 = C.コード値
/*
-- FULL JOINが使えない場合、以下で代替
SELECT E.イベント番号, E.クリア区分,
       E.クリア結果 || '：' || C.コード名称 AS クリア結果
  FROM 経験イベント E
  LEFT JOIN (SELECT コード値, コード名称
               FROM コード
              WHERE コード種別 ='4') C
         ON E.クリア結果 = C.コード値
UNION
SELECT E.イベント番号, E.クリア区分,
       C.コード値 || '：' || C.コード名称 AS クリア結果
  FROM 経験イベント E
 RIGHT JOIN (SELECT コード値, コード名称
               FROM コード
              WHERE コード種別 ='4') C
         ON E.クリア結果 = C.コード値
*/

-- →問題文よく読む

-- ◆68
SELECT I.イベント番号,I.イベント名称, I.前提イベント番号, Z.イベント名称
  FROM イベント AS I
   JOIN (SELECT イベント番号,イベント名称
          FROM イベント) AS Z
    ON I.前提イベント番号 = Z.イベント番号
    WHERE I.前提イベント番号 IS NOT NULL

-- ◆解答
-- 答えは同じ。別に副問合せ＋JOINにする必要ない
SELECT E1.イベント番号, E1.イベント名称,
       E1.前提イベント番号, E2.イベント名称 AS 前提イベント名称
  FROM イベント E1
  JOIN イベント E2
    ON E1.前提イベント番号 = E2.イベント番号
 WHERE E1.前提イベント番号 IS NOT NULL

 -- ◆69
SELECT E1.イベント番号, E1.イベント名称,
       E1.前提イベント番号, E2.イベント名称 AS 前提イベント名称,
       E1.後続イベント番号, E3.イベント名称 AS 後続イベント名称
  FROM イベント E1
  JOIN イベント E2
    ON E1.前提イベント番号 = E2.イベント番号
  JOIN イベント E3
    ON E1.後続イベント番号 = E3.イベント番号
 WHERE E1.前提イベント番号 IS NOT NULL AND  E1.後続イベント番号 IS NOT NULL

-- ◆解答
SELECT E1.イベント番号, E1.イベント名称,
       E1.前提イベント番号, E2.イベント名称 AS 前提イベント名称,
       E1.後続イベント番号, E3.イベント名称 AS 後続イベント名称
  FROM イベント E1
  LEFT JOIN イベント E2
         ON E1.前提イベント番号 = E2.イベント番号
  LEFT JOIN イベント E3
         ON E1.後続イベント番号 = E3.イベント番号
 WHERE E1.前提イベント番号 IS NOT NULL
    OR E1.後続イベント番号 IS NOT NULL

-- →問題文よく読む

 -- ◆70
SELECT E1.イベント番号, E1.イベント名称,
        COUNT(E1.後続イベント番号) AS 前提イベント数
  FROM イベント E1
--   JOIN イベント E2
--     ON E1.後続イベント番号 = E2.イベント番号
--  WHERE E1.前提イベント番号 IS NOT NULL AND  E1.後続イベント番号 IS NOT NULL
GROUP BY E1.イベント番号, E1.イベント名称
HAVING COUNT(E1.後続イベント番号) <> 0
 ORDER BY E1.イベント番号

-- ◆解答
SELECT E.イベント番号, E.イベント名称, Z.前提イベント数
  FROM イベント E
  JOIN (SELECT 前提イベント番号,
               COUNT(前提イベント番号) AS 前提イベント数
          FROM イベント
         WHERE 前提イベント番号 IS NOT NULL
         GROUP BY 前提イベント番号) Z
    ON E.イベント番号 = Z.前提イベント番号
 ORDER BY E.イベント番号

 -- →表を見ながら考えるとわかりやすい。まずは日本語解釈の問題。前提イベント番号によるグループ別カウント数（NULL不可）テーブルと
-- イベント名称と付き合わせるため通常のイベントテーブルが必要なのでJOIN。自分の方法だとイベント番号でグループ化してるがcount1になってしまう