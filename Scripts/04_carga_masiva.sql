USE foodstore_db;

INSERT INTO categoria(nombre, descripcion)
VALUES
('Empanadas','Empanadas fritas y al horno'),
('Bebidas','Gaseosas y jugos'),
('Postres','Productos dulces'),
('Sandwiches','Sandwiches variados'),
('Pastas','Platos de pastas'),
('Ensaladas','Opciones saludables'),
('Helados','Postres fríos'),
('Cafeteria','Café y acompañamientos');

-- CREAMOS UNA TABLA AUXILIAR

CREATE TABLE numeros(
    numero INT PRIMARY KEY
);

INSERT INTO numeros
VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(36),(37),(38),(39),(40),
(41),(42),(43),(44),(45),(46),(47),(48),(49),(50);

-- GENERAMOS 500 PRODUCTOS

INSERT INTO producto(
nombre,
precio,
descripcion,
stock,
imagen,
disponible,
categoria_id
)
SELECT
CONCAT('Producto ', numero),
ROUND(1000 + RAND()*15000,2),
'Producto generado automaticamente',
FLOOR(1 + RAND()*100),
'producto.jpg',
TRUE,
FLOOR(1 + RAND()*10)
FROM numeros;

-- GENERAMOS 1000 USUARIOS

INSERT INTO usuario(
nombre,
apellido,
mail,
celular,
contrasena,
rol
)
SELECT
CONCAT('Nombre', a.numero),
CONCAT('Apellido', b.numero),
CONCAT('usuario', a.numero, '_', b.numero, '@gmail.com'),
'3425000000',
'1234',
'USUARIO'
FROM numeros a
CROSS JOIN numeros b
LIMIT 1000;

SELECT COUNT(*) FROM categoria;
SELECT COUNT(*) FROM producto;
SELECT COUNT(*) FROM usuario;

-- GENERAMOS 3000 PEDIDOS

INSERT INTO pedido(
fecha,
estado,
forma_pago,
total,
usuario_id
)
SELECT
DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY),
ELT(FLOOR(1 + RAND()*4),
'PENDIENTE',
'CONFIRMADO',
'TERMINADO',
'CANCELADO'),
ELT(FLOOR(1 + RAND()*3),
'TARJETA',
'TRANSFERENCIA',
'EFECTIVO'),
0,
FLOOR(1 + RAND()*1000)
FROM numeros a
CROSS JOIN numeros b
LIMIT 3000;

-- GENERAMOS 6000 DETALLES DE PEDIDOS

INSERT INTO detalle_pedido(
cantidad,
subtotal,
pedido_id,
producto_id
)
SELECT FLOOR(1 + RAND()*5), 0, FLOOR(1 + RAND()*3000), FLOOR(1 + RAND()*50) FROM numeros a CROSS JOIN numeros b LIMIT 6000;

-- ACTUALIZAMOS SUBTOTALES

UPDATE detalle_pedido dp JOIN producto p ON dp.producto_id = p.id SET dp.subtotal = dp.cantidad * p.precio;

-- ACTUALIZAMOS EL TOTAL DE PEDIDOS

UPDATE pedido ped
JOIN(
    SELECT
    pedido_id,
    SUM(subtotal) total_calculado
    FROM detalle_pedido
    GROUP BY pedido_id
) t
ON ped.id = t.pedido_id
SET ped.total = t.total_calculado;

-- VERIFICAMOS LA CANTIDAD DE REGISTROS

SELECT COUNT(*) AS categorias FROM categoria;
SELECT COUNT(*) AS productos FROM producto;
SELECT COUNT(*) AS usuarios FROM usuario;
SELECT COUNT(*) AS pedidos FROM pedido;
SELECT COUNT(*) AS detalles FROM detalle_pedido;

-- VERIFICAMOS LAS FK HUÉRFANAS
-- pedidos sin usuarios

SELECT COUNT(*) FROM pedido p LEFT JOIN usuario u ON p.usuario_id = u.id WHERE u.id IS NULL;

-- detalles sin pedidos

SELECT COUNT(*) FROM detalle_pedido d LEFT JOIN pedido p ON d.pedido_id = p.id WHERE p.id IS NULL;

-- detalles sin producto

SELECT COUNT(*) FROM detalle_pedido d LEFT JOIN producto p ON d.producto_id = p.id WHERE p.id IS NULL;

-- verificamos el stock negativo

SELECT * FROM producto WHERE stock < 0;

SELECT * FROM producto LIMIT 20;

