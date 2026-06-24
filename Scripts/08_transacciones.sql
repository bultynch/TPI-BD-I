USE foodstore_db;

-- PARTE 1 - COMMIT
START TRANSACTION;

UPDATE producto
SET stock = stock - 2
WHERE id = 1;

COMMIT;

-- verificamos
SELECT id, nombre, stock FROM producto WHERE id = 1;

-- PARTE 2 - ROLLBACK
START TRANSACTION;

UPDATE producto
SET stock = stock - 5
WHERE id = 1;

ROLLBACK;

-- verficamos
SELECT id, nombre, stock FROM producto WHERE id = 1;

-- PARTE 3 - READ COMMITED
-- consultamos el nivel actual
SELECT @@transaction_isolation;

-- configuramos
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- verificamos nuevamente
SELECT @@transaction_isolation;

-- PARTE 4 - REPETEABLE READ
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SELECT @@transaction_isolation;
