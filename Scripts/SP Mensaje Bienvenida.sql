DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerMensajeBienvenida$$
CREATE PROCEDURE ObtenerMensajeBienvenida()
BEGIN
    SELECT Mensaje
    FROM mensajes_bienvenida
    LIMIT 1;
END$$

DELIMITER ;
