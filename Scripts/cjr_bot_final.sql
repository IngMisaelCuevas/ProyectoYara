CREATE DATABASE  IF NOT EXISTS `cjr_bot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cjr_bot`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: cjr_bot
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `links` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Link` text,
  `Activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `links`
--

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` VALUES (1,'https://drive.google.com/drive/folders/1zw4Nx6SC-YThBFQslgfwr6ghPPhHfyE3?usp=drive_link',1),(2,'https://drive.google.com/drive/folders/1ToJoWE7aUGvfGoRrFrMVwqEKy2diIe_Z?usp=drive_link',1),(3,'https://drive.google.com/drive/folders/1hTdskgVHPDwuHa81Mj4tx_AWd6TyCtBe?usp=drive_link',1),(4,'https://drive.google.com/drive/folders/1r3ccl3szbutdo0x1shtg3fNePNHaB9em?usp=drive_link',1);
/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensajes_bienvenida`
--

DROP TABLE IF EXISTS `mensajes_bienvenida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensajes_bienvenida` (
  `id` int NOT NULL,
  `mensaje` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajes_bienvenida`
--

LOCK TABLES `mensajes_bienvenida` WRITE;
/*!40000 ALTER TABLE `mensajes_bienvenida` DISABLE KEYS */;
INSERT INTO `mensajes_bienvenida` VALUES (1,'¡Hola! ¡Bienvenido/a al chatbot de CJR Multiservicios!\r A continuación, te presento nuestro menú:');
/*!40000 ALTER TABLE `mensajes_bienvenida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_opciones`
--

DROP TABLE IF EXISTS `menu_opciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_opciones` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_opciones`
--

LOCK TABLES `menu_opciones` WRITE;
/*!40000 ALTER TABLE `menu_opciones` DISABLE KEYS */;
INSERT INTO `menu_opciones` VALUES (1,'PROTOCOLOS DE EMERGENCIA',1),(2,'NORMATIVAS',1),(3,'PRIMEROS AUXILIOS',1),(4,'CONTACTOS DE EMERGENCIA',1),(5,'SALUD',1),(6,'MEDIO AMBIENTE',1);
/*!40000 ALTER TABLE `menu_opciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nota` text,
  `activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (1,' ¡Notifique al contacto de la empresa y llame a servicios de emergencia (911)!.',1),(2,' ¡Actúa sin demora y mantén el control!',1),(3,'En trabajos fuera del Istmo, incluir los teléfonos de centros de salud, hospitales y autoridades locales.',1);
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_menu_lista`
--

DROP TABLE IF EXISTS `sub_menu_lista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_menu_lista` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Sub_Menu_Opciones_Id` int DEFAULT NULL,
  `Paso` text,
  `Numero_Paso` int DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_menu_lista`
--

LOCK TABLES `sub_menu_lista` WRITE;
/*!40000 ALTER TABLE `sub_menu_lista` DISABLE KEYS */;
INSERT INTO `sub_menu_lista` VALUES (1,1,'Limpie la herida con agua y paño.',1,1),(2,1,'Aplique compreso fría (no directamente).',2,1),(3,1,'Quite anillos y pulseras.',3,1),(4,1,'Acuda al hospital inmediatamente.',4,1),(5,2,'Limpie la herida con agua y jabón.',1,1),(6,2,'Aplique paño frío o hielo por 15 min.',2,1),(7,2,'Eleve la zona afectada si es posible.',3,1),(8,2,'Acuda al médico si hay síntomas graves o infección.',4,1),(9,2,'De ser posible llevar la araña en un recipiente seguro para identificarla.',5,1),(10,3,'Llame a emergencias para traslado a un centro con suero antiveneno.',1,1),(11,3,'Mantener la calma del herido.',2,1),(12,3,'Localice las marcas de los colmillos.',3,1),(13,3,'Retire objetos que comprima la extremidad mordida.',4,1),(14,3,'Mantenga inmóvil la extremidad afectada.',5,1),(15,3,'De ser posible identificar el tipo de serpiente.',6,1),(16,3,'Traslade al paciente vigilando los signos vitales.',7,1),(17,4,'Avisar al personal.',1,1),(18,4,'Llame a emergencias para traslado a un centro médico.',2,1),(19,4,'Localice la picadura y conserve el calor corporal.',3,1),(20,4,'Retire objetos que causen daño.',4,1),(21,4,'Mantenga la calma.',5,1),(22,4,'Observe los síntomas.',6,1),(23,4,'Retire el aguijón si es necesario.',7,1),(24,5,'Avisar al personal.',1,1),(25,5,'Llame a emergencias para traslado a un centro médico.',2,1),(26,5,'Localice la picadura y conserve el calor corporal.',3,1),(27,5,'Retire objetos que causen daño.',4,1),(28,5,'Mantenga la calma.',5,1),(29,5,'Observe los síntomas.',6,1),(30,5,'Retire el aguijón si es necesario.',7,1),(31,5,'Limpie la picadura con agua y jabón suave.',8,1),(32,5,'Aplique frío.',9,1),(33,5,'Monitoreé los síntomas (Secreciones oídos, ojos y nariz).',10,1),(34,5,'Coloque a la persona en posición semisentada y mantenerla consciente. ',11,1),(35,6,'Si es pequeño y controlable use el extintor portátil más cercano.',1,1),(36,6,'Si es grande, evacúe inmediatamente (no usar elevadores).',2,1),(37,6,'Cierre las puertas al salir para contener el fuego.',3,1),(38,6,'Diríjase a la zona de menor riesgo.',4,1),(39,6,'Informe al supervisor y personal en sitio.',5,1),(40,7,'No toque a la víctima.',1,1),(41,7,'Corte la electricidad.',2,1),(42,7,'Evalúe si se siente capaz de auxiliar a la víctima.',3,1),(43,7,'En caso de que si: ',4,1),(44,7,'-Asegúrese de estar en superficie seca.',5,1),(45,7,'-Sepárela con un objeto no conductor.',6,1),(46,7,'Llame al 911 para ayuda.',7,1),(47,7,'Verifique si respira, en caso de que no, realice RCP si se siente capaz.',8,1),(48,7,'Coloque a la persona en posición segura.',9,1),(49,8,'Evalúe el tipo de material derramado e identifique la fuente.',1,1),(50,8,'Avisar al supervisor ambiental.',2,1),(51,8,'Use equipo de protección personal específico para control de derrames.',3,1),(52,8,'Balice el área afectada.',4,1),(53,8,'Contenga el derrame con barreras.',5,1),(54,8,'Localice el punto de fuga.',6,1),(55,8,'Elimine la fuente de fuga. ',7,1),(56,8,'Coloque absorbentes y almohadillas.',8,1),(57,8,'Limpie el área del derrame.',9,1),(58,8,'Dispón los residuos generados.',10,1),(59,8,'Registre el incidente.',11,1),(60,9,'Mantente informado sobre el clima y el huracán.',1,1),(61,9,'Revisar la categoría del huracán.',2,1),(62,9,'Si el huracán sigue en camino o se hace más fuerte:',3,1),(63,9,'-Sacar a todo el personal de los aerogeneradores.',4,1),(64,9,'-Ir al campamento o a la subestación.',5,1),(65,9,'Si el huracán es categoría 2 a 5:',6,1),(66,9,'-Salir de inmediato del lugar.',7,1),(67,9,'-No quedarse en la instalación.',8,1),(68,9,'-Esperar en un sitio seguro hasta que el huracán baje de fuerza.',9,1),(69,9,'Regresar a trabajar solo cuando:',10,1),(70,9,'-Ya no haya peligro.',11,1),(71,9,'-El huracán sea más débil.',12,1),(72,9,'-De lo contrario retirarse.',13,1),(73,10,'Antes:',1,1),(74,10,'-Contar con un plan de evacuación.',2,1),(75,10,'-Informar al personal sobre el protocolo.',3,1),(76,10,'-Identificar y señalar las zonas seguras en los aerogeneradores.',4,1),(77,10,'Durante:',5,1),(78,10,'-Seguir siempre las indicaciones de seguridad.',6,1),(79,10,'Si estás en mantenimiento dentro del aerogenerador:',7,1),(80,10,'-Aléjate de partes móviles y superficies huecas.',8,1),(81,10,'-Evacuar por la escalera de la torre.',9,1),(82,10,'-Si no es posible, usar el descensor de emergencia de la Nacelle.',10,1),(83,10,'-Nunca usar el elevador.',11,1),(84,10,'Si estás en el suelo o cerca del aerogenerador:',12,1),(85,10,'-Aléjate lo más posible en dirección perpendicular al rotor.',13,1),(86,10,'-No regresar a los aerogeneradores hasta que se haga una evaluación de daños.',14,1),(87,10,'Después:',15,1),(88,10,'-Confirmar que estás en zona segura y notificar a supervisores.',16,1),(89,10,'-Se hará conteo del personal y se informará al cliente.',17,1),(90,10,'Revisar posibles daños en:',18,1),(91,10,'-Personal.',19,1),(92,10,'-Aerogeneradores.',20,1),(93,10,'-Accesos, subestación, oficinas móviles.',21,1),(94,10,'Si hay heridos-aplicar primeros auxilios.',22,1),(95,10,'Mantente alerta a réplicas y suspende labores hasta que sea seguro.',23,1),(96,10,'Realizar inspección visual segura: cimentación, estructura y uniones.',24,1),(97,10,'Si hay daños importantes-solo el cliente y personal especializado pueden revisarlos.',25,1),(98,10,'Si se disparó alguna celda-reportar al responsable del parque.',26,1),(99,10,'Solo un especialista puede hacer el restablecimiento de la energía.',27,1),(100,11,'Antes de la tormenta.',1,1),(101,11,'Monitorear rayos y truenos constantemente.',2,1),(102,11,'Usar detector de tormentas o aplicación confiable.',3,1),(103,11,'Supervisores deben dar aviso inmediato si hay tormenta en el radio de seguridad.',4,1),(104,11,'Durante la tormenta.',5,1),(105,11,'Si la tormenta está lejos (aún no encima):',6,1),(106,11,'-Salir del aerogenerador lo más rápido y seguro posible.',7,1),(107,11,'-Subir a los vehículos, cerrar ventanillas.',8,1),(108,11,'-Refugiarse en la subestación (si es segura).',9,1),(109,11,'Si la tormenta ya está encima (muy cerca):',10,1),(110,11,'-Mantener la calma.',11,1),(111,11,'-Alejarse de armarios eléctricos.',12,1),(112,11,'-Ir a la plataforma de la torre más próxima.',13,1),(113,11,'-Permanecer con los pies juntos y sin tocar nada.',14,1),(114,11,'-Permanecer en la escalera el mínimo tiempo posible.',15,1),(115,11,'-No quedarse en la base ni cerca del aerogenerador.',16,1),(116,11,'-Si se escuchan chispas, zumbidos o se ven rayos-iniciar evacuación inmediata.',17,1),(117,12,'Detectar la emergencia en el espacio confinado.',1,1),(118,12,'Avisar y pedir ayuda a los servicios de emergencia.',2,1),(119,12,'Determinar el tipo de rescate:',3,1),(120,12,'-Auto rescate: el trabajador sale por sus propios medios.',4,1),(121,12,'-Sin entrar: usar sistema de recuperación (arnés, anclaje, cuerda).',5,1),(122,12,'-Con entrada: solo personal capacitado realiza el rescate.',6,1),(123,12,'Evaluar lo sucedido y los resultados.',7,1),(124,12,'Registrar las acciones. ',8,1),(125,13,'NOM-001-STPS-2008 Edificios e instalaciones.',1,1),(126,13,'NOM-002-STPS-2010 Prevención contra incendios.',2,1),(127,13,'NOM-004-STPS-1999 Dispositivos de seguridad.',3,1),(128,13,'NOM-005-STPS-1998 Manejo y almacenamiento de sustancias peligrosas.',4,1),(129,13,'NOM-006-STPS-2014 Manejo y almacenamiento de materiales.',5,1),(130,13,'NOM-009-STPS-2011Trabajos en alturas.',6,1),(131,13,'NOM-022-STPS-2015 Electricidad estática.',7,1),(132,13,'NOM-027-STPS-2008 corte y soldadura.',8,1),(133,13,'NOM-029-STPS-2011 Instalaciones eléctricas.',9,1),(134,13,'NOM-033-STPS-2015 Espacios confinados. ',10,1),(135,14,'NOM-011-STPS-2001 Estudio de ruido.',1,1),(136,14,'NOM-012-STPS-1999 Radiaciones ionizantes.',2,1),(137,14,'NOM-013-STPS-1993 Radiaciones no ionizantes.',3,1),(138,14,'NOM-015-STPS-2001 Condiciones térmicas abatidas.',4,1),(139,14,'NOM-024-STPS-2001 Vibraciones.',5,1),(140,14,'NOM-025-STPS-2008 Estudio de iluminación.',6,1),(141,14,'NOM-035-STPS-2018 Riesgo psicosocial.',7,1),(142,14,'NOM-036-1-STPS-2018 Riesgo ergonómico.',8,1),(143,15,'NOM-017-STPS-2008 Equipos de protección personal.',1,1),(144,15,'NOM-018-STPS-2015 Condiciones de seguridad de sustancias químicas.',2,1),(145,15,'NOM-019-STPS-2011 Comisión de seguridad e higiene.',3,1),(146,15,'NOM-026-STPS-2008 Colores y señales de seguridad.',4,1),(147,15,'NOM-030-STPS-2009 Servicios preventivos de seguridad y salud.',5,1),(148,16,'NOM-031-STPS-2011 Construcción.',1,1),(149,17,'Atender la vía aérea, la respiración y la circulación.',1,1),(150,17,'Actuar como si hubiera hemorragia interna.',2,1),(151,17,'Inmovilizar el área afectada si hay dolor o deformidad.',3,1),(152,17,'Mantenerse alerta en caso de vómito.',4,1),(153,17,'Aplicar barrera (trapo) y posterior la compresa fría sobre la lesión.',5,1),(154,17,'Traslado inmediato a emergencia.',6,1),(155,18,'Lávese las manos si es posible.',1,1),(156,18,'Aplique presión directa con gasa o tela limpia para detener el sangrado.',2,1),(157,18,'Si hay objeto incrustado, no lo retire; estabilícelo.',3,1),(158,18,'Lave con agua y jabón suave si es un corte leve.',4,1),(159,18,'Coloque un vendaje limpio.',5,1),(160,18,'Si hay fractura o aplastamiento, evite mover la zona.',6,1),(161,18,'Realizar traslado urgente y monitoreo de signos vitales.',7,1),(162,19,'Revisar e identificar la zona fracturada.',1,1),(163,19,'Inmovilizar la fractura antes del traslado.',2,1),(164,19,'Cubrir heridas con apósitos (vendas o gasas) estériles.',3,1),(165,19,'Elevar la extremidad y aplicar frío para reducir inflamación.',4,1),(166,19,'En caso de una sospecha de lesión vertebral coloca el collarín cervical si cuenta con ella.',5,1),(167,19,'Realizar traslado urgente y monitoreo de signos vitales.',6,1),(168,20,'Identificar y enfriar la zona quemada:',1,1),(169,20,'-Flama: humedecer, apagar y retirar la prenda.',2,1),(170,20,'-Semisólido: enfriar con agua.',3,1),(171,20,'Verificar signos de respiración en la vía aérea.',4,1),(172,20,'No quitar restos pegados; sí retirar ropa y joyas.',5,1),(173,20,'Cubrir con gasa estéril.',6,1),(174,20,'En quemaduras en manos o pies, retirar objetos que impidan el flujo sanguíneo.',7,1),(175,20,'Colocar gasas entre los dedos.',8,1),(176,20,'Si hay químico en el ojo, lavar durante 20 minutos.',9,1),(177,20,'Efectuar traslado urgente.',10,1),(178,21,'Identificar la zona afectada.',1,1),(179,21,'Identificar la sustancia química que se tuvo contacto.',2,1),(180,21,'Si es el caso, lavar la zona de contacto con agua abundante durante más de 20 minutos.',3,1),(181,21,'Mantener la calma del afectado.',4,1),(182,21,'Efectuar traslado inmediato.',5,1),(183,22,'Llevar a la persona a un lugar fresco o con sombra de inmediato.',1,1),(184,22,'Enfriar rápido:',2,1),(185,22,'-Quitar la ropa innecesaria.',3,1),(186,22,'-Aplicar hielo o compresas frías en axilas, entre pierna y cuello.',4,1),(187,22,'-Mojar la piel con toallas húmedas o agua y abanicar constantemente.',5,1),(188,22,'Llevar al médico inmediatamente.',6,1),(189,22,'Si hay demora, continuar enfriando con hielo y usar sábana mojada mientras se abanica.',7,1),(190,23,'Abrazar a la persona por la espalda y por debajo de sus brazos.',1,1),(191,23,'Colocar una mano en puño cerrado, cuatro dedos encima del ombligo, en la línea media del estómago.',2,1),(192,23,'Reclinar el cuerpo un poco hacia delante.',3,1),(193,23,'Hacer presión sobre el abdomen en sentido hacia atrás y arriba.',4,1),(194,24,'Sentar a la persona en una silla y ubicarse por detrás.',1,1),(195,24,'Abrazar a la persona por la espalda y por debajo de sus brazos.',2,1),(196,24,'Colocar un puño cerrado justo encima del ombligo y cubrirlo con la otra mano.\nHacer presión hacia atrás.',3,1),(197,24,'Repetir el movimiento hasta 5 veces.',4,1),(198,25,'Revisar la fuente de intoxicación.',1,1),(199,25,'Mantener la calma.',2,1),(200,25,'Si es el caso, evitar que vomite (puede generar lesión mayor).',3,1),(201,25,'No administrar: leche, vinagre, agua, yema de huevo o agua con sal.',4,1),(202,25,'Si es por gas: abrir ventanas y puertas para ventilar el lugar.',5,1),(203,25,'Si es por insecticida en la piel: quitar la ropa y bañarse de inmediato.',6,1),(204,25,'Llamar a emergencia.',7,1),(205,26,'Posición inicial: Arrodillarse junto a la persona.',1,1),(206,26,'Manos: Colocar el talón de una mano en el centro del pecho, la otra encima, dedos entrelazados.',2,1),(207,26,'Compresión: Inclinarse verticalmente y presionar el esternón 5 cm.',3,1),(208,26,'Liberar: Soltar la presión sin quitar las manos.',4,1),(209,26,'Ritmo: 100–120 compresiones por minuto. ',5,1),(210,26,'Alternar con otra persona si es posible.',6,1),(211,26,'En caso de contar con desfibrilador: Encenderlo y seguir instrucciones.',7,1),(212,27,'Emergencia. 911',1,1),(213,27,'Hospital Gral. Dr. Marcedonio Benítez Fuentes. 971-281-0721',2,1),(214,27,'Policía Municipal Juchitán. 971-711-1235',3,1),(215,27,'Bomberos Juchitán. 971-711-2432',4,1),(216,27,'Protección Civil Juchitán. 971-711-1138',5,1),(217,27,'Cruz Roja Tehuantepec. 971-392-0456',6,1),(218,27,'Clínica Sinaí. 971-711-1342',7,1),(219,27,'MEXFAM. 971-712-4061',8,1),(220,27,'Contacto directo CJR. 971-101-0888',9,1),(221,28,'Lavarse y secarse las manos.',1,1),(222,28,'Insertar una tira reactiva en el glucómetro.',2,1),(223,28,'Realizar un piquete en el dedo con una lanceta.',3,1),(224,28,'Colocar una gota de sangre en la lanceta.',4,1),(225,28,'Revisar el monitor del glucómetro.',5,1),(226,28,'Ver los niveles de glucosa sanguínea.',6,1),(227,28,'Si el resultado es alto, monitorear durante una semana.',7,1),(228,28,'Dirigirse al personal del seguro médico.',8,1),(229,29,'Sentarse con la espalda recta.',1,1),(230,29,'Dejar libre la fosa antecubital y colocar el brazalete 2-3 cm sobre el pliegue del codo.',2,1),(231,29,'Ajustar el brazalete sin apretar.',3,1),(232,29,'Presionar el botón de inicio y esperar a que el monitor arroje los resultados.',4,1),(233,29,'Valores aceptables para trabajos en altura:',5,1),(234,29,'-Tensión arterial: <140/90 mm/Hg y >90/60 mm/Hg.',6,1),(235,29,'-Frecuencia cardiaca: <100 latidos por minuto.',7,1),(236,30,'Estar atento a fiebre, tos, dolor de cabeza, entre otros.',1,1),(237,30,'Usar cubrebocas.',2,1),(238,30,'Tomar líquidos y descansar.',3,1),(239,30,'No automedicarse; buscar atención médica para tratamiento antiviral.',4,1),(240,30,'Vacunarse anualmente si no se ha hecho.',5,1),(241,30,'Visitar al médico.',6,1),(242,31,'Lavarse las manos frecuentemente.',1,1),(243,31,'Evitar tocarse los ojos directamente.',2,1),(244,31,'Usar pañuelos desechables.',3,1),(245,31,'Evitar contacto con personas no infectadas.',4,1),(246,31,'Usar gafas oscuras para evitar sensibilidad con la luz.',5,1),(247,31,'Las toallas y elementos de higiene deben ser personales.',6,1),(248,31,'Síntomas:',7,1),(249,31,'-Ardor.',8,1),(250,31,'-Enrojecimiento.',9,1),(251,31,'-Visión borrosa.',10,1),(252,31,'-Ojos llorosos.',11,1),(253,32,'Vigila síntomas como fiebre, dolor muscular y erupciones.',1,1),(254,32,'Usa ropa que cubra brazos y piernas.',2,1),(255,32,'Aplica repelente y usa pabellones o mosquiteros al dormir.',3,1),(256,32,'Elimina el agua acumulada.',4,1),(257,32,'Mantén patios y drenajes limpios.',5,1),(258,32,'Cubre los depósitos de agua.',6,1),(259,32,'Acude al médico ante los primeros síntomas.',7,1),(260,33,'Limpieza diaria:',1,1),(261,33,'Recuperar todas las herramientas.',2,1),(262,33,'Limpiar derrames.',3,1),(263,33,'Desechar los residuos generados.',4,1),(264,33,'Limpieza de herramientas y equipos:',5,1),(265,33,'-Inspeccionar previamente las herramientas y equipos.',6,1),(266,33,'-limpiarlas antes de su uso, si es requerido.',7,1),(267,33,'Limpiar las herramientas y equipo después de su uso:',8,1),(268,33,'-Si es requerido.',9,1),(269,33,'Mantén despejados: ',10,1),(270,33,'-Pasillos.',11,1),(271,33,'-Salidas de emergencia.',12,1),(272,33,'-Accesos a extintores.',13,1),(273,33,'-Botiquines.',14,1),(274,33,'-Kits de atención a derrames.',15,1),(275,33,'-Apilar materiales o equipos de forma ordenada.',16,1),(276,34,'Clasificación de residuos:',1,1),(277,34,'-Residuos Sólidos Urbanos.',2,1),(278,34,'-Residuos de Manejo Especial.',3,1),(279,34,'-Residuos Peligrosos.',4,1),(280,34,'Reciclaje adecuado:',5,1),(281,34,'-Clasificar y depositar los residuos en su respectivo contenedor.',6,1),(282,34,'Educación y conciencia:',7,1),(283,34,'-Compartir información sobre reciclaje con compañeros de trabajo.',8,1),(284,34,'-Involucrarse en iniciativas de limpieza y reciclaje en la comunidad.',9,1),(285,35,'Prohibición absoluta:',1,1),(286,35,'-Prohibido cazar o molestar.',2,1),(287,35,'-Capturar o dañar de cualquier forma a cualquier animal.',3,1),(288,35,'Avistamiento de fauna: ',4,1),(289,35,'-Observar sin interferir. ',5,1),(290,35,'-No acercarse a nidos, madrigueras o crías.',6,1),(291,35,'Procedimiento:',7,1),(292,35,'-En caso de encontrar un animal herido, atrapado en nuestra área de trabajo.',8,1),(293,35,'-Avisar inmediatamente al supervisor HSE.',9,1),(294,35,'-No manipular al animal.',10,1),(295,35,'-Despejar el área en caso de que interfiera en las actividades se deberá de suspender.',11,1);
/*!40000 ALTER TABLE `sub_menu_lista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_menu_opciones`
--

DROP TABLE IF EXISTS `sub_menu_opciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_menu_opciones` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Menu_Opciones_Id` int DEFAULT NULL,
  `Sub_Menu_Opcion` varchar(100) DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_menu_opciones`
--

LOCK TABLES `sub_menu_opciones` WRITE;
/*!40000 ALTER TABLE `sub_menu_opciones` DISABLE KEYS */;
INSERT INTO `sub_menu_opciones` VALUES (1,1,'Picadura de alacrán.',1),(2,1,'Picadura de araña.',1),(3,1,'Picadura de serpiente.',1),(4,1,'Picadura de abeja (Sin alergia).',1),(5,1,'Picadura de abeja (Con alergia).',1),(6,1,'Incendio.',1),(7,1,'Choque eléctrico.',1),(8,1,'Derrame químico.',1),(9,1,'Huracán en aerogenerador.',1),(10,1,'Evacuación en caso de sismo o terremoto en aerogenerador.',1),(11,1,'Tormentas eléctricas en parques eólicos.',1),(12,1,'Rescate en espacios confinados.',1),(13,2,'Normas de seguridad.',1),(14,2,'Normas de salud.',1),(15,2,'Normas de organización.',1),(16,2,'Normas específicas.',1),(17,3,'Heridas cerradas.',1),(18,3,'Heridas abiertas.',1),(19,3,'Fracturas.',1),(20,3,'Quemaduras térmicas.',1),(21,3,'Quemaduras químicas.',1),(22,3,'Golpe de calor.',1),(23,3,'Maniobra de Heimlich (Parado).',1),(24,3,'Maniobra de Heimlich (Sentado).',1),(25,3,'Intoxicación.',1),(26,3,'RCP (Reanimación Cardiopulmonar).',1),(27,4,'Listado de números:',1),(28,5,'Diabetes.',1),(29,5,'Hipertensión.',1),(30,5,'Influenza.',1),(31,5,'Conjuntivitis.',1),(32,5,'Dengue.',1),(33,6,'Limpieza del área.',1),(34,6,'Residuos y reciclaje.',1),(35,6,'Prohibición de caza o maltrato animal.',1);
/*!40000 ALTER TABLE `sub_menu_opciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_menu_opciones_x_links`
--

DROP TABLE IF EXISTS `sub_menu_opciones_x_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_menu_opciones_x_links` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Sub_Menu_Opciones_Id` int DEFAULT NULL,
  `Links_Id` int DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_menu_opciones_x_links`
--

LOCK TABLES `sub_menu_opciones_x_links` WRITE;
/*!40000 ALTER TABLE `sub_menu_opciones_x_links` DISABLE KEYS */;
INSERT INTO `sub_menu_opciones_x_links` VALUES (1,13,1,NULL),(2,14,2,NULL),(3,15,3,NULL),(4,16,4,NULL);
/*!40000 ALTER TABLE `sub_menu_opciones_x_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_menu_opciones_x_notas`
--

DROP TABLE IF EXISTS `sub_menu_opciones_x_notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_menu_opciones_x_notas` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Sub_Menu_Opciones_Id` int DEFAULT NULL,
  `Notas_Id` int DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_menu_opciones_x_notas`
--

LOCK TABLES `sub_menu_opciones_x_notas` WRITE;
/*!40000 ALTER TABLE `sub_menu_opciones_x_notas` DISABLE KEYS */;
INSERT INTO `sub_menu_opciones_x_notas` VALUES (1,1,1,1),(2,2,1,1),(3,3,1,1),(4,4,1,1),(5,5,1,1),(6,6,1,1),(7,7,1,1),(8,8,1,1),(9,9,1,1),(10,10,1,1),(11,11,1,1),(12,12,1,1),(33,27,2,1),(34,28,2,1),(35,29,2,1),(36,30,2,1),(37,31,2,1),(38,32,2,1),(39,33,2,1),(40,34,2,1),(41,35,2,1),(42,36,2,1),(43,37,3,1);
/*!40000 ALTER TABLE `sub_menu_opciones_x_notas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-25 17:04:00
