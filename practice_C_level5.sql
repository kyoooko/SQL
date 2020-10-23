-- 45
SELECT ID,SUM(HP) AS HPの合計 ,MAX(HP) AS HPの最大値, MIN(HP) AS HPの最小値,SUM(MP) AS MPの合計,MAX(MP) AS MPの最大値, MIN(MP) AS MPの最小値
FROM パーティー
GROUP BY ID

-- ◆解答
正解


-- ◆46
-- COUNT(*)でも良いと思う
SELECT CASE タイプ WHEN '1' THEN '強制'
                   WHEN '2' THEN 'フリー'
                   WHEN '3' THEN '特殊'
                   END AS タイプ, COUNT(イベント番号) AS イベント数
FROM イベント
GROUP BY タイプ

-- ◆解答
正解


-- ◆47
SELECT クリア結果,COUNT(イベント番号) AS クリアイベント数
FROM 経験イベント
WHERE クリア区分='1'
GROUP BY クリア結果
ORDER BY クリア結果

-- ◆解答
正解

-- ◆48
SELECT CASE WHEN SUM(MP) < 500 THEN '敵は見とれている!'
            WHEN SUM(MP) >= 500 AND SUM(MP) < 1000 THEN '敵は呆然としている!'
            WHEN SUM(MP) >= 1000 THEN '敵はひれ伏している!'
            END AS 小さな奇跡
FROM パーティー

-- ◆解答
正解

-- ◆49
SELECT CASE クリア区分 WHEN '0' THEN 'クリアした'
                       WHEN '1' THEN '参加したがクリアしていない'
                      END AS 区分, COUNT(イベント番号) AS イベント数
FROM 経験イベント
GROUP BY クリア区分

-- ◆解答
正解

-- ◆50
SELECT SUBSTRING(職業コード,1,1) AS 職業タイプ,SUM(HP) AS HPの合計 ,MAX(HP) AS HPの最大値, MIN(HP) AS HPの最小値,SUM(MP) AS MPの合計,MAX(MP) AS MPの最大値, MIN(MP) AS MPの最小値
FROM パーティー
GROUP BY SUBSTRING(職業コード,1,1)

-- ◆解答
正解

-- ◆51
SELECT SUBSTRING(ID,1,1) AS IDによる分類,AVG(HP) AS HPの平均,AVG(MP) AS MPの平均
FROM パーティー
GROUP BY SUBSTRING(ID,1,1)
HAVING AVG(HP) > 100

-- ◆解答
正解

-- ◆52
SELECT SUM(CASE WHEN HP < 100 THEN 1
     WHEN  HP >= 100 AND HP < 150 THEN 2
     WHEN  HP >= 150 AND HP < 200 THEN 3
     WHEN  HP >= 200 THEN 5
     END AS 扉の数) AS 力の扉
FROM パーティー

-- ◆解答
正解


