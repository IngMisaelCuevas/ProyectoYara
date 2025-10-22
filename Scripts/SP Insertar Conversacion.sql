DELIMITER $$

DROP PROCEDURE IF EXISTS InsertarConversacion $$
CREATE PROCEDURE InsertarConversacion(
    IN pNumeroUsuario VARCHAR(20),
    IN pMensajeUsuario VARCHAR(255),
    IN pOpcionMenu VARCHAR(50)
)
BEGIN
    INSERT INTO Historial (Numero_Usuario, Mensaje_Usuario, Opcion_Menu, RowCreateAt)
    VALUES (pNumeroUsuario, pMensajeUsuario, pOpcionMenu, NOW());
END $$

DELIMITER ;
