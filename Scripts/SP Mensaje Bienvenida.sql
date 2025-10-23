DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerMensajeBienvenida$$
CREATE PROCEDURE ObtenerMensajeBienvenida()
BEGIN
    SELECT Mensaje
    FROM MensajeBienvenida
    LIMIT 1;
END$$

DELIMITER ;
