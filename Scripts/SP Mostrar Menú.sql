DELIMITER $$

DROP PROCEDURE IF EXISTS MostrarMenu$$
CREATE PROCEDURE MostrarMenu(
    IN pOpcion VARCHAR(50) ,
    IN pIdMenu INT ,
    IN pNombreSubMenu VARCHAR(100) 
)
BEGIN
	DECLARE vSubMenuId INT;

    menu_block: BEGIN

-- ==================================================================================================
-- MOSTRAR MENU
-- ==================================================================================================

        IF pOpcion = 'MostrarMenuPrincipal' THEN
            IF NOT EXISTS (SELECT 1 FROM Menu_Opciones) THEN
                SELECT 
                    0 AS Result,
                    'No existen opciones de menú registradas.' AS Message;
                LEAVE menu_block;
            END IF;

            SELECT 
                Id,
                Nombre
            FROM Menu_Opciones
            WHERE 
				Activo = 1;
            LEAVE menu_block;
        END IF;

-- ==================================================================================================
-- MOSTRAR SUBMENU
-- ==================================================================================================
        IF pOpcion = 'MostrarSubMenu' THEN
            IF pIdMenu IS NULL OR pIdMenu <= 0 THEN
                SELECT 
					0 AS 
                    Result, 'Debe proporcionar un ID de menú válido.' AS Message;
                LEAVE menu_block;
            END IF;

            IF NOT EXISTS (SELECT 1 FROM Menu_Opciones WHERE Id = pIdMenu) THEN
                SELECT 0 AS Result, 'El menú seleccionado no existe. Intente de nuevo.' AS Message;
                LEAVE menu_block;
            END IF;

            IF NOT EXISTS (SELECT 1 FROM Sub_Menu_Opciones WHERE Menu_opciones_id = pIdMenu) THEN
                SELECT 0 AS Result, 'No hay submenús para esta opción.' AS Message;
                LEAVE menu_block;
            END IF;

            SELECT 
                Id,
                Sub_Menu_Opcion
            FROM Sub_Menu_Opciones
            WHERE Menu_opciones_id = pIdMenu;
            LEAVE menu_block;
        END IF;

-- ==================================================================================================
-- MOSTRAR LISTA
-- ==================================================================================================
        IF pOpcion = 'MostrarListaPasos' THEN
            IF pNombreSubMenu IS NULL OR pNombreSubMenu = '' THEN
                SELECT 
					0 AS Result, 
                    'Debe proporcionar el nombre del submenú.' AS Message;
                LEAVE menu_block;
            END IF;

            SELECT 
				Id 
			INTO vSubMenuId
            FROM Sub_Menu_Opciones
            WHERE 
				Sub_Menu_Opcion = pNombreSubMenu
				AND Menu_Opciones_Id = pIdMenu;

            IF vSubMenuId IS NULL THEN
                SELECT 
					0 AS Result, 
                    'El submenú especificado no existe para este menú.' AS Message;
                LEAVE menu_block;
            END IF;

            IF NOT EXISTS (SELECT 1 FROM sub_menu_lista WHERE Sub_Menu_Opciones_Id = vSubMenuId) THEN
                SELECT 
					0 AS 
                    Result, 'No existen pasos registrados para este submenú.' AS Message;
                LEAVE menu_block;
            END IF;

            SELECT 
                Numero_Paso,
                Paso
            FROM sub_menu_lista
            WHERE Sub_Menu_Opciones_Id = vSubMenuId
            ORDER BY Numero_Paso;
            LEAVE menu_block;
        END IF;


        -- OPCIÓN INVÁLIDA
        SELECT 
            0 AS Result,
            CONCAT('La opción "', pOpcion, '" no es válida. Use: MostrarMenuPrincipal, MostrarSubMenu o MostrarListaPasos.') AS Message;

    END menu_block;
END$$

DELIMITER ;
