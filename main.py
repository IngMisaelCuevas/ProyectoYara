import mysql.connector
from mysql.connector import Error

class CJRBot:  #Conexion a la base de datos 
    def _init_(self):
    
        try:
            self.connection = mysql.connector.connect(
                host='localhost',
                database='cjr_bot',
                user='root',
                password='yara1234'
            )
                
        except Error as e:
            print(f"❌ Error al conectar a MySQL: {e}")
            self.connection = None

    def mostrar_bienvenida(self):
        """
        👋 MENSAJE DE BIENVENIDA
        🎯 Presenta el bot al usuario con emojis y formato amigable
        """
        bienvenida = """
        ¡Bienvenido/a a CJR Multiservicios! 🛠💼
        Estamos aquí para ayudarte.
        Por favor, revisa nuestro menú y elige la opción que necesites. 😊
        """
        print(bienvenida)

    def obtener_categorias(self):
        """
        📦 OBTENER CATEGORÍAS PRINCIPALES
        🗃 Consulta las categorías disponibles desde la BD
        📊 Retorna: Lista de categorías con código y nombre
        """
        try:
            cursor = self.connection.cursor()
            cursor.execute("SELECT codigo, nombre FROM categorias ORDER BY id")
            categorias = cursor.fetchall()
            cursor.close()
            return categorias
        except Error as e:
            print(f"❌ Error al obtener categorías: {e}")
            return []

    def obtener_subopciones(self, categoria_codigo):
        """
        📂 OBTENER SUBOPCIONES POR CATEGORÍA
        🔍 Consulta las opciones específicas de cada categoría
        📋 Retorna: Lista de subopciones con código y título
        """
        try:
            cursor = self.connection.cursor()
            query = """
            SELECT s.codigo, s.titulo
            FROM subopciones s 
            JOIN categorias c ON s.categoria_id = c.id 
            WHERE c.codigo = %s 
            ORDER BY CAST(s.codigo AS UNSIGNED)
            """
            cursor.execute(query, (categoria_codigo,))
            subopciones = cursor.fetchall()
            cursor.close()
            return subopciones
        except Error as e:
            print(f"❌ Error al obtener subopciones: {e}")
            return []

    def obtener_contenido(self, categoria_codigo, subopcion_codigo):
        """
        📄 OBTENER CONTENIDO ESPECÍFICO
        🔎 Consulta el contenido detallado de una subopción
        📝 Retorna: Título, descripción, contenido y nombre de categoría
        """
        try:
            cursor = self.connection.cursor()
            query = """
            SELECT s.titulo, s.descripcion, s.contenido, c.nombre
            FROM subopciones s 
            JOIN categorias c ON s.categoria_id = c.id 
            WHERE c.codigo = %s AND s.codigo = %s
            """
            cursor.execute(query, (categoria_codigo, subopcion_codigo))
            resultado = cursor.fetchone()
            cursor.close()
            return resultado
        except Error as e:
            print(f"❌ Error al obtener contenido: {e}")
            return None

    def mostrar_menu_principal(self):
        """
        🎮 MENÚ PRINCIPAL INTERACTIVO
        📱 Muestra las categorías disponibles con formato para WhatsApp
        🎯 Incluye emojis y formato para mejor visualización en móvil
        """
        categorias = self.obtener_categorias()
        
        if not categorias:
            print("❌ No se pudieron cargar las categorías.")
            return False
            
        print("\n" + "="*50)
        print("📋 MENÚ PRINCIPAL")
        print("="*50)
        for codigo, nombre in categorias:
            print(f"{codigo}. {nombre}")
        print("0. Salir ❌")
        print("="*50)
        print("Responde con el número de la opción deseada")
        
        return True

    def mostrar_submenu(self, categoria_codigo, categoria_nombre):
        """
        🎮 SUBMENÚ INTERACTIVO
        📱 Muestra las opciones específicas de una categoría
        🎯 Formato optimizado para visualización en WhatsApp
        """
        subopciones = self.obtener_subopciones(categoria_codigo)
        
        if not subopciones:
            print(f"❌ No hay subopciones disponibles para {categoria_nombre}.")
            return False
            
        print(f"\n{'='*60}")
        print(f"{categoria_nombre} 🎯")
        print(f"{'='*60}")
        for codigo, titulo in subopciones:
            print(f"{codigo}. {titulo}")
        print("0. Volver al menú principal ↩")
        print(f"{'='*60}")
        print("Responde con el número de la opción deseada")
        
        return True

    def formatear_rcp(self, contenido):
        """
        💓 FORMATEO ESPECIAL PARA RCP (Reanimación Cardiopulmonar)
        🚨 Convierte el contenido en pasos claros con emojis y formato
        ⚡ Optimizado para lectura rápida en emergencias
        """
        lineas = contenido.split('\n')
        resultado = ""
        
        for linea in lineas:
            if linea.strip().startswith('1.'):
                resultado += "1.  🧘‍♂ ¿Cuál es la posición inicial?\n•\tPonte de rodillas junto a la persona desmayada.\n\n"
            elif linea.strip().startswith('2.'):
                resultado += "2.  🤲 ¿Cómo colocar las manos?\n•\tColoque el talón de una mano en el centro del pecho.\n•\tColoque la otra mano sobre la primera y entrelace los dedos.\n\n"
            elif linea.strip().startswith('3.'):
                resultado += "3.  ⬇ ¿Cómo realizar la compresión?\n•\tInclínese verticalmente y presione el esternón hacia abajo, comprimiendo 5 cm.\n\n"
            elif linea.strip().startswith('4.'):
                resultado += "4.  🔄 ¿Cómo liberar la presión?\n•\tLibera la presión, manteniendo el contacto con el pecho.\n•\tNo presiones el abdomen o las costillas.\n\n"
            elif linea.strip().startswith('5.'):
                resultado += "5.  🎵 ¿Cuál es el ritmo de compresiones?\n•\tRealiza compresiones a una velocidad de 100-120 por minuto.\n•\tAlternar con otra persona si es posible.\n\n"
            elif linea.strip().startswith('6.'):
                resultado += "6.  ⚡ ¿Cómo usar un desfibrilador?\n•\tUno de los testigos debe buscarlo.\n•\tEnciéndelo y coloca los electrodos en el pecho, siguiendo las instrucciones del dispositivo.\n\n"
            elif "¡Actúa con rapidez" in linea:
                resultado += "⚡¡Actúa con rapidez y mantén la calma!🆘"
            else:
                resultado += linea + "\n"
        
        return resultado

    def mostrar_contenido_normativas(self, contenido):
        """
        📚 VISUALIZACIÓN DE NORMATIVAS
        ⚖ Muestra normas técnicas con formato limpio
        🔗 Incluye enlaces de consulta formateados
        """
        lineas = contenido.split('\n')
        
        for linea in lineas:
            if any(nom in linea for nom in ['NOM-']):
                print(f"📜 {linea}")
            elif linea.startswith('Link de consulta:'):
                print(f"\n🔗 {linea}")
            elif linea.strip():
                print(linea)

    def mostrar_contenido(self, titulo, descripcion, contenido, categoria_nombre):
        """
        📄 VISUALIZACIÓN PRINCIPAL DE CONTENIDO
        🎨 Aplica formato específico según el tipo de contenido:
        - 📞 Contactos: Información directa sin pasos
        - 📚 Normativas: Listado técnico con enlaces
        - 💓 RCP: Pasos de emergencia con emojis
        - 📋 General: Formato estándar con notas en cursiva
        """
        print(f"\n{'='*60}")
        print(f"=== {titulo} ===")
        print(f"{'='*60}")
        
        # Limpiar espacios innecesarios en el contenido
        contenido_limpio = contenido.strip()
        
        # 📞 CONTACTOS DE EMERGENCIA (Formato directo)
        if categoria_nombre == "CONTACTOS DE EMERGENCIA":
            print("📞 Información de contacto:")
            print(contenido_limpio)
        
        # 📚 NORMATIVAS TÉCNICAS (Formato listado)
        elif "NORMATIVAS" in categoria_nombre.upper() or any(palabra in titulo for palabra in ["norma", "Norma", "NOM-"]):
            tipo_norma = titulo.replace("Normas de ", "").replace("Listado de normas de ", "").lower()
            print(f"📚 Listado de normas de {tipo_norma}")
            self.mostrar_contenido_normativas(contenido_limpio)
        
        # 💓 RCP - REANIMACIÓN CARDIOPULMONAR (Formato emergencia)
        elif "RCP" in titulo:
            print(f"{descripcion} 🚨\n")
            contenido_formateado = self.formatear_rcp(contenido_limpio)
            print(contenido_formateado)
        
        # 📋 CONTENIDO GENERAL (Formato estándar con notas en cursiva)
        else:
            print(f"{descripcion}\n")
            
            # Procesar cada línea para formato WhatsApp
            lineas = contenido_limpio.split('\n')
            for linea in lineas:
                linea = linea.strip()
                if not linea:
                    continue
                    
                linea_lower = linea.lower()
                
                # 🎯 Convertir notas importantes en cursiva
                if any(phrase in linea_lower for phrase in [
                    "nota:", "notifique", "llama a servicios", 
                    "actúa con responsabilidad", "cuida el medio ambiente",
                    "¡actúa con", "responsabilidad", "medio ambiente"
                ]):
                    print(f"{linea} 📝")
                else:
                    print(linea)
        
        print(f"{'='*60}")

    def mostrar_opciones_despues_contenido(self, en_submenu=True):
        """
        🔄 MENÚ DE NAVEGACIÓN POST-CONTENIDO
        🎯 Ofrece opciones de continuación al usuario
        📱 Formato optimizado para flujo conversacional en WhatsApp
        """
        print("\n*¿Qué deseas hacer ahora?* 🔄")
        
        if en_submenu:
            print("1. Ver otra opción de este menú 📂")
            print("2. Volver al menú principal 🏠")
        else:
            print("1. Seguir explorando el menú principal 🔍")
            
        print("0. Salir ❌")
        print("Responde con el número de la opción deseada")
        
        while True:
            opcion = input("\n👉 Tu elección: ").strip()
            
            if opcion in ['0', '1', '2']:
                return opcion
            else:
                print("❌ Opción no válida. Por favor, elige 0, 1 o 2.")

    def ejecutar(self):
        """
        🎮 FLUJO PRINCIPAL DEL BOT
        🔄 Maneja la navegación completa del usuario
        📱 Optimizado para experiencia conversacional en WhatsApp
        """
        if not self.connection:
            print("❌ No se pudo conectar a la base de datos. Saliendo...")
            return
            
        # 👋 Mostrar mensaje de bienvenida
        self.mostrar_bienvenida()
        
        # 🔁 Loop principal de navegación
        while True:
            # 📋 Mostrar menú principal
            if not self.mostrar_menu_principal():
                break
                
            # 👉 Leer opción del usuario
            opcion = input("\n👉 Tu elección: ").strip()
            
            # ❌ Salir del sistema
            if opcion == '0':
                print("👋 ¡Gracias por usar CJR Multiservicios! Hasta pronto. 💼")
                break
                
            # ✅ Validar opción seleccionada
            categorias = self.obtener_categorias()
            opciones_validas = [str(cat[0]) for cat in categorias]
            categoria_nombre = next((nombre for cod, nombre in categorias if cod == opcion), "")
            
            if opcion not in opciones_validas:
                print("❌ Opción no válida. Por favor, intenta de nuevo.")
                continue
                
            # 📂 Mostrar submenu de la categoría seleccionada
            if not self.mostrar_submenu(opcion, categoria_nombre):
                continue
                
            # 🔁 Loop de subnavegación
            while True:
                # 👉 Leer subopción del usuario
                subopcion = input("\n👉 Tu elección: ").strip()
                
                # ↩ Volver al menú principal
                if subopcion == '0':
                    break
                    
                # ✅ Validar subopción seleccionada
                subopciones = self.obtener_subopciones(opcion)
                subopciones_validas = [str(sub[0]) for sub in subopciones]
                
                if subopcion not in subopciones_validas:
                    print("❌ Opción no válida. Por favor, intenta de nuevo.")
                    continue
                    
                # 📄 Obtener y mostrar contenido seleccionado
                resultado = self.obtener_contenido(opcion, subopcion)
                
                if resultado:
                    titulo, descripcion, contenido, cat_nombre = resultado
                    self.mostrar_contenido(titulo, descripcion, contenido, cat_nombre)
                    
                    # 🔄 Opciones de continuación
                    opcion_despues = self.mostrar_opciones_despues_contenido(en_submenu=True)
                    
                    if opcion_despues == '0':
                        print("👋 ¡Gracias por usar, El chat bot de CJR Multiservicios! Hasta pronto. 💼")
                        return
                    elif opcion_despues == '1':
                        # 📂 Continuar en el mismo submenú
                        if not self.mostrar_submenu(opcion, categoria_nombre):
                            break
                        continue
                    elif opcion_despues == '2':
                        # 🏠 Volver al menú principal
                        break
                else:
                    print("❌ No se pudo cargar el contenido. Intenta de nuevo.")
                    

# 🚀 EJECUCIÓN PRINCIPAL DEL BOT
if _name_ == "_main_":
    bot = CJRBot()
    bot.ejecutar()