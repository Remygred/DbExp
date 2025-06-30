-- 事务1
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

START TRANSACTION;

-- 时刻1：第一次读取（159）
INSERT INTO result
SELECT NOW(), 1 t, tickets
FROM ticket
WHERE flight_no = 'CZ5525';

DO SLEEP(3);               -- 让 t2 先完成第一次读取

-- 时刻3：UPDATE 后立即读取（158）
UPDATE ticket
SET tickets = tickets - 1
WHERE flight_no = 'CZ5525';

INSERT INTO result
SELECT NOW(), 1 t, tickets
FROM ticket
WHERE flight_no = 'CZ5525';

DO SLEEP(2);               -- 让 t2 脏读 158

COMMIT;

DO SLEEP(1);               -- 等 t2 提交

-- 时刻6：最终读取（157）
INSERT INTO result
SELECT NOW(), 1 t, tickets
FROM ticket
WHERE flight_no = 'CZ5525';
