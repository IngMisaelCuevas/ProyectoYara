CREATE TABLE Historial(
	Id INT PRIMARY KEY auto_increment,
    Numero_Usuario VARCHAR(20),
    Mensaje_Usuario VARCHAR(20),
    Opcion_Menu VARCHAR(20),
    RowCreateAt DATETIME
);

CREATE TABLE MensajeBienvenida (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Mensaje VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);

INSERT INTO MensajeBienvenida (Mensaje)
VALUES ('¡Bienvenido al chatbot de CJR Multiservicios. 😊');
