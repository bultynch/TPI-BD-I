USE foodstore_db;

CREATE TABLE categoria(
    id BIGINT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    eliminado BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_categoria
        PRIMARY KEY(id),

    CONSTRAINT uk_categoria_nombre
        UNIQUE(nombre)
);

CREATE TABLE producto(
    id BIGINT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    descripcion VARCHAR(255),
    stock INT NOT NULL,
    imagen VARCHAR(255),
    disponible BOOLEAN NOT NULL DEFAULT TRUE,
    categoria_id BIGINT NOT NULL,
    eliminado BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_producto
        PRIMARY KEY(id),

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY(categoria_id)
        REFERENCES categoria(id),

    CONSTRAINT chk_precio
        CHECK(precio >= 0),

    CONSTRAINT chk_stock
        CHECK(stock >= 0)
);

CREATE TABLE usuario(
    id BIGINT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    mail VARCHAR(150) NOT NULL,
    celular VARCHAR(30),
    contrasena VARCHAR(100) NOT NULL,
    rol ENUM('ADMIN','USUARIO') NOT NULL,
    eliminado BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_usuario
        PRIMARY KEY(id),

    CONSTRAINT uk_mail
        UNIQUE(mail)
);

CREATE TABLE pedido(
    id BIGINT AUTO_INCREMENT,
    fecha DATE NOT NULL,
    estado ENUM(
        'PENDIENTE',
        'CONFIRMADO',
        'TERMINADO',
        'CANCELADO'
    ) NOT NULL,

    forma_pago ENUM(
        'TARJETA',
        'TRANSFERENCIA',
        'EFECTIVO'
    ) NOT NULL,

    total DECIMAL(10,2) NOT NULL,
    usuario_id BIGINT NOT NULL,
    eliminado BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_pedido
        PRIMARY KEY(id),

    CONSTRAINT fk_pedido_usuario
        FOREIGN KEY(usuario_id)
        REFERENCES usuario(id),

    CONSTRAINT chk_total
        CHECK(total >= 0)
);

CREATE TABLE detalle_pedido(
    id BIGINT AUTO_INCREMENT,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    pedido_id BIGINT NOT NULL,
    producto_id BIGINT NOT NULL,
    eliminado BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_detalle
        PRIMARY KEY(id),

    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY(pedido_id)
        REFERENCES pedido(id),

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY(producto_id)
        REFERENCES producto(id),

    CONSTRAINT chk_cantidad
        CHECK(cantidad > 0),

    CONSTRAINT chk_subtotal
        CHECK(subtotal >= 0)
);