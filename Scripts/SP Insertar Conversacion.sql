DELIMITER $$

DROP PROCEDURE IF EXISTS InsertarConversacion $$
CREATE PROCEDURE InsertarConversacion(
    IN pNumeroUsuario VARCHAR(20),
    IN pMensajeUsuario VARCHAR(255),
    IN pOpcionMenu VARCHAR(50)
)
BEGIN
    DECLARE vUltimoId INT;

    IF pMensajeUsuario = '0' THEN
        DELETE FROM Historial WHERE Numero_Usuario = pNumeroUsuario;

    ELSE
        INSERT INTO Historial (Numero_Usuario, Mensaje_Usuario, Opcion_Menu, RowCreateAt)
        VALUES (pNumeroUsuario, pMensajeUsuario, pOpcionMenu, NOW());
    END IF;
END $$

DELIMITER ;
