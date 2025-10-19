import mysql.connector
import requests
from config import Config

# Número fijo de WhatsApp
NUMERO_WHATSAPP = "529711383251"

#===================================CONECTAR BD==============================================
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
#===================================CONECTAR BD==============================================


#===================================EJECUTAR SP==============================================
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
#===================================EJECUTAR SP==============================================


#===================================ENVIAR MENSAJE WHATSAPP==================================
def enviar_mensaje_whatsapp(mensaje):
    url = f"https://graph.facebook.com/v20.0/{Config.PHONE_NUMBER_ID}/messages"
    headers = {
        "Authorization": f"Bearer {Config.TOKEN}",
        "Content-Type": "application/json"
    }
    payload = {
        "messaging_product": "whatsapp",
        "to": NUMERO_WHATSAPP,
        "type": "text",
        "text": {"body": mensaje}
    }

    try:
        response = requests.post(url, headers=headers, json=payload)
        return {
            "status_code": response.status_code,
            "response": response.json()
        }
    except Exception as e:
        print(f"No se pudo enviar mensaje a WhatsApp: {e}")
        return {"status_code": 500, "response": str(e)}
#===================================ENVIAR MENSAJE WHATSAPP==================================


#FUNCIONES PARA MOSTRAR LISTAS DE MENUS

#===================================MOSTRARMENU===============================================
def mostrar_menu_principal():
    print("\nMENÚ PRINCIPAL:\n")
    resultados = ejecutar_sp("MostrarMenuPrincipal")

    if not resultados or resultados[0].get("Result") == 0:
        mensaje_error = resultados[0]["Message"] if resultados else "No se pudo obtener el menú principal."
        print(mensaje_error)
        return None

    texto_menu = "\nElije una opción.\nMenú Principal:\n\n"
    for i, menu in enumerate(resultados, start=1):
        print(f"{i}. {menu['Nombre']}")
        texto_menu += f"{i}. {menu['Nombre']}\n"
    print("\n0. Salir")
    texto_menu += "\n0. Salir"

    # Enviar a WhatsApp
    enviar_mensaje_whatsapp(texto_menu)

    return resultados
#===================================MOSTRARMENU===============================================


#==================================MOSTRARSUBMENU=============================================
def mostrar_submenu(id_menu):
    print("\nSUBMENÚ")
    resultados = ejecutar_sp("MostrarSubMenu", id_menu)

    if not resultados or resultados[0].get("Result") == 0:
        mensaje_error = resultados[0]["Message"] if resultados else "No se pudo obtener el submenú."
        print(mensaje_error)
        return None

    texto_submenu = "\nElije una opción.\nSubMenú de opciones:\n\n"
    for i, submenu in enumerate(resultados, start=1):
        print(f"{i}. {submenu['Sub_Menu_Opcion']}")
        texto_submenu += f"{i}. {submenu['Sub_Menu_Opcion']}\n"
    print("\n0. Salir")
    print("-1. Regresar al MENÚ PRINCIPAL")
    texto_submenu += "\n0. Salir\n-1. Regresar al MENÚ PRINCIPAL"

    # Enviar a WhatsApp
    enviar_mensaje_whatsapp(texto_submenu)

    return resultados
#==================================MOSTRARSUBMENU=============================================


#====================================MOSTRARLISTA=============================================
def mostrar_lista_pasos(id_menu, nombre_submenu):
    print(f"\nLISTA DE PASOS: {nombre_submenu}")
    resultados = ejecutar_sp("MostrarListaPasos", id_menu, nombre_submenu)

    if not resultados or resultados[0].get("Result") == 0:
        mensaje_error = resultados[0]["Message"] if resultados else "No se pudo obtener la lista de pasos."
        print(mensaje_error)
        return

    texto_lista = f"\nA continuación se muestra la lista de pasos.\nLista de pasos para {nombre_submenu}\n\n"
    for paso in resultados:
        print(f"{paso['Numero_Paso']}: {paso['Paso']}")
        texto_lista += f"{paso['Numero_Paso']}: {paso['Paso']}\n"
    print("\n0. Salir")
    print("-1. Regresar")
    texto_lista += "\n0. Salir\n-1. Regresar"

    # Enviar a WhatsApp
    enviar_mensaje_whatsapp(texto_lista)
#====================================MOSTRARLISTA=================================================


#====================================MAIN PRINCIPAL============================================
def main():
    print("==============================================")
    print("    Menú General ")
    print("==============================================")

    while True:
        # =====================Menú principal =========================
        menu_principal = mostrar_menu_principal()
        if not menu_principal:
            break

        opcion_input = input("\nSelecciona una opción de menú: ") 
        try:
            seleccion_menu = int(opcion_input)
            if seleccion_menu == 0:
                print("\nSaliendo del sistema...")
                break
            id_menu = menu_principal[seleccion_menu - 1]["Id"]
            print("==============================================")
        except (ValueError, IndexError):
            mensaje_error = f"Opción inválida: {opcion_input} no es válido"
            print(mensaje_error)
            enviar_mensaje_whatsapp(mensaje_error)
            continue
        # =====================Menú principal =========================

        while True:
            # ============================ Sub Menú  ==============================
            submenus = mostrar_submenu(id_menu)
            if not submenus:
                break

            opcion_input = input("\nSelecciona un submenú: ")  
            try:
                seleccion_submenu = int(opcion_input)
                if seleccion_submenu == 0:
                    print("\nSaliendo del sistema...")
                    return
                elif seleccion_submenu < 0:
                    break  
                nombre_submenu = submenus[seleccion_submenu - 1]["Sub_Menu_Opcion"]
                print("==============================================")
            except (ValueError, IndexError):
                mensaje_error = f"Opción inválida: {opcion_input} no es válido"
                print(mensaje_error)
                enviar_mensaje_whatsapp(mensaje_error)
                continue
            # ============================ Sub Menú  ==============================

            while True:
                # ============================ Lista Sub Menú  ===================================
                mostrar_lista_pasos(id_menu, nombre_submenu)
                opcion_input = input("\nSelecciona una opción: ") 
                try:
                    accion = int(opcion_input)
                    if accion == 0:
                        print("\nSaliendo del sistema...")
                        return
                    elif accion < 0:
                        break  
                    print("==============================================")
                except ValueError:
                    mensaje_error = f"Opción inválida: {opcion_input} no es válido"
                    print(mensaje_error)
                    enviar_mensaje_whatsapp(mensaje_error)
                # ============================ Lista Sub Menú  ===================================

#====================================MAIN PRINCIPAL============================================

#ESTO SE EJECUTA PRIMERO SIEMPREEE
if __name__ == "__main__":
    main()
