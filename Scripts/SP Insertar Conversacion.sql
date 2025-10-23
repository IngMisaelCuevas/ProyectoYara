DELIMITER $$

DROP PROCEDURE IF EXISTS InsertarConversacion $$
CREATE PROCEDURE InsertarConversacion(
    IN pNumeroUsuario VARCHAR(20),
    IN pMensajeUsuario VARCHAR(255),
    IN pOpcionMenu VARCHAR(50),
    IN pIdMenu INT,
    IN pSubMenuNombre VARCHAR(100)
)
BEGIN
    DECLARE vUltimoId INT;

    -- Reiniciar conversación
    IF pMensajeUsuario = '0' THEN
        DELETE FROM Historial WHERE Numero_Usuario = pNumeroUsuario;

    -- Regresar un paso (eliminar último mensaje activo)
    ELSEIF pMensajeUsuario = '-1' THEN
        SELECT Id INTO vUltimoId
        FROM Historial
        WHERE Numero_Usuario = pNumeroUsuario
        ORDER BY RowCreateAt DESC
        LIMIT 1;

        IF vUltimoId IS NOT NULL THEN
            DELETE FROM Historial WHERE Id = vUltimoId;
        END IF;

    -- Guardar nuevo registro
    ELSE
        INSERT INTO Historial (
            Numero_Usuario,
            Mensaje_Usuario,
            Opcion_Menu,
            Id_Menu,
            SubMenu_Nombre,
            RowCreateAt
        )
        VALUES (pNumeroUsuario, pMensajeUsuario, pOpcionMenu, pIdMenu, pSubMenuNombre, NOW());
    END IF;
END $$

DELIMITER ;
