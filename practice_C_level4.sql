-- 33
SELECT 名称 AS なまえ,HP AS 現在のHP,HP + 50 AS 装備後のHP
FROM パーティー
WHERE 職業コード IN('11','21')

-- ◆解答
--  正解


-- 34
UPDATE パーティー
   SET MP = MP + 20
 WHERE ID IN ('A01', 'A03')

-- ◆解答
--  正解

-- 35
SELECT 名称 AS なまえ,HP AS 現在のHP, HP *2 AS 予想されるダメージ
FROM パーティー
WHERE 職業コード = '11'

-- ◆解答
--  正解


-- 36
SELECT 名称 AS なまえ,
        CAST(HP AS VARCHAR)  || '／'  || CAST(MP AS VARCHAR) AS HPとMP,
        CASE 状態コード WHEN '00' THEN ''
                        WHEN '01' THEN '眠り'
                        WHEN '02' THEN '毒'
                        WHEN '03' THEN '沈黙'
                        WHEN '04' THEN '混乱'
                        WHEN '09' THEN '気絶' 
                        END AS ステータス
FROM パーティー


-- ◆解答
--  正解(結果同じ)
SELECT 名称 AS なまえ, HP || '／' || MP AS HPとMP,
       CASE 状態コード WHEN '00' THEN NULL
                     WHEN '01' THEN '眠り'
                     WHEN '02' THEN '毒'
                     WHEN '03' THEN '沈黙'
                     WHEN '04' THEN '混乱'
                     WHEN '09' THEN '気絶'
       END AS ステータス
  FROM パーティー

  -- 空白の時はNULLか''

-- 37
SELECT イベント番号,
       イベント名称,
      CASE タイプ WHEN '1' THEN '強制'
                  WHEN '2' THEN 'フリー'
                  WHEN '3' THEN '特殊'
                  END AS タイプ,
      CASE WHEN イベント番号 BETWEEN 1 AND 10 THEN '序盤'
                イベント番号 BETWEEN 11 AND 17  THEN '中盤'
                ELSE '終盤'
                END AS 発生時期
FROM イベント

-- ◆解答
--  なぜか上記できず
SELECT イベント番号, イベント名称,
       CASE タイプ WHEN '1' THEN '強制'
                 WHEN '2' THEN 'フリー'
                 WHEN '3' THEN '特殊'
       END AS タイプ,
       CASE WHEN イベント番号 >= 1 AND イベント番号 <=10 THEN '序盤'
            WHEN イベント番号 >= 11 AND イベント番号 <=17 THEN '中盤'
            ELSE '終盤'
       END AS 発生時期
  FROM イベント

  -- 38
SELECT 名称 AS なまえ,HP AS 現在のHP,  LENGTH(名称) * 10 AS 予想ダメージ
FROM パーティー

-- ◆解答
正解

-- 39
UPDATE パーティー
SET 状態コード = '04'
WHERE HP % 4 = 0 OR  MP % 4 = 0

-- ◆解答
正解
/* MOD関数を使った場合 */
UPDATE パーティー
   SET 状態コード = '04'
 WHERE MOD(HP, 4) = 0
    OR MOD(MP, 4) = 0;

-- 40
TRUNC(777 * 0.7, 0)

-- ◆解答
SELECT TRUNC(777 * 0.7, 0) AS 支払った金額


-- 41
UPDATE パーティー
SET HP = ROUND(HP * 1.3,0) , MP = ROUND(MP * 1.3,0)


-- ◆解答
正解

-- 42
SELECT 名称 AS なまえ, HP, POWER(HP,0) AS 攻撃１回目, POWER(HP,1) AS 攻撃２回目, POWER(HP,2) AS 攻撃３回目
FROM パーティー
WHERE 職業コード = '10'

-- ◆解答
正解

-- 43
SELECT 名称 AS なまえ, HP, 状態コード,
      CASE WHEN HP <= 50 THEN 3 + CAST(状態コード AS INTEGER)
      CASE WHEN  HP >= 51 AND HP <= 100 THEN 2 + CAST(状態コード AS INTEGER)
      -- CASE WHEN  HP BETWEEN 51 AND  100 THEN 2 + CAST(状態コード AS INTEGER)
      CASE WHEN  HP >= 101 AND HP <= 150 THEN 1 + CAST(状態コード AS INTEGER)
      ELSE CAST(状態コード AS INTEGER)
      END AS リスク値
FROM パーティー
ORDER BY リスク値 DESC ,HP

-- ◆解答
正解(上記なぜかできず)
SELECT 名称 AS なまえ, HP,状態コード,
       CASE WHEN HP <= 50 THEN 3 + CAST(状態コード AS INTEGER)
            WHEN HP >= 51 AND HP <= 100 THEN 2 + CAST(状態コード AS INTEGER)
            WHEN HP >= 101 AND HP <= 150 THEN 1 + CAST(状態コード AS INTEGER)
            ELSE CAST(状態コード AS INTEGER) 
       END AS リスク値
  FROM パーティー
 ORDER BY リスク値 DESC, HP


-- 44
SELECT COALESCE(前提イベント番号,'前提なし') AS 前提イベント番号, イベント番号, COALESCE(後続イベント番号,'後続なし') AS 後続イベント番号
FROM イベント
ORDER BY イベント番号

-- ◆解答
SELECT COALESCE(CAST(前提イベント番号 AS VARCHAR), '前提なし') AS 前提イベント番号,
       イベント番号,
       COALESCE(CAST(後続イベント番号 AS VARCHAR), '後続なし') AS 後続イベント番号
  FROM イベント
 ORDER BY イベント番号