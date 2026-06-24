USE foodstore_db;

-- creamos usuarios con privilegios mínimos
CREATE USER 'operador_foodstore'@'localhost' IDENTIFIED BY 'food123';

-- otorgamos permisos
GRANT SELECT, INSERT, UPDATE ON foodstore_db.* TO 'operador_foodstore'@'localhost';

-- actualizar privilegios
FLUSH PRIVILEGES;

-- verificamos permisos
SHOW GRANTS FOR 'operador_foodstore'@'localhost';

-- primera vista donde ocultamos la contraseña
CREATE VIEW vw_usuarios_publicos AS
SELECT
    id,
    nombre,
    apellido,
    mail,
    celular,
    rol
FROM usuario;

SELECT * FROM vw_usuarios_publicos;

-- segunda vista
CREATE VIEW vw_productos_disponibles AS
SELECT
    id,
    nombre,
    precio,
    stock
FROM producto WHERE disponible = TRUE;

SELECT * FROM vw_productos_disponibles;

-- PRUEBAS DE INTEGRIDAD
-- violación de UNIQUE donde intentamos insertar un mail repetido
INSERT INTO usuario(nombre, apellido, mail, celular, contrasena, rol) VALUES ('Pedro', 'Gomez', 'juan@gmail.com', '3425000000', '1234', 'USUARIO');

-- violación de FK
INSERT INTO producto(nombre, precio, descripcion, stock, imagen, disponible, categoria_id) VALUES ('Producto Error', 1000, 'Prueba', 10, 'foto.jpg', TRUE, 99999);

-- PROCEDIMIENTO ALMACENADO SEGURO
DELIMITER //

CREATE PROCEDURE buscar_usuario_mail(
    IN p_mail VARCHAR(150)
)
BEGIN
    SELECT
        id,
        nombre,
        apellido,
        mail,
        rol
    FROM usuario
    WHERE mail = p_mail;
END//

DELIMITER ;

CALL buscar_usuario_mail('juan@gmail.com');

-- PRUEBA ANTI INYECCIÓN
CALL buscar_usuario_mail(''' OR 1=1 --');






