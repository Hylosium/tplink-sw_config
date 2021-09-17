                   
:: -----------------TAREAS--->>>>>>-----------------
:: 1. Limpiar código.
:: 2. Traducir al inglés y publicar en GitHub.
:: -------------------------------------------------
@echo off
rem Para que no muestre todo con mucho desorden?
::----------
setlocal EnableExtensions-
:: Ni idea, solo sé que hace magia
::----------
chcp 65001
rem Es para elegir una tipografía en español.
SET mypath=%~dp0
ECHO %mypath:~0,-1%
rem Con esto ponemos la ruta de ejecución desde donde se ejecuta el '.bat'
title MENÚ DE CONFIGURACIÓN DEL SWITCH 'TLXXXX-XXTS v2.0' POR SERIAL v0.090
rem Título que sale arriba en la ventana de CMD.
rem ===============================
rem -------------------------------
rem subMenú 1
copy /Y .\submenu1\contc_info\contact-org.txt .\submenu1\contc_info\contact.txt
copy /Y .\submenu1\hostname\hostname-org.txt .\submenu1\hostname\hostname.txt
copy /Y .\submenu1\location\location-org.txt .\submenu1\location\location.txt
copy /Y .\submenu1\ntp\ip-srv-ntp-org.txt .\submenu1\ntp\ip-srv-ntp.txt
copy /Y .\submenu1\iproute\ip-route-org.txt .\submenu1\iproute\ip-route.txt
rem subMenú 2
copy /Y .\submenu2\dir_IP\dirIP-org.txt .\submenu2\dir_IP\dirIP.txt
copy /Y .\submenu2\edit_vlan\edit_n_vlan-org.txt .\submenu2\edit_vlan\edit_n_vlan.txt
copy /Y .\submenu2\edit_vlan\sup_edit_n_vlan-org.txt .\submenu2\edit_vlan\sup_edit_n_vlan.txt
copy /Y .\submenu2\port\add_port_to_vlan-org.txt .\submenu2\port\add_port_to_vlan.txt
copy /Y .\submenu2\port\change_pvid_port-org.txt .\submenu2\port\change_pvid_port.txt
copy /Y .\submenu2\port\sup_port_to_vlan-org.txt .\submenu2\port\sup_port_to_vlan.txt
copy /Y .\submenu2\vlanes\info-id\info-id-vlan-org.txt .\submenu2\vlanes\info-id\info-id-vlan.txt
rem -------------------------------
rem ===============================
rem Lo de arriba se utiliza para limpiar las configuraciones, así cada vez que ejecutes el menú estarán por defecto, entonces si no te funciona algo como querías con volver a abrir el menú ya estaría por defecto.
rem -------------------------------
rem Ya funciona la v1.0 y la v2.0 de los SW TP-LINK :)
rem La v4 (que es mas vieja que la v2) no sé si funcionará
cls

chgport | findstr "COM"
echo.
set /P pCOM=Indícame el puerto COM por el que se conecta el SW:
echo Tu puerto elegido ha sido el COM%pCOM%
set bRate=38400
set /P bRate=Indícame el Baud Rate para el SW (si lo dejas vacio tendrá '%bRate%'):
echo Has elegido %bRate% de Baud Rate.
set dBits=8
set /P dBits=Indícame los data Bits (si lo dejas vacio tendrá '8'):
echo Has elegido %dBits% de Data Bits.
set pArity=n
set /P pArity=Indícame la 'Parity'(si lo dejas vacio será 'n'):
echo Has elegido %pArity% de Parity.
set sBits=1
set /P sBits=Indícame los 'Stop Bits'(si lo dejas vacio será de '1'):
echo Has elegido %sBits% de Stop Bits.
cls
netsh interface ipv4 show interfaces
set /P interfaceYou=Indícame el número de la izquierda del adptador de red que quieres usar:
:: Para que puedes elegir varios parametros para conectarse a cualquier SW TP-LINK(v1,v2 y v4) desde cualquier PC con cualquier dadaptador de Red.



:MENU0

