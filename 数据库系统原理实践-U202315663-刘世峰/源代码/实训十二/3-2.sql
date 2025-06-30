-- 事务2
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

START TRANSACTION;

DO SLEEP(2);               -- 保证 t1 已完成第一次读取

-- 时刻2：第一次读取（159）
INSERT INTO result
SELECT NOW(), 2 t, tickets
FROM ticket
WHERE flight_no = 'CZ5525';

DO SLEEP(2);               -- 等 t1 已 UPDATE 但未 COMMIT

-- 时刻4：第二次读取（158）— 不可重复读
INSERT INTO result
SELECT NOW(), 2 t, tickets
FROM ticket
WHERE flight_no = 'CZ5525';

-- 修改余票并立即读取（157）
UPDATE ticket
SET tickets = tickets - 1
WHERE flight_no = 'CZ5525';

INSERT INTO result
SELECT NOW(), 2 t, tickets
FROM ticket
WHERE flight_no = 'CZ5525';

COMMIT;
