import mysql.connector
from config import Config
from Services.Whatsapp_Services import EnviarMensajeWhatsApp

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

    texto_menu = "\nElije una opción.\n\nMenú Principal:\n\n"
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

    texto_submenu = "\nElije una opción.\n\n"
    for i, submenu in enumerate(resultados, start=1):
        texto_submenu += f"{i}. {submenu['Sub_Menu_Opcion']}\n"
    texto_submenu += "\n0. Salir\n"

    return texto_submenu
# ==============================================================================================


# =================================== MOSTRAR LISTA DE PASOS ==================================
def mostrar_lista_pasos(id_menu, nombre_submenu):
    # Obtener lista de pasos
    resultados = ejecutar_sp("MostrarListaPasos", id_menu, nombre_submenu)

    if not resultados or resultados[0].get("Result") == 0:
        return resultados[0]["Message"] if resultados else "No se pudo obtener la lista de pasos."

    texto_lista = f"Lista de pasos para {nombre_submenu}\n\n"
    for paso in resultados:
        texto_lista += f"{paso['Numero_Paso']}: {paso['Paso']}\n"
    texto_lista += "\n0. Salir\n"

    # ==================== Obtener Nota / Link del submenú ====================
    conn = conectar_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.callproc("MostrarComplemento", [nombre_submenu])
        complementos = []
        for result in cursor.stored_results():
            complementos.extend(result.fetchall())

        link_mostrar = ""
        nota_mostrar = ""
        for comp in complementos:
            if comp.get("Link"):
                link_mostrar = f"\n🔗 Link: {comp['Link']}"
            if comp.get("Nota"):
                nota_mostrar = f"\n📝 Nota: {comp['Nota']}"

        texto_lista += link_mostrar + nota_mostrar
    except mysql.connector.Error as err:
        print(f"Error al obtener complemento: {err}")
    finally:
        cursor.close()
        conn.close()
    # ========================================================================

    return texto_lista

# ==============================================================================================

def enviar_bienvenida(numero_destino):
    conn = conectar_db()
    cursor = conn.cursor(dictionary=True)
    mensaje_bienvenida = ""
    try:
        cursor.callproc("ObtenerMensajeBienvenida")
        for result in cursor.stored_results():
            fila = result.fetchone()
            if fila:
                mensaje_bienvenida = fila["Mensaje"]
    except mysql.connector.Error as err:
        print(f"Error al obtener mensaje de bienvenida: {err}")
    finally:
        cursor.close()
        conn.close()

    if mensaje_bienvenida:
        EnviarMensajeWhatsApp(numero_destino, mensaje_bienvenida)



def insertar_conversacion(numero_usuario, mensaje_usuario):

    

    texto_respuesta, opcion_actual = obtener_respuesta_usuario(numero_usuario, mensaje_usuario)

    conn = conectar_db()
    cursor = conn.cursor()
    try:
        cursor.callproc("InsertarConversacion", [numero_usuario, mensaje_usuario, opcion_actual])
        conn.commit()

    except mysql.connector.Error as err:
        print(f"Error al insertar conversación: {err}")
    finally:
        cursor.close()
        conn.close()

    return texto_respuesta


def obtener_respuesta_usuario(numero, mensaje_actual):
    conn = conectar_db()
    cursor = conn.cursor(dictionary=True)

    try:

        cursor.callproc("ObtenerUltimoMensaje", [numero])
        ultimo = []
        for result in cursor.stored_results():
            ultimo.extend(result.fetchall())

  
        if not ultimo:
            enviar_bienvenida(numero)
            return mostrar_menu_principal(), "MostrarMenuPrincipal"

        ultimo = ultimo[0]
        opcion_anterior = ultimo["Opcion_Menu"]
        mensaje_anterior = ultimo["Mensaje_Usuario"]

        if mensaje_actual.strip() == "0":
            return "Gracias por usar el ChatBot. ¡Hasta luego! 🤗", None
        


        if opcion_anterior == "MostrarMenuPrincipal":
            try:
                id_menu = int(mensaje_actual)
                return mostrar_submenu(id_menu), "MostrarSubMenu"
            except ValueError:
                enviar_bienvenida(numero)
                return mostrar_menu_principal(), "MostrarMenuPrincipal"
            


        elif opcion_anterior == "MostrarSubMenu":
            try:
 
                id_menu = int(mensaje_anterior)

                submenus = ejecutar_sp("MostrarSubMenu", id_menu)
                if not submenus:
                    enviar_bienvenida(numero)
                    return mostrar_menu_principal(), "MostrarMenuPrincipal"

                seleccion = int(mensaje_actual) - 1
                if seleccion < 0 or seleccion >= len(submenus):
                    enviar_bienvenida(numero)
                    return mostrar_menu_principal(), "MostrarMenuPrincipal"

                nombre_submenu = submenus[seleccion]["Sub_Menu_Opcion"]

                return mostrar_lista_pasos(id_menu, nombre_submenu), "MostrarListaPasos"
            except (ValueError, IndexError):
                enviar_bienvenida(numero)
                return mostrar_menu_principal(), "MostrarMenuPrincipal"



        elif opcion_anterior == "MostrarListaPasos":
            return "Gracias por usar el sistema.", None



        else:
            enviar_bienvenida(numero)
            return mostrar_menu_principal(), "MostrarMenuPrincipal"

    finally:
        cursor.close()
        conn.close()
