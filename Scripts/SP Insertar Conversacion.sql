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

    -- Si el usuario envía -1 → elimina solo el último mensaje
    ELSEIF pMensajeUsuario = '-1' THEN
        SELECT Id INTO vUltimoId
        FROM Historial
        WHERE Numero_Usuario = pNumeroUsuario
        ORDER BY RowCreateAt DESC
        LIMIT 1;

        IF vUltimoId IS NOT NULL THEN
            DELETE FROM Historial WHERE Id = vUltimoId;
        END IF;

    -- Si no es 0 ni -1 → inserta el nuevo registro normalmente
    ELSE
        INSERT INTO Historial (Numero_Usuario, Mensaje_Usuario, Opcion_Menu, RowCreateAt)
        VALUES (pNumeroUsuario, pMensajeUsuario, pOpcionMenu, NOW());
    END IF;
END $$

DELIMITER ;