netsh interface ipv4 show config name=%interfaceYou%|find "IP" > submenu8\IPv4.txt
netsh interface ipv4 show config name=%interfaceYou%|find "subred" > submenu8\netMASK.txt
netsh interface ipv4 show config name=%interfaceYou%|find "Puerta" > submenu8\GW.txt
netsh interface ipv4 show config name=%interfaceYou%|find "DNS" > submenu8\DNS.txt
for /f "tokens=3" %%4 in (.\submenu8\IPv4.txt) do set IPv4=%%4
for /f "tokens=6" %%m in (.\submenu8\netMASK.txt) do set netMask=%%m
set netMask=%netMask:~0,-1%
for /f "tokens=5" %%w in (.\submenu8\GW.txt) do set GW=%%w
for /f "tokens=8" %%z in (.\submenu8\DNS.txt) do set dns=%%z

	cls
	rem Limpio todo lo que había hasta esta línea.
	ECHO.    
    ECHO.     Menú de Opciones
    ECHO.     
    ECHO.     1.- Modificar y/o Revisar información del SW.
    ECHO.     2.- Configuración de VLANES.
	ECHO.    [93m 3.- Entrar en el CLI del SW. [0m
    ECHO.     4.- Activar o Desactivar diferentes tecnologías [RSTP/FTP.SSH.LOOPBACK.].
    ECHO.     5.- Modificar puertos [LOOPBACK.JUMBO..].
    ECHO.     6.- Configuración [1;101;93m Secuencial Completa[0m.
    ECHO.     7.- Configurar puerto de CONEXIÓN.
    ECHO.     8.- Configuraciones IP
    ECHO.     9.- Ayuda.
    ECHO.     10/Q.- Salir.
	ECHO.
	ECHO.
	::IF "%IPv4%"   ==  "%IPv4%"  ECHO. [102m √ [0m The page works greatly, no needs to reload.
	::IF "%IPv4%x"   ==  "x"  ECHO. [7;31m X [0m The page hasen't charge correctñy, please, reload.
    ECHO.	   	  
    ECHO.	   	  
	echo.     ___________________________________
	echo.     ^|                                  
	Echo.     ^|[1mCOM%pCOM%[0m [Puerto Serial]
	Echo.     ^|[1m%bRate%[0m [Baud Rate]
	Echo.     ^|[1m%dBits%[0m [Data Bits]
	Echo.     ^|[1m%pArity%[0m [Parity]
	Echo.     ^|[1m%sBits%[0m [Stop Bits]
	Echo.     ^|        _______________            
	echo.     ^|                                  
	echo.     ^|[1m%IPv4%[0m  [IPv4]
	echo.     ^|[1m%netMask%[0m [MASK]
	echo.     ^|[1m%GW%[0m   [GW]
	echo.     ^|[1m%dns%[0m       [DNS]
	Echo.     ^|__________________________________
	ECHO.
	set MenuOpc0=""
    set /P MenuOpc0=Su Opción es:
	rem Se espera un valor, del 1 al 10 o Q para guardar en una variable y que compare con los IF's de abajo y te lleve a otra parte para continuar.
	
	IF "%MenuOpc0%x"   ==  "x"  goto MENU0
	IF "%MenuOpc0%x"   ==  "x"  goto MENU0
    IF "%MenuOpc0%"    ==  "Q"  goto MenuOpc0_10
	IF "%MenuOpc0%"    ==  "q"  goto MenuOpc0_10
	IF "%MenuOpc0%"    ==  "10" goto MenuOpc0_10
    IF "%MenuOpc0%"    ==  "9"  goto MenuOpc0_9
    IF "%MenuOpc0%"    ==  "8"  goto MenuOpc0_8
    IF "%MenuOpc0%"    ==  "7"  goto MenuOpc0_7
    IF "%MenuOpc0%"    ==  "6"  goto MenuOpc0_6
    IF "%MenuOpc0%"    ==  "5"  goto MenuOpc0_5
    IF "%MenuOpc0%"    ==  "4"  goto MenuOpc0_4
    IF "%MenuOpc0%"    ==  "3"  goto MenuOpc0_3
    IF "%MenuOpc0%"    ==  "2"  goto MenuOpc0_2
    IF "%MenuOpc0%"    ==  "1"  goto MenuOpc0_1
	
cls	
ECHO ============ENTRADA INCORRECTA============
ECHO -------------------------------------
ECHO Por favor, elige un número del menú
ECHO Menu [1-9] o elige '10 o Q' para salir.
ECHO -------------------------------------	
ECHO ======ESPERE A SER REEDIRIGIDO...======
timeout 4

	goto MENU0
	rem Si no se ha ingresado un número entre el 1 y el 10 o Q to devolverá al principio del menú, es decir lo 'reinicia'
	
	
goto MENU0	
:MenuOpc0_1
rem subMENÚ [1] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		:subMenu1
			
		cls
		ECHO. Modificar y/o Revisar información del SW - SUBMENÚ 1	
		ECHO.     
		ECHO.     
		ECHO.     1.- Nombre del SW
		ECHO.     2.- Localización del SW.
		ECHO.     3.- Información de contacto del SW.
		ECHO.    [1m 4.- Devolver valores de fábrica al SW. [0m
		ECHO.     5.- USO de CPU y de MEMORIA.
		ECHO.    [93m 6.- Guardar la configuración actual. [0m
		ECHO.     7.- IP Servidor NTP.
		ECHO.     8.- Configurar Static Routing
		ECHO.     9/Q.- Volver.
		set SubMenuOpc1=""
		set /P SubMenuOpc1=Su Opción es:
		
		IF "%SubMenuOpc1%x"   ==  "x"  goto MenuOpc0_1
		IF "%SubMenuOpc1%"    ==  "9"  goto SubMenuOpc1_9
		IF "%SubMenuOpc1%"    ==  "Q"  goto SubMenuOpc1_9
		IF "%SubMenuOpc1%"    ==  "q"  goto SubMenuOpc1_9
		IF "%SubMenuOpc1%"    ==  "8"  goto SubMenuOpc1_8
		IF "%SubMenuOpc1%"    ==  "7"  goto SubMenuOpc1_7
		IF "%SubMenuOpc1%"    ==  "6"  goto SubMenuOpc1_6
		IF "%SubMenuOpc1%"    ==  "5"  goto SubMenuOpc1_5
		IF "%SubMenuOpc1%"    ==  "4"  goto SubMenuOpc1_4
		IF "%SubMenuOpc1%"    ==  "3"  goto SubMenuOpc1_3
		IF "%SubMenuOpc1%"    ==  "2"  goto SubMenuOpc1_2
		IF "%SubMenuOpc1%"    ==  "1"  goto SubMenuOpc1_1
		
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO -------------------------------------
		ECHO Por favor, elige un número del menú
		ECHO Menu [1-9] o elige '10 o Q' para salir.
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======	
		timeout 4
		goto subMenu1

		:SubMenuOpc1_1
		cls
		ECHO Opción - 1
		rem Para elegir si quieres modificar el nombre 'hostname' del SW.
		set verificar1_1=""
		set /P verificar1_1=Elige '1' para cambiar el nombre,'2' para cancelar o 'Q' para salir:
		rem Te pregunta que quieres hacer y según lo que escribas lo guardará en una variable que su valor comprobará con unos cuantos 'IF' y te llevará a otra parte donde ejecutara X o Y cosa .
		
		IF "%verificar1_1%x"=="x" (goto SubMenuOpc1_1)
		IF "%verificar1_1%"=="Q" (goto subMenu1)
		IF "%verificar1_1%"=="q" (goto subMenu1)
		IF "%verificar1_1%"=="1" (goto subMenu1_1_SI)
		IF "%verificar1_1%"=="1" (goto subMenu1_1_SI)
		IF "%verificar1_1%"=="2" (goto subMenu1_1_NO)
		IF "%verificar1_1%"=="2" (goto subMenu1_1_NO)
		
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO Por favor, escribe '1' o '2' o 'Q'
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======		
		timeout 3
		goto subMenu1
		
			:subMenu1_1_SI
			cls
				set /P cambiar_nombre1_1=Escribe aquí el nombre que quieras "sin tildes ni caracteres raros":
				rem Te pregunta que nombre quieres ponerle, tú se lo escribes y lo guarda en la variable 'cambiar_nombre1_1'
				powershell -Command "(gc .\submenu1\hostname\hostname.txt) -replace '"hostname .*"', '"hostname %cambiar_nombre1_1%"' | Out-File -encoding ASCII .\submenu1\hostname\hostname.txt"
				rem Función de powershell que se utiliza en CMD, se remplaza lo que hay en el archivo de texto '.txt' que enviaremos al SW por Serial.
				echo El nuevo nombre para tu SW será %cambiar_nombre1_1%
				rem Te muestra que nombre has elegido.
				plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\hostname\hostname.txt"
				
				timeout 3
				rem Se utiliza el 'pause' para que no se vaya todo de golpe y puedes leerlo.
				goto subMenu1
			:subMenu1_1_NO
			cls
				rem No está hecho...
				echo Entendido ;)
				timeout 3
				goto subMenu1
			

		

		
		:SubMenuOpc1_2
		cls
		rem Cambiar la localización del SW.
		ECHO Opción - 2
		set /P elegir_sitio1_2=Escríbeme dónde va a estar este SW:
		powershell -Command "(gc .\submenu1\location\location.txt) -replace '"location .*"', '"location %elegir_sitio1_2%"' | Out-File -encoding ASCII .\submenu1\location\location.txt"
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\location\location.txt"
		timeout 3
		goto subMenu1
		
		:SubMenuOpc1_3
		cls
		rem Cambiar la información de contacto del SW.
		ECHO Opción - 3
		set /P elegir_contc1_3=Escríbeme qué que quieres de información de contacto:
		powershell -Command "(gc .\submenu1\contc_info\contact.txt) -replace '"contact-info .*"', '"contact-info %elegir_contc1_3%"' | Out-File -encoding ASCII .\submenu1\contc_info\contact.txt"
		echo Tus nueos datos de contacto serán %elegir_contc1_3%
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\contc_info\contact.txt"
		timeout 3
		goto subMenu1
		
		:SubMenuOpc1_4
		cls
		rem Para devolver los valores de fábrica al SW.
		ECHO Opción - 4
		set verificar1_4=""
		set /P verificar1_4= Vas a devolver al SW los parametros de fábrica que tenía, escribe "1" para confirmar o "2" para cancelar:
		IF "%verificar1_4%"=="2" (goto No1_4)
		IF "%verificar1_4%"=="2" (goto No1_4)
		IF "%verificar1_4%"=="1" (goto Si1_4)
		IF "%verificar1_4%"=="1" (goto Si1_4)
		IF "%verificar1_4%x"=="x" (goto SubMenuOpc1_4)
		
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO Por favor, escribe '1' o '2
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======	
		timeout 3
		goto subMenu1
			:No1_4
			cls
			ECHO Entendido :)
			timeout 3
			goto subMenu1
			:Si1_4
			cls
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\reset\script_reset(factory).txt"
			timeout 3
			goto subMenu1
		
		:SubMenuOpc1_5
		cls
		rem Mostrar uso '%' de CPU y MEM utilizados.
		ECHO Opción - 5
		
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\show_utilization\script_resources_cpu&mem.txt"
		ECHO 
		ECHO......(\_/)
		ECHO......( '_')
		ECHO..../""""""""""""\======¦ ¦¦¦¦D
		ECHO/"""""""""""""""""""\
		ECHO\_@_@_@_@_@_@_@_@_@_/
		
		timeout 3
		goto subMenu1
		
		:SubMenuOpc1_6
		cls
		rem Guardar la congifuración (Save)
		ECHO Opción - 6
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\save\save.txt"
		timeout 3
		goto subMenu1
		:SubMenuOpc1_7
		cls
		rem Cambiar servidor IP NTP
		ECHO Opción - 7

		set /P elegir_ip-ntp_2_7=Escríbeme la IP del servidor NTP:
		powershell -Command "(gc .\submenu1\ntp\ip-srv-ntp.txt) -replace '":00 .*"', '":00 %elegir_ip-ntp_2_7% %elegir_ip-ntp_2_7% 12"' | Out-File -encoding ASCII .\submenu1\ntp\ip-srv-ntp.txt"
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\ntp\ip-srv-ntp.txt"

		timeout 3
		goto subMenu1
		
		
		:SubMenuOpc1_8
		cls
		rem Cambiar Static Routing
		ECHO Opción - 8 
		
		set /P destino1_8=Escríbe la dirección IP de destino:
		set /P subnet1_8=Escríbe la máscara de red:
		set /P gateway1_8=Escríbe la dirección para el siguiente salto:
		set /P distance1_8=Escríbe la distancia en unidad métrica (desde 1 a 256):
		
		powershell -Command "(gc .\submenu1\iproute\ip-route.txt) -replace '"route .*"', '"route %destino1_8% %subnet1_8% %gateway1_8% %distance1_8%"' | Out-File -encoding ASCII .\submenu1\iproute\ip-route.txt"
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\iproute\ip-route.txt"


		timeout 3
		goto subMenu1
		
		:SubMenuOpc1_9
		cls
		rem Para volver al menú principal.
		ECHO ==============GRACIAS!===============
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======
		timeout 0
		goto MENU0


:MenuOpc0_2
rem subMENÚ [2] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		:subMenu2
			
		cls
		ECHO. Configuración de VLANES - SUBMENÚ 2	
		ECHO.     
		ECHO.     
		ECHO.     1.- Crear/Editar VLAN.
		ECHO.     2.- Agregar/Eliminar puertos a VLANes. 
		ECHO.     3.- Dirección IP de una VLAN del SW.
		ECHO.     4.- Cargar plantilla genérica de VLANES para el SW.
		ECHO.     5.- Eliminar una VLAN.
		ECHO.     6.- Configurar PVID de un puerto.
		ECHO.     7.- Mostrar información de una VLAN. 
		ECHO.     8.- Resumen de VLANes.
		ECHO.     9/Q.- Escribe "Q" para volver.
		set SubMenuOpc2=""
		set /P SubMenuOpc2=Su Opción es:
		
		IF "%SubMenuOpc2%"    ==   ""  goto subMenu2
		IF "%SubMenuOpc2%"    ==  "9"  goto SubMenuOpc2_9
		IF "%SubMenuOpc2%"    ==  "Q"  goto SubMenuOpc2_9
		IF "%SubMenuOpc2%"    ==  "q"  goto SubMenuOpc2_9
		IF "%SubMenuOpc2%"    ==  "8"  goto SubMenuOpc2_8
		IF "%SubMenuOpc2%"    ==  "7"  goto SubMenuOpc2_7
		IF "%SubMenuOpc2%"    ==  "6"  goto SubMenuOpc2_6
		IF "%SubMenuOpc2%"    ==  "5"  goto SubMenuOpc2_5
		IF "%SubMenuOpc2%"    ==  "4"  goto SubMenuOpc2_4
		IF "%SubMenuOpc2%"    ==  "3"  goto SubMenuOpc2_3
		IF "%SubMenuOpc2%"    ==  "2"  goto SubMenuOpc2_2
		IF "%SubMenuOpc2%"    ==  "1"  goto SubMenuOpc2_1
		
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO -------------------------------------
		ECHO Por favor, elige un número del menú
		ECHO Menu [1-8] o elige '9 o Q' para salir.
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======		
		timeout 4
		goto subMenu2

			:SubMenuOpc2_1
			cls
			rem Para crear o editar la VLAN y definirle un nombre.
			ECHO Opción - 1

			set /P elegir_vlan2_1=Escríbeme el número de la VLAN que quieres crear o editar:
			powershell -Command "(gc .\submenu2\edit_vlan\edit_n_vlan.txt) -replace '"vlan .*"', '"vlan %elegir_vlan2_1%"' | Out-File -encoding ASCII .\submenu2\edit_vlan\edit_n_vlan.txt"
			set /P elegir_n2_1=Escríbeme el nombre que quieres darle a la VLAN %elegir_vlan1_2%:
			powershell -Command "(gc .\submenu2\edit_vlan\edit_n_vlan.txt) -replace '"name .*"', '"name %elegir_n2_1%"' | Out-File -encoding ASCII .\submenu2\edit_vlan\edit_n_vlan.txt"
			echo Editarás/Crearás la VLAN %elegir_vlan2_1% y le darás el nombre de %elegir_n2_1%.
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\edit_vlan\edit_n_vlan.txt"
			timeout 3
			goto subMenu2
			
			:SubMenuOpc2_2
			cls
			rem Agregar un puerto o eliminarlo de una VLAN.
			ECHO Opción - 2
			set elegir_opc_2_2=""
			set /P elegir_opc_2_2=Escribe '1' para definir VLANes en un puerto o '2' para eliminar/quitar VLANes de un puerto:
			IF "%elegir_opc_2_2%"== "1" (goto Opc_ElegirV_add_2_2)
			IF "%elegir_opc_2_2%"== "2" (goto Opc_ElegirV_delete_2_2)
			IF "%elegir_opc_2_2%x"== "x" (goto SubMenuOpc2_2)
			
			
			cls
			ECHO ============ENTRADA INCORRECTA============
			ECHO -------------------------------------
			ECHO Por favor, escribe  correctamente
			ECHO -------------------------------------
			ECHO ======ESPERE A SER REEDIRIGIDO======
			timeout 3
			goto subMenu2
			
				:Opc_ElegirV_add_2_2
				cls
				set elegir_V_2_2=""
				set /P elegir_V_2_2=Escribe '1' si es la version del SW v1.0 o escribe '2' si la version del SW es v2.0
				IF "%elegir_V_2_2%"== "1" (goto Opc_2_2_add_1_v1-new)
				IF "%elegir_V_2_2%"== "2" (goto Opc_2_2_add_1_v2-new)
				IF "%elegir_V_2_2%x"== "x"  (goto Opc_ElegirV_add_2_2)
				
				cls
				ECHO ============ENTRADA INCORRECTA============
				ECHO -------------------------------------
				ECHO Por favor, escribe  correctamente...
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======				
				timeout 3
				goto subMenu2
				
				:Opc_ElegirV_delete_2_2
				cls
				set elegir_V_2_2-sup=""
				set /P elegir_V_2_2-sup=Escribe '1' si es la version del SW v1.0 o escribe '2' si la version del SW es v2.0:
				rem Como no puedo probar esto con un SW v1.0 voy a utilizar el mismo comando para ambas versiones a ver si funciona correctamente.
				IF "%elegir_V_2_2-sup%"== "1" (goto Opc_2_2_sup_2_v1)
				IF "%elegir_V_2_2-sup%"== "2" (goto Opc_2_2_sup_2)
				IF "%elegir_V_2_2-sup%x"== "x"  (goto Opc_ElegirV_delete_2_2)
				
				cls
				ECHO ============ENTRADA INCORRECTA============
				ECHO -------------------------------------
				ECHO Por favor, escribe  correctamente...
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======				
				timeout 3
				goto subMenu2
				
				
				
				:Opc_2_2_add_1_v1-new
				rem Si existe el archivo, borrar
				IF EXIST .\submenu2\port\2_NEW_add_port_to_vlan.txt DEL .\submenu2\port\2_NEW_add_port_to_vlan.txt
				rem Si no existe el archivo, crearlo 
				IF NOT EXIST TYPE nul > .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo Código para agregar VLANES a determinados puertos.
				
				set /P elegir_puerto2_2=Escríbe desde que puerto quieres emprezar:
				set /P elegir_puerto2_2-2=Escríbe desde que puerto quieres terminar:
				set /P elegir_vlan2_2=Escríbeme el o los números de las VLANES a las que quieras que pertenezca a los puertos %elegir_puerto2_2% al %elegir_puerto2_2-2%, (p.e: 2,4-6):

				echo ! >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo enable >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo configure >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
				
				FOR /L %%i IN (%elegir_puerto2_2%,1,%elegir_puerto2_2-2%) DO (

					echo interface gigabitEthernet 1/0/%%i >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
					echo switchport mode general >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
					echo switchport general allowed vlan %elegir_vlan% untagged >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
					)
			  
				echo exit >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo exit >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
					
				set /P elegir_modo2_2=Indícame en con el 1,2 o 3 con qué modo quieres que funcionen los puertos del %elegir_puerto2_2% al %elegir_puerto2_2-2% , access[1], trunk[2] o general[3]:
				IF "%elegir_modo2_2%"== "1" (goto vlan-cong_2_2_acces)
				IF "%elegir_modo2_2%"== "2" (goto vlan-cong_2_2_trunk)
				IF "%elegir_modo2_2%"== "3" (goto vlan-cong_2_2_general)
				
				cls
				ECHO ============ENTRADA INCORRECTA============
				ECHO -------------------------------------
				ECHO Por favor, escribe  correctamente...
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======				
				timeout 3
				goto Opc_2_2_add_1_v1
				
				:vlan-cong_2_2_acces
				powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"mode .*"', '"mode access"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
				powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"^.*allowed"', '"switchport access allowed"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
				goto verificar_tagg_2_2
				:vlan-cong_2_2_trunk
				powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"mode .*"', '"mode trunk"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
				powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"^.*allowed"', '"switchport trunk allowed"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
				goto verificar_tagg_2_2
				:vlan-cong_2_2_general
				powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"mode .*"', '"mode general"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
				powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"^.*allowed"', '"switchport general allowed"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
				goto verificar_tagg_2_2
				
				:verificar_tagg_2_2
				set verificar2_2=""
				set /P verificar2_2=[1m Escribe "1" para que taggear el puerto,"2" para que dejarlo como untagged: [0m
				IF "%verificar2_2%"== "1" (goto Si_2_2)
				IF "%verificar2_2%"== "2" (goto No_2_2)
				IF "%verificar2_2%x"== "x"  (goto Opc_2_2_add_1_v1-new)
				
				cls
				ECHO ============ENTRADA INCORRECTA============
				ECHO -------------------------------------
				ECHO Por favor, escribe  correctamente...
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======				
				timeout 3
				goto verificar_tagg_2_2
				
				
				
					:Si_2_2
					cls
					powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"^allowed .*"', '"allowed vlan %elegir_vlan2_2% tagged"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
					plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\port\2_NEW_add_port_to_vlan.txt"
					timeout 3
					goto subMenu2
					
					
					:No_2_2
					cls
					powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"^allowed .*"', '"allowed vlan %elegir_vlan2_2% untagged"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
					plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\port\2_NEW_add_port_to_vlan.txt"
					timeout 3
					goto subMenu2
				

				cls
				ECHO ============ENTRADA INCORRECTA============
				ECHO -------------------------------------
				ECHO Por favor, escribe  correctamente...
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======				
				timeout 3
				goto subMenu2

rem -------------------------------------CAMBIO_DE_VERSIÓN-------------------

				:Opc_2_2_add_1_v2-new
				rem Si existe el archivo, borrar
				IF EXIST .\submenu2\port\2_NEW_add_port_to_vlan.txt DEL .\submenu2\port\2_NEW_add_port_to_vlan.txt
				rem Si no existe el archivo, crearlo 
				IF NOT EXIST TYPE nul > .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo Código para agregar VLANES a determinados puertos.
				
				set /P elegir_puerto2_2=Escríbe desde que puerto quieres emprezar:
				set /P elegir_puerto2_2-2=Escríbe desde que puerto quieres terminar:
				set /P elegir_vlan2_2=Escríbeme el o los números de las VLANES a las que quieras que pertenezca a los puertos %elegir_puerto2_2% al %elegir_puerto2_2-2%, (p.e: 2,4-6):

				echo ! >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo enable >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo configure >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
				
				FOR /L %%i IN (%elegir_puerto2_2%,1,%elegir_puerto2_2-2%) DO (

					echo interface gigabitEthernet 1/0/%%i >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
					echo switchport general allowed vlan %elegir_vlan% untagged >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
					)
			  
				echo exit >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo exit >> .\submenu2\port\2_NEW_add_port_to_vlan.txt
				
				goto verificar_tagg_2_2
					
				:verificar_tagg_2_2
				set verificar2_2=""
				set /P verificar2_2=[1m Escribe "1" para que taggear el puerto,"2" para que dejarlo como untagged: [0m
				IF "%verificar2_2%"== "1" (goto Si_2_2)
				IF "%verificar2_2%"== "2" (goto No_2_2)
				IF "%verificar2_2%x"== "x"  (goto Opc_2_2_add_1_v2-new)
				
				cls
				ECHO ============ENTRADA INCORRECTA============
				ECHO -------------------------------------
				ECHO Por favor, escribe  correctamente...
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======				
				timeout 3
				goto verificar_tagg_2_2
				
				
				
					:Si_2_2
					cls
					powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"^allowed .*"', '"allowed vlan %elegir_vlan2_2% tagged"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
					plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\port\2_NEW_add_port_to_vlan.txt"
					timeout 3
					goto subMenu2
					
					
					:No_2_2
					cls
					powershell -Command "(gc .\submenu2\port\2_NEW_add_port_to_vlan.txt) -replace '"^allowed .*"', '"allowed vlan %elegir_vlan2_2% untagged"' | Out-File -encoding ASCII .\submenu2\port\2_NEW_add_port_to_vlan.txt"
					plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\port\2_NEW_add_port_to_vlan.txt"
					timeout 3
					goto subMenu2
				
				
				cls
				ECHO ============ENTRADA INCORRECTA============
				ECHO -------------------------------------
				ECHO Por favor, escribe  correctamente...
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======				
				timeout 3
				goto subMenu2

				
				:Opc_2_2_sup_2
				cls
				rem Para eliminar puertos de una VLAN.
				IF EXIST .\submenu2\port\sup_port_to_vlan.txt DEL .\submenu2\port\sup_port_to_vlan.txt
				rem Si no existe el archivo, crearlo 
				IF NOT EXIST TYPE nul > .\submenu2\port\sup_port_to_vlan.txt
				
				set /P elegir_puerto2_2_sup=Escríbeme el número del puerto desde el que quieres empezar:
				set /P elegir_puerto2_2_sup-2=Escríbeme el número del puerto desde el que quieres terminar:
				set /P elegir_vlan2_2_sup=Escríbeme el o los números de las VLANES a las que quieras que se eliminen del puerto %elegir_puerto2_2_sup% al %elegir_puerto2_2_sup-2% , (p.e: 2,4-6):
				
				
				echo ! >> .\submenu2\port\sup_port_to_vlan.txt
				echo enable >> .\submenu2\port\sup_port_to_vlan.txt
				echo configure >> .\submenu2\port\sup_port_to_vlan.txt

				FOR /L %%i IN (%elegir_puerto2_2_sup%,1,%elegir_puerto2_2_sup-2%) DO (

					echo interface gigabitEthernet 1/0/%%i >> .\submenu2\port\sup_port_to_vlan.txt
					echo no switchport general allowed vlan %elegir_vlan2_2_sup% >> .\submenu2\port\sup_port_to_vlan.txt
				  )
				  
				echo exit >> .\submenu2\port\sup_port_to_vlan.txt
				echo exit >> .\submenu2\port\sup_port_to_vlan.txt
				
				
				plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\port\sup_port_to_vlan.txt"

				timeout 3
				goto subMenu2
				
				:Opc_2_2_sup_2_v1
				rem Lo que no estoy seguro es si esto funcionaría con la versión v1.0 de un SW tp-link, habría que probarlo...
				cls
				rem Para eliminar puertos de una VLAN.
				IF EXIST .\submenu2\port\sup_port_to_vlan.txt DEL .\submenu2\port\sup_port_to_vlan.txt
				rem Si no existe el archivo, crearlo 
				IF NOT EXIST TYPE nul > .\submenu2\port\sup_port_to_vlan.txt
				
				set /P elegir_puerto2_2_sup=Escríbeme el número del puerto desde el que quieres empezar:
				set /P elegir_puerto2_2_sup-2=Escríbeme el número del puerto desde el que quieres terminar:
				set /P elegir_vlan2_2_sup=Escríbeme el o los números de las VLANES a las que quieras que se eliminen del puerto %elegir_puerto2_2_sup% al %elegir_puerto2_2_sup-2% , (p.e: 2,4-6):
				
				
				echo ! >> .\submenu2\port\sup_port_to_vlan.txt
				echo enable >> .\submenu2\port\sup_port_to_vlan.txt
				echo configure >> .\submenu2\port\sup_port_to_vlan.txt

				FOR /L %%i IN (%elegir_puerto2_2_sup%,1,%elegir_puerto2_2_sup-2%) DO (

					echo interface gigabitEthernet 1/0/%%i >> .\submenu2\port\sup_port_to_vlan.txt
					echo no switchport mode general >> .\submenu2\port\sup_port_to_vlan.txt
					echo no switchport general allowed vlan %elegir_vlan2_2_sup% >> .\submenu2\port\sup_port_to_vlan.txt
				  )
				  
				echo exit >> .\submenu2\port\sup_port_to_vlan.txt
				echo exit >> .\submenu2\port\sup_port_to_vlan.txt
				
				
				plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\port\sup_port_to_vlan.txt"

				timeout 3
				goto subMenu2
				
				
			:SubMenuOpc2_3
			cls
			ECHO Opción - 3 (Cambiar interfaz de red de una VLAN)
			rem Para cambiar la dirección IP de la interfaz de red de una VLAN.

			set /P elegir_vlan2_3=Escríbeme la VLAN de la cual quieres modificar la dirección IP:
			rem Para guardar el valor de un número en una variable
			powershell -Command "(gc .\submenu2\dir_IP\dirIP.txt) -replace '"interface vlan .*"', '"interface vlan %elegir_vlan2_3%"' | Out-File -encoding ASCII .\submenu2\dir_IP\dirIP.txt"
			rem Con el valor de la variable y utilizando PowerShell se remplaza el valor en un archivo '.txt' que luego se pasará el SW por Serial.
			set /P elegir_ip2_3=Escríbeme la dirección IP que quieres  a la VLAN %elegir_vlan2_3%:
			rem Toma el valor de la dirección IP que ingreses y lo guarda en la variable 'elegir_ip2_3'
			set /P elegir_mascara2_3=Escríbeme la máscara de red que quieres darle a la VLAN %elegir_vlan2_3%:
			rem Toma el valor de la máscare de red que ingreses y lo guarda en la variable 'elegir_ip2_3'
			powershell -Command "(gc .\submenu2\dir_IP\dirIP.txt) -replace '"ip address .*"', '"ip address %elegir_ip2_3% %elegir_mascara2_3%"' | Out-File -encoding ASCII .\submenu2\dir_IP\dirIP.txt"
			set /P elegir_nombre2_3=Escríbeme el nombre que quieres darle a la VLAN %elegir_vlan2_3%:
			powershell -Command "(gc .\submenu2\dir_IP\dirIP.txt) -replace '"description .*"', '"description %elegir_nombre2_3%"' | Out-File -encoding ASCII .\submenu2\dir_IP\dirIP.txt"
			
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\dir_IP\dirIP.txt"
			echo La configuración ha sido %elegir_ip2_3% con %elegir_mascara2_3% y %elegir_nombre2_3% para la VLAN %elegir_vlan2_3%
			timeout 3
			goto subMenu1
				

			:SubMenuOpc2_4
			rem Cargar una configuración genérica de VLANes.
			cls
			ECHO Opción - 
			
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\generic_vlanes\script_vlan.txt"
			
			timeout 3
			goto subMenu2
			
			:SubMenuOpc2_5
			rem Para eliminar una VLAN.
			cls
			ECHO Opción - 5
			
			set /P elegir_vlan2_5=Escríbeme el número de la VLAN que quieres eliminar:
			powershell -Command "(gc .\submenu2\edit_vlan\sup_edit_n_vlan.txt) -replace '"vlan .*"', '"vlan %elegir_vlan2_5%"' | Out-File -encoding ASCII .\submenu2\edit_vlan\sup_edit_n_vlan.txt"
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\edit_vlan\sup_edit_n_vlan.txt"

			
			timeout 5
			goto subMenu2
			
			:SubMenuOpc2_6
			rem Connfigurar la PVID de un puerto.
			cls
			ECHO Opción - 6 (Cambiar PVID de un puerto)
			
			set /P elegir_port_2_6=Escribe el puerto desde dónde deseas empezar:
			set /P elegir_port_2_6_2=Escribe el puerto desde dónde deseas terminar:
			set /P elegir_pvid_2_6=Escribe el PVID para el puerto %elegir_port_2_6% hasta el %elegir_port_2_6_2%:
			
				IF EXIST .\submenu2\port\change_pvid_port.txt DEL .\submenu2\port\change_pvid_port.txt
				rem Si no existe el archivo, crearlo 
				IF NOT EXIST TYPE nul > .\submenu2\port\change_pvid_port.txt
				
				echo ! >> .\submenu2\port\change_pvid_port.txt
				echo enable >> .\submenu2\port\change_pvid_port.txt
				echo configure >> .\submenu2\port\change_pvid_port.txt
				
					FOR /L %%i IN (%elegir_port_2_6%,1,%elegir_port_2_6_2%) DO (

					echo interface gigabitEthernet 1/0/%%i >> .\submenu2\port\change_pvid_port.txt
					echo switchport pvid %elegir_pvid_2_6% >> .\submenu2\port\change_pvid_port.txt
				  )
				  
				 echo exit >> .\submenu2\port\change_pvid_port.txt
				echo exit >> .\submenu2\port\change_pvid_port.txt
			
			
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\port\change_pvid_port.txt"

			timeout 3
			goto subMenu2
			
			
			:SubMenuOpc2_7
			rem Mostrar la información de una VLAN.
			cls
			ECHO Opción - 7 (Mostrar información de una VLAN)
			set vlan_id_2_7=""
			set /P vlan_id_2_7=Escríbe la ID de la VLAN o 'T' para mostrar todas:
			
			IF "%vlan_id_2_7%"== "t" (goto vlanTodo2_7)
			IF "%vlan_id_2_7%"== "T" (goto vlanTodo2_7)
			IF "%vlan_id_2_7%x"== "x" (goto subMenu2) else (goto vlan2_7)
			
			echo.
			ECHO ==============NOP!===============
			ECHO -------------------------------------
			ECHO -------------------------------------
			ECHO ======ESCRIBE ALGO, PORFAVOR======
			timeout 3
			goto subMenu2
			
			
				:vlanTodo2_7
				plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\vlanes\info-id\info-id-vlan-todas.txt"
				timeout 3
				goto subMenu2
				:vlan2_7
				powershell -Command "(gc .\submenu2\vlanes\info-id\info-id-vlan.txt) -replace '"id .*"', '"id %vlan_id_2_7%"' | Out-File -encoding ASCII .\submenu2\vlanes\info-id\info-id-vlan.txt"
				plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\vlanes\info-id\info-id-vlan.txt"
				timeout 3
				goto subMenu2
			
			:SubMenuOpc2_8
			rem Resumen de VLANes
			cls
			ECHO Opción - 8 (Resumen de VLANES)
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\vlanes\summary\summary.txt"
			
			
			
			
			timeout 3
			goto subMenu2
			
			:SubMenuOpc2_9
			rem Volver al menú principal, desde donde estás, que es el submenú 2.
			cls
			ECHO ==============GRACIAS!===============
			ECHO -------------------------------------
			ECHO -------------------------------------
			ECHO ======ESPERE A SER REEDIRIGIDO======
			timeout 0
			goto MENU0		
		
:MenuOpc0_3
rem subMENÚ [3] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		cls
		ECHO Opción - 3 (CLI)
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits%
		timeout 3
		goto MENU0
		

:MenuOpc0_4
rem subMENÚ [4] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		:subMenu4
			
		cls
		ECHO. Modificar puertos - SUBMENÚ 4.	
		ECHO.     
		ECHO.     
		ECHO.     1.- Activar o Desactivar Spanning Tree.
		ECHO.     2.- Activar o Desactivar LoopBack Detection.
		ECHO.     3.- Activar o Descativar SSH.
		ECHO.     4.- ---------------------------------------------------------
		ECHO.     5.- ---------------------------------------------------------
		ECHO.     6/Q.- Escribe "Q" para volver.
		set SubMenuOpc4=""
		set /P SubMenuOpc4=Su Opción es:
		
		IF "%SubMenuOpc4%x"   ==  "x"  goto subMenu4
		IF "%SubMenuOpc4%"    ==  "6"  goto SubMenuOpc4_6
		IF "%SubMenuOpc4%"    ==  "Q"  goto SubMenuOpc4_6
		IF "%SubMenuOpc4%"    ==  "q"  goto SubMenuOpc4_6
		IF "%SubMenuOpc4%"    ==  "5"  goto SubMenuOpc4_5
		IF "%SubMenuOpc4%"    ==  "4"  goto SubMenuOpc4_4
		IF "%SubMenuOpc4%"    ==  "3"  goto SubMenuOpc4_3
		IF "%SubMenuOpc4%"    ==  "2"  goto SubMenuOpc4_2
		IF "%SubMenuOpc4%"    ==  "1"  goto SubMenuOpc4_1
		
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO -------------------------------------
		ECHO Por favor, elige un número del menú
		ECHO Menu [1-5] o elige '6 o Q' para salir.
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======	
		timeout 4
		goto MENU0

		:SubMenuOpc4_1
		cls
		ECHO Opción - 1 (Activar o Desactivar Spanning Tree)
		set elegir4_1=""
		set /P elegir4_1=Escribe "1" para activar Spanning Tree, "2" para desactivarlo o  "Q" para volver al menú anterior:
		IF "%elegir4_1%"=="1" (goto activar4_1)
		IF "%elegir4_1%"=="2" (goto desactivar4_1)
		IF "%elegir4_1%"=="1" (goto activar4_1)
		IF "%elegir4_1%"=="2" (goto desactivar4_1)
		IF "%elegir4_1%"=="Q" (goto subMenu4)
		IF "%elegir4_1%"=="q" (goto subMenu4)
		IF "%elegir4_1%x"=="x" (goto SubMenuOpc4_1)
		
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO Por favor, escribe '1' , '2' o 'Q'
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======
		timeout 3
		goto subMenu4
		
				:activar4_1
				plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu4\spanning-tree\activar.txt"
				timeout 3
				goto subMenu4
				
				:desactivar4_1
				plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu4\spanning-tree\desactivar.txt"
				timeout 3
				goto subMenu4
			
		:SubMenuOpc4_2
		cls
		ECHO Opción - 2 (Activar o Desactivar LoopBack Detection)
		set elegir4_2=""
		set /P elegir4_2=Escribe "1" para activar LoopBack-Detection, "2" para desactivarlo o  "Q" para volver al menú anterior:
		IF "%elegir4_2%"=="1" (goto activar4_2)
		IF "%elegir4_2%"=="N2 (goto desactivar4_2)
		IF "%elegir4_2%"=="1" (goto activar4_2)
		IF "%elegir4_2%"=="2" (goto desactivar4_2)
		IF "%elegir4_2%"=="Q" (goto subMenu4)
		IF "%elegir4_2%"=="q" (goto subMenu4)
		IF "%elegir4_2%x"=="x"  (goto SubMenuOpc4_2)
			
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO Por favor, escribe '1' , '2 o 'Q'
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======
		timeout 3
		goto subMenu4
			:activar4_2
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu4\LoopBack\Activar\activar.txt"
			timeout 3
			goto subMenu4
			:desactivar4_2
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu4\LoopBack\Desactivar\desactivar.txt"
			timeout 3
			goto subMenu4

		:SubMenuOpc4_3
		cls
		ECHO Opción - 3 (Activar o Descativar SSH)
		set verificar4_3=""
		set /P verificar4_3=Indícame con un '1' si quieres activar SSH para el SW o '2' si quieres desactivarlo:
		IF "%verificar4_3%"=="1" (goto activar4_3)
		IF "%verificar4_3%"=="2" (goto desactivar4_3)
		IF "%verificar4_3%x"=="x" (goto SubMenuOpc4_3)
		
			:activar4_3
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu4\ssh\on-ssh.txt"
			timeout 3
			goto subMenu4
			
			:desactivar4_3
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu4\ssh\off-ssh.txt"
			timeout 3
			goto subMenu4
		
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO Por favor, escribe '1' , '2'
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======
		timeout 3
		goto subMenu4
		
		:SubMenuOpc4_4
		cls
		ECHO Opción - 4
		
		
		
		
		
		timeout 3
		goto subMenu4
		
		:SubMenuOpc4_5
		cls
		ECHO Opción - 5
		
		
		
		
		
		timeout 3
		goto subMenu4
		
		:SubMenuOpc4_6
		cls
		ECHO ==============GRACIAS!===============
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======

		timeout 0
		goto MENU0	


:MenuOpc0_5
rem subMENÚ [5] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		:subMenu5
		rem Submenú 5
			
		cls
		ECHO. Modificar puertos - SUBMENÚ 5.	
		ECHO.     
		ECHO.     
		ECHO.     1.- Elegir puertos para Activat/Desactivar LoopBack.
		ECHO.     2.- Elegir tamaño de la trama JUMBO.
		ECHO.     3.- ---------------------------------------------------------
		ECHO.     4.- ---------------------------------------------------------
		ECHO.     5.- ---------------------------------------------------------
		ECHO.     6/Q.- Escribe "Q" para volver.
		set SubMenuOpc5=""
		set /P SubMenuOpc5=Su Opción es:
		
		IF "%SubMenuOpc5%x"    ==  "x"   goto subMenu5
		IF "%SubMenuOpc5%"    ==  "6"  goto SubMenuOpc5_6
		IF "%SubMenuOpc5%"    ==  "Q"  goto SubMenuOpc5_6
		IF "%SubMenuOpc5%"    ==  "q"  goto SubMenuOpc5_6
		IF "%SubMenuOpc5%"    ==  "5"  goto SubMenuOpc5_5
		IF "%SubMenuOpc5%"    ==  "4"  goto SubMenuOpc5_4
		IF "%SubMenuOpc5%"    ==  "3"  goto SubMenuOpc5_3
		IF "%SubMenuOpc5%"    ==  "2"  goto SubMenuOpc5_2
		IF "%SubMenuOpc5%"    ==  "1"  goto SubMenuOpc5_1
		
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO -------------------------------------
		ECHO Por favor, elige un número del menú
		ECHO Menu [1-5] o elige '6 o Q' para salir.
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======	
		timeout 4
		goto MENU0

			:SubMenuOpc5_1
			cls
			ECHO Opción - 1 (Activar o Desactivar LoopBack en los puertos)
			set verificar5_1=""
			set /P numPuerto5_1=Escríbeme el puerto desde donde quieres empezar:
			set /P numPuerto5_1_2=Escríbeme el puerto donde quieres terminar:
			set /P verificar5_1=Elige 1 para activar o 2 para desactivarlo en los puertos del %numPuerto5_1% hasta el %numPuerto5_1_2%:
			
			IF "%verificar5_1%"=="2" (goto desactivar5_1)
			IF "%verificar5_1%"=="1" (goto continuar5_1)
			IF "%verificar5_1%"=="2" (goto desactivar5_1)
			IF "%verificar5_1%"=="1" (goto continuar5_1)
			IF "%verificar5_1%x"=="x"  (goto SubMenuOpc5_1)
			
			cls
			ECHO ============ENTRADA INCORRECTA============
			ECHO Por favor, escribe '1' o '2'
			ECHO -------------------------------------
			ECHO ======ESPERE A SER REEDIRIGIDO======	
			timeout 3
			goto subMenu5
			
				:continuar5_1
					IF EXIST .\submenu5\LoopBack\Puertos\on.txt DEL .\submenu5\LoopBack\Puertos\on.txt
					rem Si existe el archivo, se elimina, si no existe se crea un archivo txt en blanco.
					IF NOT EXIST TYPE nul > .\submenu5\LoopBack\Puertos\on.txt
				
					echo ! >> .\submenu5\LoopBack\Puertos\on.txt
					echo enable >> .\submenu5\LoopBack\Puertos\on.txt
					echo configure >> .\submenu5\LoopBack\Puertos\on.txt

					FOR /L %%i IN (%numPuerto5_1%,1,%numPuerto5_1_2%) DO (

					echo interface gigabitEthernet 1/0/%%i >> .\submenu5\LoopBack\Puertos\on.txt
					echo loopback-detection config process-mode port-based recovery-mode auto >> .\submenu5\LoopBack\Puertos\on.txt
					echo loopback-detection >> .\submenu5\LoopBack\Puertos\on.txt
					)

					echo exit >> .\submenu5\LoopBack\Puertos\on.txt
					echo exit >> .\submenu5\LoopBack\Puertos\on.txt
					
					plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu5\LoopBack\Puertos\on.txt"
					timeout 3
					goto subMenu5
					
				:desactivar5_1
					IF EXIST .\submenu5\LoopBack\Puertos\off.txt DEL .\submenu5\LoopBack\Puertos\off.txt
					rem Si existe el archivo, se elimina, si no existe se crea un archivo txt en blanco.
					IF NOT EXIST TYPE nul > .\submenu5\LoopBack\Puertos\off.txt
				
					echo ! >> .\submenu5\LoopBack\Puertos\off.txt
					echo enable >> .\submenu5\LoopBack\Puertos\off.txt
					echo configure >> .\submenu5\LoopBack\Puertos\off.txt

					FOR /L %%i IN (%numPuerto5_1%,1,%numPuerto5_1_2%) DO (

					echo interface gigabitEthernet 1/0/%%i >> .\submenu5\LoopBack\Puertos\off.txt
					echo no loopback-detection >> .\submenu5\LoopBack\Puertos\off.txt
					)

					echo exit >> .\submenu5\LoopBack\Puertos\off.txt
					echo exit >> .\submenu5\LoopBack\Puertos\off.txt
					
					plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu5\LoopBack\Puertos\off.txt"
					timeout 3
					goto subMenu5
			
			:SubMenuOpc5_2
			cls
			ECHO Opción - 2 (Cambiar tamaño trama JUMBO)
			
			set /P jumbo5_2=Dime el tamaño de la trama jumbo (de 1518 to 9216 bytes):
			IF EXIST .\submenu5\jumbo\jumbo.txt DEL .\submenu5\jumbo\jumbo.txt
			rem Si no existe el archivo, crearlo 
			IF NOT EXIST TYPE nul > .\submenu5\jumbo\jumbo.txt
			
			echo ! >> .\submenu5\jumbo\jumbo.txt
			echo enable >> .\submenu5\jumbo\jumbo.txt
			echo configure >> .\submenu5\jumbo\jumbo.txt
			echo jumbo-size %jumbo5_2% >> .\submenu5\jumbo\jumbo.txt
			echo exit >> .\submenu5\jumbo\jumbo.txt
			echo exit >> .\submenu5\jumbo\jumbo.txt
			
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu5\jumbo\jumbo.txt"
			timeout 3
			goto subMenu5
			
			


			:SubMenuOpc5_3
			cls
			ECHO Opción - 3
			
			rem Ampliación Futura
			
			timeout 3
			goto subMenu5
			
			:SubMenuOpc5_4
			cls
			ECHO Opción - 4
			
			
			rem Ampliación Futura
			
			
			timeout 3
			goto subMenu5
			
			:SubMenuOpc5_5
			cls
			ECHO Opción - 5
			rem Ampliación Futura
			
			
			
			
			timeout 3
			goto subMenu5
		
			:SubMenuOpc5_6
			cls
			ECHO ==============GRACIAS!===============
			ECHO -------------------------------------
			ECHO -------------------------------------
			ECHO ======ESPERE A SER REEDIRIGIDO======
			timeout 0
			goto MENU0			

:MenuOpc0_6
	IF EXIST .\submenu6\ultimate\ultimate.txt DEL .\submenu6\ultimate\ultimate.txt
	IF NOT EXIST TYPE nul > .\submenu6\ultimate\ultimate.txt

	echo Estás preparado para la mejor herramienta de la historia?
	echo !!Pulsa cualquier tecla para continuar¡¡
	pause>nul
	
	
	
	set /P nombre6=Dime el nombre para el SW:
	set /P location6=Dime la localización del SW:
	set /P conct_info6=Dime la información de contacto:
	
	set /P GTWdir6=Dime la puerta de enlace de ADM:
	
	set /P jumbo6=Dime el tamaño de la trama jumbo (de 1518 to 9216 bytes):
	
	set /P portVlan2_1_6=Dime desde qué puerto quieres que empiece la VLAN 2:
	set /P portVlan2_2_6=Dime desde qué puerto quieres que termine la VLAN 2 [97m(si no tienes otro puertos que poner, pon el anterior y listo)[0m:
	set /P portVlan3_1_6=Dime desde qué puerto quieres que empiece la VLAN 3:
	set /P portVlan3_2_6=Dime desde qué puerto quieres que termine la VLAN 3 [97m(si no tienes otro puertos que poner, pon el anterior y listo)[0m:
	set /P portVlan4_1_6=Dime desde qué puerto quieres que empiece la VLAN 4:
	set /P portVlan4_2_6=Dime desde qué puerto quieres que termine la VLAN 4 [97m(si no tienes otro puertos que poner, pon el anterior y listo)[0m:
	set /P portVlan6_1_6=Dime desde qué puerto quieres que empiece la VLAN 6:
	set /P portVlan6_2_6=Dime desde qué puerto quieres que termine la VLAN 6 [97m(si no tienes otro puertos que poner, pon el anterior y listo)[0m:
		
	set /P portTrunk_6=Dime qué puerto quieres como troncal:
	set /P portTrunk_6_2=Dime qué otro quieres como troncal [97m(si no tienes otro puertos que poner, pon el anterior y listo)[0m:
	set /a portTrunk_6_2_1=%portTrunk_6_2%-%portTrunk_6%
	IF "%portTrunk_6_2_1%"=="0" (set /A portTrunk_6_2_1=%portTrunk_6_2%+%portTrunk_6%)
	
	set /P interface_dir_ADM_6=Dime que dirección IP quieres para el SW:
	set /P interface_mask_ADM_6=Dime que máscara de Red utiliza la vlan ADM:



	
	echo ! >> .\submenu6\ultimate\ultimate.txt
	echo enable >> .\submenu6\ultimate\ultimate.txt
	echo configure >> .\submenu6\ultimate\ultimate.txt
	
	echo hostname %nombre6% >> .\submenu6\ultimate\ultimate.txt
	echo location %location6% >> .\submenu6\ultimate\ultimate.txt
	echo contact-info %conct_info6% >> .\submenu6\ultimate\ultimate.txt
	
	echo system-time ntp UTC+01:00 %GTWdir6% %GTWdir6% 12 >> .\submenu6\ultimate\ultimate.txt
	
	echo jumbo-size %jumbo6% >> .\submenu6\ultimate\ultimate.txt
	
	echo vlan 2 >> .\submenu6\ultimate\ultimate.txt
	echo name ADM >> .\submenu6\ultimate\ultimate.txt
	echo vlan 3 >> .\submenu6\ultimate\ultimate.txt
	echo name PROF >> .\submenu6\ultimate\ultimate.txt
	echo vlan 4 >> .\submenu6\ultimate\ultimate.txt
	echo name NAV >> .\submenu6\ultimate\ultimate.txt
	echo vlan 6 >> .\submenu6\ultimate\ultimate.txt
	echo name IMP >> .\submenu6\ultimate\ultimate.txt
	
	echo exit >> .\submenu6\ultimate\ultimate.txt
	
	FOR /L %%2 IN (%portVlan2_1_6%,1,%portVlan2_2_6%) DO (
	
	echo interface gigabitEthernet 1/0/%%2 >> .\submenu6\ultimate\ultimate.txt
	echo switchport general allowed vlan 2 untagged >> .\submenu6\ultimate\ultimate.txt
	echo switchport pvid 2 >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection config process-mode port-based recovery-mode auto >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection >> .\submenu6\ultimate\ultimate.txt
	
	)
	
	FOR /L %%3 IN (%portVlan3_1_6%,1,%portVlan3_2_6%) DO (
	
	echo interface gigabitEthernet 1/0/%%3 >> .\submenu6\ultimate\ultimate.txt
	echo switchport general allowed vlan 3 untagged >> .\submenu6\ultimate\ultimate.txt
	echo switchport pvid 3 >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection config process-mode port-based recovery-mode auto >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection >> .\submenu6\ultimate\ultimate.txt
	
	)
	
	FOR /L %%4 IN (%portVlan4_1_6%,1,%portVlan4_2_6%) DO (
	
	echo interface gigabitEthernet 1/0/%%4 >> .\submenu6\ultimate\ultimate.txt
	echo switchport general allowed vlan 4 untagged >> .\submenu6\ultimate\ultimate.txt
	echo switchport pvid 4 >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection config process-mode port-based recovery-mode auto >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection >> .\submenu6\ultimate\ultimate.txt
	
	)
	
	FOR /L %%6 IN (%portVlan6_1_6%,1,%portVlan6_2_6%) DO (
	
	echo interface gigabitEthernet 1/0/%%6 >> .\submenu6\ultimate\ultimate.txt
	echo switchport general allowed vlan 6 untagged >> .\submenu6\ultimate\ultimate.txt
	echo switchport pvid 6 >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection config process-mode port-based recovery-mode auto >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection >> .\submenu6\ultimate\ultimate.txt
	
	)
	
	
	FOR /L %%T IN (%portTrunk_6%,%portTrunk_6_2_1%,%portTrunk_6_2%) DO (
	
	echo interface gigabitEthernet 1/0/%%T >> .\submenu6\ultimate\ultimate.txt
	echo switchport general allowed vlan 2,3,4,6 tagged >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection config process-mode port-based recovery-mode auto >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection >> .\submenu6\ultimate\ultimate.txt
	
	)
	
	FOR /L %%F IN (25,1,28) DO (
	
	echo interface gigabitEthernet 1/0/%%F >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection config process-mode port-based recovery-mode auto >> .\submenu6\ultimate\ultimate.txt
	echo loopback-detection >> .\submenu6\ultimate\ultimate.txt
	
	)
	
	echo interface vlan 2 >> .\submenu6\ultimate\ultimate.txt
	echo ip address %interface_dir_ADM_6% %interface_mask_ADM_6% >> .\submenu6\ultimate\ultimate.txt
	echo description ADM >> .\submenu6\ultimate\ultimate.txt
	
	echo exit >> .\submenu6\ultimate\ultimate.txt
	
	echo ip route 10.0.0.0 255.0.0.0 %GTWdir6% 1 >> .\submenu6\ultimate\ultimate.txt
	
	echo loopback-detection >> .\submenu6\ultimate\ultimate.txt
	
	echo exit >> .\submenu6\ultimate\ultimate.txt
	echo exit >> .\submenu6\ultimate\ultimate.txt
	
	plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu6\ultimate\ultimate.txt"
	
	
	
	
	ECHO ==============GRACIAS!===============
	ECHO -------------------------------------
	ECHO -------------------------------------
	ECHO ======ESPERE A SER REEDIRIGIDO======
	timeout 0
	goto MENU0
		
		
:MenuOpc0_7
cls
chgport | findstr "COM"
echo.
set pCOM=""
set /P pCOM=Indícame el puerto COM por el que se conecta el SW:
IF "%pCOM%x"=="x" (goto MenuOpc0_7)
echo.[1mTu puerto elegido ha sido el COM%pCOM%[0m
echo.
ECHO ==============GRACIAS!===============
ECHO -------------------------------------
ECHO -------------------------------------
ECHO ======ESPERE A SER REEDIRIGIDO======
timeout 3
goto MENU0


:MenuOpc0_8
rem subMENÚ [8] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		:subMenu8
		rem Submenú 8
		
netsh interface ipv4 show config name=%interfaceYou%|find "IP" > submenu8\IPv4.txt
netsh interface ipv4 show config name=%interfaceYou%|find "subred" > submenu8\netMASK.txt
netsh interface ipv4 show config name=%interfaceYou%|find "Puerta" > submenu8\GW.txt
netsh interface ipv4 show config name=%interfaceYou%|find "DNS" > submenu8\DNS.txt
for /f "tokens=3" %%4 in (.\submenu8\IPv4.txt) do set IPv4=%%4
for /f "tokens=6" %%m in (.\submenu8\netMASK.txt) do set netMask=%%m
set netMask=%netMask:~0,-1%
for /f "tokens=5" %%w in (.\submenu8\GW.txt) do set GW=%%w
for /f "tokens=5" %%z in (.\submenu8\DNS.txt) do set dns=%%z
			
		cls
		ECHO. Modificar puertos - SUBMENÚ 8.	
		ECHO.     
		ECHO.     
		ECHO.     1.- 192.168.0.x
		ECHO.     2.- 192.168.1.x
		ECHO.     3.- Red Manual Escuelas
		ECHO.     4.- DHCP
		ECHO.    [93m 5.- IPCONFIG/ALL. [0m
		ECHO.     6.- Elegir adaptador
		ECHO.     7.- Configuración Manual.
		ECHO.     8/Q.- Escribe "Q" para volver.
		echo.
		echo.     ___________________________________
		echo.     ^|                                          
		echo.     ^|[1m%IPv4%[0m  [IPv4]
		echo.     ^|[1m%netMask%[0m [MASK]
		echo.     ^|[1m%GW%[0m   [GW]
		echo.     ^|[1m%dns%[0m       [DNS]
		Echo.     ^|__________________________________
		set SubMenuOpc8=""
		set /P SubMenuOpc8=Su Opción es:
		
		IF "%SubMenuOpc8%x"   ==  "x"   goto subMenu8
		IF "%SubMenuOpc8%"    ==  "8"  goto SubMenuOpc8_8
		IF "%SubMenuOpc8%"    ==  "Q"  goto SubMenuOpc8_8
		IF "%SubMenuOpc8%"    ==  "q"  goto SubMenuOpc8_8
		IF "%SubMenuOpc8%"    ==  "7"  goto SubMenuOpc8_7
		IF "%SubMenuOpc8%"    ==  "6"  goto SubMenuOpc8_6
		IF "%SubMenuOpc8%"    ==  "5"  goto SubMenuOpc8_5
		IF "%SubMenuOpc8%"    ==  "4"  goto SubMenuOpc8_4
		IF "%SubMenuOpc8%"    ==  "3"  goto SubMenuOpc8_3
		IF "%SubMenuOpc8%"    ==  "2"  goto SubMenuOpc8_2
		IF "%SubMenuOpc8%"    ==  "1"  goto SubMenuOpc8_1
		
		cls
		ECHO ============ENTRADA INCORRECTA============
		ECHO -------------------------------------
		ECHO Por favor, elige un número del menú
		ECHO Menu [1-5] o elige '6 o Q' para salir.
		ECHO -------------------------------------
		ECHO ======ESPERE A SER REEDIRIGIDO======	
		timeout 4
		goto subMenu8		
			
			
			
			
			
			:SubMenuOpc8_1
				cls
				IF EXIST .\submenu8\configuraciones\192.168.0.x.bat DEL .\submenu8\configuraciones\192.168.0.x.bat
				IF NOT EXIST TYPE nul > .\submenu8\configuraciones\192.168.0.x.bat
				
				set ip8_1=""
				set /P ip8_1="Elige un rango del 1 al 253 (si lo dejas en blanco será 253): 192.168.0."
				
				
				IF "%ip8_1%x" EQU "x" (goto subMenu8)
				IF "%ip8_1%" GTR "0" (goto diferente8_1)
				IF NOT "%ip8_1%x" == "x" (goto 253_8_1) ELSE (goto diferente8_1)
				
				
				echo.
				ECHO ==============NOP!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======ESCRIBE ALGO, PORFAVOR======
				timeout 3
				goto subMenu8
					
					:253_8_1
					echo netsh interface ipv4 set address %interfaceYou% static 192.168.0.253 255.255.255.0 192.168.0.1 >> .\submenu8\configuraciones\192.168.0.x.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 8.8.8.8  >> .\submenu8\configuraciones\192.168.0.x.bat
					.\submenu8\direct\192.168.0.x.bat.lnk
					
					echo.
					ECHO ==============GRACIAS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======ESPERE A SER REEDIRIGIDO======
					timeout 3
					goto subMenu8
					
					:diferente8_1
					echo netsh interface ipv4 set address %interfaceYou% static 192.168.0.%ip8_1% 255.255.255.0 192.168.0.1 >> .\submenu8\configuraciones\192.168.0.x.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 8.8.8.8  >> .\submenu8\configuraciones\192.168.0.x.bat
					.\submenu8\direct\192.168.0.x.bat.lnk
					
					echo.
					ECHO ==============GRACIAS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======ESPERE A SER REEDIRIGIDO======
					timeout 3
					goto subMenu8
				
			


			:SubMenuOpc8_2
				cls
				IF EXIST .\submenu8\configuraciones\192.168.1.x.bat DEL .\submenu8\configuraciones\192.168.1.x.bat
				IF NOT EXIST TYPE nul > .\submenu8\configuraciones\192.168.1.x.bat
				
				set ip8_2=""
				set /P ip8_2="Elige un rango del 1 al 253 (si lo dejas en blanco será 253): 192.168.1."
				
				
				IF "%ip8_2%x" EQU "x" (goto subMenu8)
				IF "%ip8_2%" GTR "0" (goto diferente8_2)
				IF NOT "%ip8_2%x" == "x" (goto 253_8_2) ELSE (goto diferente8_2)
				
				
				echo.
				ECHO ==============NOP!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======ESCRIBE ALGO, PORFAVOR======
				timeout 3
				goto subMenu8
					
					:253_8_2
					echo netsh interface ipv4 set address %interfaceYou% static 192.168.1.253 255.255.255.0 192.168.1.1 >> .\submenu8\configuraciones\192.168.1.x.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 8.8.8.8 >> .\submenu8\configuraciones\192.168.1.x.bat
					.\submenu8\direct\192.168.1.x.bat.lnk
					
					echo.
					ECHO ==============GRACIAS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======ESPERE A SER REEDIRIGIDO======
					timeout 3
					goto subMenu8
					
					:diferente8_2
					echo netsh interface ipv4 set address %interfaceYou% static 192.168.1.%ip8_2% 255.255.255.0 192.168.1.1 >> .\submenu8\configuraciones\192.168.1.x.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 8.8.8.8 >> .\submenu8\configuraciones\192.168.1.x.bat
					.\submenu8\direct\192.168.1.x.bat.lnk
					
					echo.
					ECHO ==============GRACIAS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======ESPERE A SER REEDIRIGIDO======
					timeout 3
					goto subMenu8	

			:SubMenuOpc8_3
			rem Red Junta
				cls
				IF EXIST .\submenu8\configuraciones\redescuelas.bat DEL .\submenu8\configuraciones\redescuelas.bat
				IF NOT EXIST TYPE nul > .\submenu8\configuraciones\redescuelas.bat
				
				set ip8_3=""
				set mascara8_3=""
				set puerta8_3=""
				set /P ip8_3="Indícame la dirección IP: 10."
				set /P mascara8_3="Indícame la máscara: 255.255.255."
				set /P puerta8_3="Indícame la GW: 10."
				
				
				IF "%ip8_3%x" EQU "x" (goto subMenu8)
				IF "%mascara8_3%x" EQU "x" (goto subMenu8)
				IF "%puerta8_3%x" EQU "x" (goto subMenu8)
				
				IF "%ip8_3%,%mascara8_3%,%puerta8_3%" GTR "0" (goto avanzar8_3)
				
				
				echo.
				ECHO ==============NOP!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======ESCRIBE CORRECTAMENTE, PORFAVOR======
				timeout 3
				goto subMenu8
					
					:avanzar8_3
					echo netsh interface ipv4 set address %interfaceYou% static 10.%ip8_3% 255.255.255.%mascara8_3% 10.%puerta8_3% >> .\submenu8\configuraciones\redescuelas.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 10.151.126.17  >> .\submenu8\configuraciones\redescuelas.bat
					.\submenu8\direct\redescuelas.bat.lnk
					
					echo.
					ECHO ==============GRACIAS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======ESPERE A SER REEDIRIGIDO======
					timeout 3
					goto subMenu8


			:SubMenuOpc8_4
			rem DHCP
				cls
				IF EXIST .\submenu8\configuraciones\dhcp.bat DEL .\submenu8\configuraciones\dhcp.bat
				IF NOT EXIST TYPE nul > .\submenu8\configuraciones\dhcp.bat
				

				echo netsh interface ipv4 set address name=%interfaceYou% source=dhcp >> .\submenu8\configuraciones\dhcp.bat
				echo netsh interface ipv4 set dnsservers name=%interfaceYou% source=dhcp >> .\submenu8\configuraciones\dhcp.bat
				.\submenu8\direct\dhcp.bat.lnk
					
				echo.
				ECHO ==============GRACIAS!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======
				timeout 3
				goto subMenu8		

			:SubMenuOpc8_5
			rem ipconfig /all
				cls
				
				ipconfig/all
				ECHO.
				ECHO.
				ECHO.
				ECHO.
				ECHO ==============PRESIONE CULAQUIER TECLA PARA SALIR!===============				
				pause>nul
				
				echo.
				ECHO ==============GRACIAS!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======
				timeout 3
				goto subMenu8

			:SubMenuOpc8_6
			rem Elegir adaptador
				cls
				
				netsh interface ipv4 show interfaces
				set /P interfaceYou=Indícame el número de la izquierda del adptador de red que quieres usar:
				

				echo.
				ECHO ==============GRACIAS!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======ESPERE A SER REEDIRIGIDO======
				timeout 3
				goto subMenu8	

			:SubMenuOpc8_7
			rem Configuración Manual
				cls
				IF EXIST .\submenu8\configuraciones\confmanual.bat DEL .\submenu8\configuraciones\confmanual.bat
				IF NOT EXIST TYPE nul > .\submenu8\configuraciones\confmanual.bat
				
				set ip8_7=""
				set mascara8_7=""
				set puerta8_7=""
				set dns8_7=""
				set /P ip8_7="Indícame la dirección IP: "
				set /P mascara8_7="Indícame la máscara: "
				set /P puerta8_7="Indícame la GW: "
				set /P dns8_7="Indícame el DNS: "
				
				
				IF "%ip8_7%x" EQU "x" (goto subMenu8)
				IF "%mascara8_7%x" EQU "x" (goto subMenu8)
				IF "%puerta8_7%x" EQU "x" (goto subMenu8)
				
				IF "%ip8_7%,%mascara8_7%,%puerta8_7%" GTR "0" (goto avanzar8_7)
				
				
				echo.
				ECHO ==============NOP!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======ESCRIBE CORRECTAMENTE, PORFAVOR======
				timeout 3
				goto subMenu8
					
					:avanzar8_7
					echo netsh interface ipv4 set address %interfaceYou% static %ip8_7% %mascara8_7% %puerta8_7% >> .\submenu8\configuraciones\confmanual.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static %dns8_7%  >> .\submenu8\configuraciones\confmanual.bat
					.\submenu8\direct\confmanual.bat.lnk
					
					echo.
					ECHO ==============GRACIAS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======ESPERE A SER REEDIRIGIDO======
					timeout 3
					goto subMenu8			
			
			
			
			
			
			:SubMenuOpc8_8
			cls
			ECHO ==============GRACIAS!===============
			ECHO -------------------------------------
			ECHO -------------------------------------
			ECHO ======ESPERE A SER REEDIRIGIDO======
			timeout 0
			goto MENU0
		
		
		
		
		
		
		
		
		
		
:MenuOpc0_9
rem subMENÚ [9] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cls
ECHO Información sobre todos los submenús y opciones
ECHO.
ECHO.
ECHO.
ECHO.   [1;4m1.- Modificar y/o Revisar información del SW[0m.
ECHO.       [97m1.[0m- Nombre del SW.
ECHO			[96m1.[0m-Sirve para cambiar el nombre del SW (hostname)
ECHO.       [97m2.[0m- Dirección IP de una VLAN del SW.
ECHO			[96m2.[0m-Para cambiar la configuración de Red de una VLAN (IP y MÁSCARA)
ECHO.       [97m3.[0m- Localización del SW.
ECHO			[96m3.[0m-Para cambiar la localización que aparece en la descripción del SW (location)
ECHO.       [97m4.[0m- Información de contacto del SW.
ECHO			[96m4.[0m-Para cambiar la información de contacto del SW (contact-info)
ECHO.       [97m5.[0m- Devolver valores de fábrica al SW.
ECHO			[96m5.[0m-Para resetear el SW a la configuración de fábrica.
ECHO.       [97m6.[0m- USO de CPU y de MEMORIA.
ECHO			[96m6.[0m-Muestra información en porcentajes del uso del CPU y la MEMORIA RAM.
ECHO.       [97m7.[0m- Guardar la configuración actual.
ECHO			[96m7.[0m-Para guardar la configuración (SAVE)
ECHO.       [97m8.[0m- IP Servidor NTP.
ECHO			[96m8.[0m-Para cambiar la dirección IP del servidor principal de NTP (sincronizar reloj del SW con un srv)
ECHO.       [97m9.[0m- Static Routing
ECHO			[96m9.[0m-Configuración para definir la puerta de enlace para tramas que tengan un rango de destino y máscara configurado. (Enrutamiento Estático)
ECHO.       [97m10/Q.[0m- Volver.
ECHO			[96m10.[0m-Para volver al menú principal.
ECHO.   [1;4m2.- Configuración de VLANES[0m.
ECHO.     	[97m1.[0m- Crear/Editar VLAN.
ECHO			[96m1.[0m-Se pueden crear o editar la VLAN (ID,Nombre)
ECHO.     	[97m2.[0m- Agregar/Eliminar un puerto a VLAN.
ECHO			[96m2.[0m-Agregar puertos a una o varias vlanes a la vez.
ECHO.     	[97m3.[0m- Cargar plantilla genérica de VLANES para el SW.
ECHO			[96m3.[0m-Cargar un configuración (.cfg) genérica al SW.
ECHO.     	[97m4.[0m- Eliminar una VLAN.
ECHO			[96m4.[0m-Indicas el ID de la VLAN y la eliminar (no vlan)
ECHO.     	[97m5.[0m- Configurar PVID de un puerto.
ECHO			[96m5.[0m-Confiuras el PVID de un puerto.
ECHO.     	[97m6.[0m- Mostrar información de una VLAN.
ECHO			[96m6.[0m-Puedes mostar la información de una VLAN en concreto o con 'T' puedes mostrar las VLANES que más se utilizan. (1,2,3,4 y 6)
ECHO.     	[97m7.[0m- Resumen de VLANes.
ECHO			[96m7.[0m-Te da un resumen muy básico de cuántas VLANES tienes.
ECHO.     	[97m8/Q.[0m- Escribe "Q" para volver.
ECHO			[96m9.[0m-Para volver al menú principal.
ECHO.   [1;4m3.- Entrar en el CLI del SW[0m.
ECHO			[96m1.[0m-Sirve para entrar en el CLI del SW (consola)
ECHO.   [1;4m4.- Activar o Desactivar diferentes tecnologías [RSTP/FTP.SSH..][0m.
ECHO.     	[97m1.[0m- Activar o Desactivar Spanning Tree.
ECHO			[96m1.[0m-Sirve para gestionar los bucles en red que se puedan ocasioner.
ECHO.     	[97m2.[0m- Activar o Desactivar LoopBack Detection.
ECHO.     		[96m2.[0m- Permite detectar bucles por puertos específicos y bloquearlos (los puertos) para evitar los bucles.
ECHO.     	[97m4.[0m- ---------------------------------------------------------
ECHO.     	[97m5.[0m- ---------------------------------------------------------
ECHO.     	[97m6/Q.[0m- Escribe "Q" para volver.
ECHO			[96m6.[0m-Para volver al menú principal.
ECHO.   [1;4m5.- Modificar puertos [LOOPBACK.JUMBO..][0m.
ECHO.     	[97m1.[0m- Elegir puerto para Activat/Desactivar LoopBack.
ECHO			[96m1.[0m-Sirve para habilitar loopback un puertos determinado (en modo auto y port-based)
ECHO.     	[97m2.[0m- Elegir tamaño de la trama Jumbo y habilitarlo.
ECHO			[96m1.[0m-Sirve para habilitar y cambiar el tamaño de la trama Jumbo.
ECHO.     	[97m4.[0m- ---------------------------------------------------------
ECHO.     	[97m5.[0m- ---------------------------------------------------------
ECHO.     	[97m6/Q.[0m- Escribe "Q" para volver.
ECHO			[96m6.[0m-Para volver al menú principal.
ECHO.   [1;4m6.- Configuración Secuencial Completa[0m.
ECHO			[96m1.[0m-Con esta opción se pueden pasar todos los datos de configuración directamente, en vez de ir de opción en opción, se hace todo secuencial.
ECHO.   [1;4m7.- Configurar puerto de conexión por serial[0m.
ECHO			[96m1.[0m-Indicas un puerto, el 1, 2,3,4,5,6 o el que sea y lo pones y se modifica en la variable que utiliza para conectarse el SW por Serial.
ECHO.   [1;4m8.- Configuraciones IP[0m.
ECHO			[96m1.[0m-Para que puedas ver tu configuración IP y para que puedas editarla..
ECHO.   [1;4m9.- Ayuda[0m.
ECHO			[96m1.[0m-Información sobre todas las opciones y explicación.
ECHO.   [1;4m10/Q.- Salir del menú[0m.
ECHO.
ECHO.
ECHO.
ECHO ==============PRESIONE CULAQUIER TECLA PARA SALIR!===============
pause>nul

goto MENU0
:MenuOpc0_10
rem subMENÚ [10] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
rem Bandera de castilla
rem Del menú principal
cls
	ECHO ==============GRACIAS!===============
echo [101;93m     Q     [0m[107;35m     o      [0m
echo [101;93m    I I    [0m[107;35m   --I      [0m
echo [101;93m    I_I    [0m[107;35m    --      [0m
echo [107;35m     o     [0m[101;93m     Q      [0m
echo [107;35m   --I     [0m[101;93m    I I     [0m
echo [107;35m    --     [0m[101;93m    I_I     [0m
echo @Yaw on StackOverflow

	ECHO -------------------------------------
	ECHO ======ESPERE A SER REEDIRIGIDO======
	timeout 3
	exit