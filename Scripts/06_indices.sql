USE foodstore_db;

-- CREAMOS ÍNDICES

CREATE INDEX idx_producto_nombre ON producto(nombre);
CREATE INDEX idx_producto_precio ON producto(precio);
CREATE INDEX idx_pedido_usuario ON pedido(usuario_id);

-- CONSULTA POR IGUALDAD
SELECT * FROM producto WHERE nombre='Producto 10';

-- ver el plan de ejecución
EXPLAIN SELECT * FROM producto WHERE nombre='Producto 10';

-- CONSULTA POR RANGO
SELECT * FROM producto WHERE precio BETWEEN 5000 AND 10000;

-- explain
EXPLAIN SELECT * FROM producto WHERE precio BETWEEN 5000 AND 10000;

-- CONSULTA JOIN
SELECT p.id, u.nombre FROM pedido p INNER JOIN usuario u ON p.usuario_id=u.id;

-- explain
EXPLAIN SELECT p.id, u.nombre FROM pedido p INNER JOIN usuario u ON p.usuario_id=u.id;

-- JOINS producto-categoria
SELECT p.nombre, c.nombre FROM producto p INNER JOIN categoria c ON p.categoria_id=c.id;

-- GROUP BY + HAVING
SELECT u.id, COUNT(p.id) FROM usuario u INNER JOIN pedido p ON u.id=p.usuario_id GROUP BY u.id HAVING COUNT(p.id)>3;

-- VISTA
SELECT * FROM vw_pedidos_completos;