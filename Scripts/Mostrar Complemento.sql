DELIMITER $$

DROP PROCEDURE IF EXISTS MostrarComplemento$$
CREATE PROCEDURE MostrarComplemento(
    IN pNombreSubMenu VARCHAR(100)
)
BEGIN
    DECLARE vSubMenuId INT;

    menu_block: BEGIN

        IF pNombreSubMenu IS NULL OR pNombreSubMenu = '' THEN
            SELECT 
                0 AS Result, 
                'Debe proporcionar el nombre del submenú.' AS Message;
            LEAVE menu_block;
        END IF;

        SELECT Id 
        INTO vSubMenuId
        FROM Sub_Menu_Opciones
        WHERE Sub_Menu_Opcion = pNombreSubMenu
        LIMIT 1;

        IF vSubMenuId IS NULL THEN
            SELECT 
                0 AS Result, 
                'El submenú especificado no existe.' AS Message;
            LEAVE menu_block;
        END IF;

        SELECT 
			COALESCE(L.Link, '') AS Link,
			COALESCE(N.Nota, '') AS Nota
		FROM Sub_Menu_Opciones SM
		LEFT JOIN Sub_Menu_Opciones_x_links SL 
			ON SL.Sub_Menu_Opciones_Id = SM.Id
		LEFT JOIN Links L 
			ON L.Id = SL.Links_Id
		LEFT JOIN Sub_Menu_Opciones_x_notas SN 
			ON SN.Sub_Menu_Opciones_Id = SM.Id
		LEFT JOIN Notas N 
			ON N.Id = SN.Notas_Id
		WHERE SM.Id = vSubMenuId;


    END menu_block;
END$$

DELIMITER ;
