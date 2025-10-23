DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerUltimoMensaje $$
CREATE PROCEDURE ObtenerUltimoMensaje(
    IN pNumeroUsuario VARCHAR(20)
)
BEGIN
    SELECT Numero_Usuario,
           Mensaje_Usuario,
           Opcion_Menu,
           RowCreateAt
    FROM Historial
    WHERE Numero_Usuario = pNumeroUsuario
      AND RowCreateAt >= NOW() - INTERVAL 5 MINUTE
    ORDER BY RowCreateAt DESC
    LIMIT 1;
END $$

DELIMITER ;
