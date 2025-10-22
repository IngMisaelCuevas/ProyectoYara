import mysql.connector
from config import Config

def conectar_db():
    try:
        conn = mysql.connector.connect(
            host=Config.DB_HOST,
            user=Config.DB_USER,
            password=Config.DB_PASSWORD,
            database=Config.DB_NAME
        )
        return conn
    except mysql.connector.Error as err:
        print(f"Error al conectar a la base de datos: {err}")
        exit()


def ejecutar_sp(opcion, id_menu=0, nombre_submenu=""):
    conn = conectar_db()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.callproc("MostrarMenu", [opcion, id_menu, nombre_submenu])
        resultados = []
        for result in cursor.stored_results():
            resultados.extend(result.fetchall())
        return resultados
    except mysql.connector.Error as err:
        print(f"Error al ejecutar el procedimiento: {err}")
        return []
    finally:
        cursor.close()
        conn.close()


# =================================== MOSTRAR MENÚ PRINCIPAL ===================================
def mostrar_menu_principal():
    resultados = ejecutar_sp("MostrarMenuPrincipal")

    if not resultados or resultados[0].get("Result") == 0:
        return resultados[0]["Message"] if resultados else "No se pudo obtener el menú principal."

    texto_menu = "\nElije una opción.\nMenú Principal:\n\n"
    for i, menu in enumerate(resultados, start=1):
        texto_menu += f"{i}. {menu['Nombre']}\n"
    texto_menu += "\n0. Salir"

    return texto_menu
# ==============================================================================================


# =================================== MOSTRAR SUBMENÚ ==========================================
def mostrar_submenu(id_menu):
    resultados = ejecutar_sp("MostrarSubMenu", id_menu)

    if not resultados or resultados[0].get("Result") == 0:
        return resultados[0]["Message"] if resultados else "No se pudo obtener el submenú."

    texto_submenu = "\nElije una opción.\nSubMenú de opciones:\n\n"
    for i, submenu in enumerate(resultados, start=1):
        texto_submenu += f"{i}. {submenu['Sub_Menu_Opcion']}\n"
    texto_submenu += "\n0. Salir\n-1. Regresar al MENÚ PRINCIPAL"

    return texto_submenu
# ==============================================================================================


# =================================== MOSTRAR LISTA DE PASOS ==================================
def mostrar_lista_pasos(id_menu, nombre_submenu):
    resultados = ejecutar_sp("MostrarListaPasos", id_menu, nombre_submenu)

    if not resultados or resultados[0].get("Result") == 0:
        return resultados[0]["Message"] if resultados else "No se pudo obtener la lista de pasos."

    texto_lista = f"\nA continuación se muestra la lista de pasos.\nLista de pasos para {nombre_submenu}\n\n"
    for paso in resultados:
        texto_lista += f"{paso['Numero_Paso']}: {paso['Paso']}\n"
    texto_lista += "\n0. Salir\n-1. Regresar"

    return texto_lista
# ==============================================================================================



def insertar_conversacion(numero_usuario, mensaje_usuario):

    texto_respuesta, opcion_actual = obtener_respuesta_usuario(numero_usuario)

    conn = conectar_db()
    cursor = conn.cursor()
    try:
        cursor.callproc("InsertarConversacion", [numero_usuario, mensaje_usuario, opcion_actual])
        conn.commit()
        print(f"Conversación insertada para {numero_usuario}")
    except mysql.connector.Error as err:
        print(f"Error al insertar conversación: {err}")
    finally:
        cursor.close()
        conn.close()

    return texto_respuesta



def obtener_respuesta_usuario(numero):
    conn = conectar_db()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.callproc("ObtenerUltimoMensaje", [numero])
        ultimo = []
        for result in cursor.stored_results():
            ultimo.extend(result.fetchall())

        if not ultimo:
            return mostrar_menu_principal(), "MostrarMenuPrincipal"
        
        ultimo = ultimo[0]
        opcion_anterior = ultimo["Opcion_Menu"]
        mensaje_usuario = ultimo["Mensaje_Usuario"]

        if opcion_anterior == "MostrarMenuPrincipal":
           
            try:
                id_menu = int(mensaje_usuario)
                return mostrar_submenu(id_menu), "MostrarSubMenu"
            except ValueError:
                return mostrar_menu_principal(), "MostrarMenuPrincipal"

        elif opcion_anterior == "MostrarSubMenu":
            try:
                id_menu = int(mensaje_usuario) 
                nombre_submenu = "NombreDeSubMenu" 
                return mostrar_lista_pasos(id_menu, nombre_submenu), "MostrarListaPasos"
            except ValueError:
                return mostrar_menu_principal(), "MostrarMenuPrincipal"

        elif opcion_anterior == "MostrarListaPasos":
            return "Gracias por usar el sistema. Para continuar, selecciona una opción.", None

        else:
            return mostrar_menu_principal(), "MostrarMenuPrincipal"

    finally:
        cursor.close()
        conn.close()
def obtener_respuesta_usuario(numero):
    conn = conectar_db()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.callproc("ObtenerUltimoMensaje", [numero])
        ultimo = []
        for result in cursor.stored_results():
            ultimo.extend(result.fetchall())

        if not ultimo:
            # No hay mensaje reciente → iniciar menú principal
            return mostrar_menu_principal(), "MostrarMenuPrincipal"
        
        ultimo = ultimo[0]
        opcion_anterior = ultimo["Opcion_Menu"]
        mensaje_usuario = ultimo["Mensaje_Usuario"]

        if opcion_anterior == "MostrarMenuPrincipal":
            try:
                id_menu = int(mensaje_usuario)
                return mostrar_submenu(id_menu), "MostrarSubMenu"
            except ValueError:
                return mostrar_menu_principal(), "MostrarMenuPrincipal"

        elif opcion_anterior == "MostrarSubMenu":
            try:
                id_menu = int(mensaje_usuario)  # Número del submenú elegido

                # Obtener submenus del id_menu
                submenus = ejecutar_sp("MostrarSubMenu", id_menu)
                if not submenus or mensaje_usuario == "0":
                    return mostrar_menu_principal(), "MostrarMenuPrincipal"

                seleccion = int(mensaje_usuario) - 1
                if seleccion < 0 or seleccion >= len(submenus):
                    return mostrar_menu_principal(), "MostrarMenuPrincipal"

                nombre_submenu = submenus[seleccion]["Sub_Menu_Opcion"]

                return mostrar_lista_pasos(id_menu, nombre_submenu), "MostrarListaPasos"
            except (ValueError, IndexError):
                return mostrar_menu_principal(), "MostrarMenuPrincipal"

        elif opcion_anterior == "MostrarListaPasos":
            return "Gracias por usar el sistema. Para continuar, selecciona una opción.", None

        else:
            return mostrar_menu_principal(), "MostrarMenuPrincipal"

    finally:
        cursor.close()
        conn.close()
