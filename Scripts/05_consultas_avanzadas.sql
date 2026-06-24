USE foodstore_db;

-- CONSULTA 1 - MOSTRAR PRODUCTOS CON SU CATEGORÍA

SELECT
    p.id,
    p.nombre AS producto,
    p.precio,
    c.nombre AS categoria
FROM producto p
INNER JOIN categoria c
ON p.categoria_id = c.id;

-- CONSULTA 2 - PEDIDOS CON INFORMACIÓN DEL USUARIO

SELECT
    p.id,
    p.fecha,
    p.estado,
    p.total,
    CONCAT(u.nombre,' ',u.apellido) AS usuario
FROM pedido p
INNER JOIN usuario u
ON p.usuario_id = u.id;

-- CONSULTA 3 - USUARIOS CON MÁS DE 3 PEDIDOS

SELECT
    u.id,
    CONCAT(u.nombre,' ',u.apellido) AS usuario,
    COUNT(p.id) cantidad_pedidos
FROM usuario u
INNER JOIN pedido p
ON u.id = p.usuario_id
GROUP BY u.id
HAVING COUNT(p.id) > 3;

-- CONSULTA 4 - PRODUCTOS CON PRECIO MAYOR AL PROMEDIO

SELECT
    nombre,
    precio
FROM producto
WHERE precio >
(
    SELECT AVG(precio)
    FROM producto
);

-- CREAMOS UNA VISTA

CREATE VIEW vw_pedidos_completos AS
SELECT
    p.id,
    p.fecha,
    p.estado,
    p.forma_pago,
    p.total,
    CONCAT(u.nombre,' ',u.apellido) AS cliente
FROM pedido p
INNER JOIN usuario u
ON p.usuario_id = u.id;

SELECT * FROM vw_pedidos_completos;