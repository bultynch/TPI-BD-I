USE foodstore_db;

-- CATEGORIAS

INSERT INTO categoria(nombre, descripcion) VALUES ('Pizzas', 'Productos elaborados con masa y queso'), ('Hamburguesas', 'Hamburguesas y combos');


-- PRODUCTOS

INSERT INTO producto(nombre, precio, descripcion, stock, imagen, disponible, categoria_id) VALUES
('Muzzarella', 8500, 'Pizza tradicional', 20, 'muzzarella.jpg', TRUE, 1), ('Hamburguesa Completa', 12000, 'Con papas fritas', 15, 'hamburguesa.jpg', TRUE, 2);


-- USUARIOS

INSERT INTO usuario(nombre, apellido, mail, celular, contrasena, rol) VALUES
('Augusto', 'Perez', 'augustop@gmail.com', '3425123456', 'augusto123', 'USUARIO'), ('Maria', 'Lopez', 'marial@gmail.com', '3425678912', 'maria123', 'ADMIN');


-- PEDIDO

INSERT INTO pedido(fecha, estado, forma_pago, total, usuario_id) VALUES (CURDATE(), 'PENDIENTE', 'TARJETA', 20500, 1);


-- DETALLES

INSERT INTO detalle_pedido(cantidad, subtotal, pedido_id, producto_id) VALUES (1, 8500, 1, 1), (1, 12000, 1, 2);