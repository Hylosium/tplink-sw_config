                   
:: -----------------TAREAS--->>>>>>-----------------
:: 1. Clean code.
:: 2. Clean translation from spanish to english, used Microsoft Translator.
:: -------------------------------------------------
@echo off
rem used to disable the echoing
::----------
setlocal EnableExtensions-
:: No idea, I just know it does magic
::----------
chcp 437
rem Supporte code page for United States.
SET mypath=%~dp0
ECHO %mypath:~0,-1%
rem With this we put the execution path from where the '.bat' is executed
title CONFIGURAITON MENU OF SWITCH 'TLXXXX-XXTS v2.0' BY USB/SERIAL v0.090 @Hylosium
rem Title that appears above in the CMD window.
rem ===============================
rem -------------------------------
rem subMenu 1
copy /Y .\submenu1\contc_info\contact-org.txt .\submenu1\contc_info\contact.txt
copy /Y .\submenu1\hostname\hostname-org.txt .\submenu1\hostname\hostname.txt
copy /Y .\submenu1\location\location-org.txt .\submenu1\location\location.txt
copy /Y .\submenu1\ntp\ip-srv-ntp-org.txt .\submenu1\ntp\ip-srv-ntp.txt
copy /Y .\submenu1\iproute\ip-route-org.txt .\submenu1\iproute\ip-route.txt
rem subMenu 2
copy /Y .\submenu2\dir_IP\dirIP-org.txt .\submenu2\dir_IP\dirIP.txt
copy /Y .\submenu2\edit_vlan\edit_n_vlan-org.txt .\submenu2\edit_vlan\edit_n_vlan.txt
copy /Y .\submenu2\edit_vlan\sup_edit_n_vlan-org.txt .\submenu2\edit_vlan\sup_edit_n_vlan.txt
copy /Y .\submenu2\port\add_port_to_vlan-org.txt .\submenu2\port\add_port_to_vlan.txt
copy /Y .\submenu2\port\change_pvid_port-org.txt .\submenu2\port\change_pvid_port.txt
copy /Y .\submenu2\port\sup_port_to_vlan-org.txt .\submenu2\port\sup_port_to_vlan.txt
copy /Y .\submenu2\vlanes\info-id\info-id-vlan-org.txt .\submenu2\vlanes\info-id\info-id-vlan.txt
rem -------------------------------
rem ===============================
rem The above is used to clean the settings, so every time you run the menu they will be by default, so if something does not work for you as you wanted, just reopen the menu it would already be by default.
rem -------------------------------
rem Working great with V1.0 and v2.0 of the SW TP-LINK :)
rem V4 (which is older than v2) I don't know if it will work
cls

chgport | findstr "COM"
echo.
set /P pCOM=Tell me the COM port through which the SW connects:
echo Your chosen port has been the COM%pCOM%
set bRate=38400
set /P bRate=Tell me the Baud Rate for the SW (if you leave it empty it will have'%bRate%'):
echo You have chosen %bRate% for Baud Rate.
set dBits=8
set /P dBits=Tell me the data Bits (if you leave it empty it will have '8'):
echo You have chosen %dBits% of Data Bits.
set pArity=n
set /P pArity=Tell me the 'Parity' (if you leave it empty it will be 'n'):
echo You have chosen %pArity% of Parity.
set sBits=1
set /P sBits=Tell me the 'Stop Bits' (if you leave it empty it will be '1'):
echo You have chosen %sBits% of Stop Bits.
cls
netsh interface ipv4 show interfaces
set /P interfaceYou=Tell me the number on the left of the network adapter you want to use:
:: So you can choose several parameters to connect to any SW TP-LINK(v1, v2 and v4) from any PC with any Network dadapter.



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
	rem I clean everything there was up to this line.
	ECHO.    
    ECHO.     Options Menu
    ECHO.     
    ECHO.     1.- Modify and/or Review SW information.
    ECHO.     2.- VLANES configuration.
	ECHO.    [93m 3.- Enter the SW CLI. [0m
    ECHO.     4.- Enable or Disable different technologies [RSTP/FTP.SSH.LOOPBACK.].
    ECHO.     5.- Modify [LOOPBACK. JUMBO..].
    ECHO.     6.- Complete [1;101;93m Sequential Configuration[0m.
    ECHO.     7.- Configure CONNECTION port.
    ECHO.     8.- IP Configurations
    ECHO.     9.- Help.
    ECHO.     10/Q.- Exit.
	ECHO.
	ECHO.
	::IF "%IPv4%"   ==  "%IPv4%"  ECHO. [102m √ [0m The page works greatly, no needs to reload.
	::IF "%IPv4%x"   ==  "x"  ECHO. [7;31m X [0m The page hasen't charge correctñy, please, reload.	   	  
	echo.     ___________________________________
	echo.     ^|                                  
	Echo.     ^|[1mCOM%pCOM%[0m [Serial Port]
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
	echo.	This don't always get the correct parameters
	:: This works by getting the parameters form "netsh" command, does not work great ever.
	ECHO.
	set MenuOpc0=""
    set /P MenuOpc0=Your Choice is:
	rem A value, from 1 to 10 or Q is expected to save in a variable and compare with the IF's below and take you elsewhere to continue.
	
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
ECHO ============INCORRECT ENTRY============
ECHO -------------------------------------
ECHO Please choose a number from the menu
ECHO Menu [1-9] or choose '10 or Q' to exit.
ECHO -------------------------------------	
ECHO ======WAIT TO BE REDIRECTED...======
timeout 4

	goto MENU0
	rem If a number between 1 and 10 or Q has not been entered, it will return to the beginning of the menu, i.e. 'restart' it
	
	
goto MENU0	
:MenuOpc0_1
rem subMENÚ [1] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		:subMenu1
			
		cls
		ECHO. Modify and/or Revise SW Information - SUBMENU 1
		ECHO.     
		ECHO.     
		ECHO.     1.- SW Name
		ECHO.     2.- Location of the SW.
		ECHO.     3.- SW contact information.
		ECHO.    [1m 4.- Return factory values to SW. [0m
		ECHO.     5.- CPU and MEMORY USAGE.
		ECHO.    [93m 6.- Save the current settings. [0m
		ECHO.     7.- IP NTP Server.
		ECHO.     8.- Configure Static Routing
		ECHO.     9/Q.- Return.
		set SubMenuOpc1=""
		set /P SubMenuOpc1=Your Choice is:
		
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
		ECHO ============INCORRECT ENTRY============
		ECHO -------------------------------------
		ECHO Please choose a number from the menu
		ECHO Menu [1-9] or choose '10 or Q' to exit.
		ECHO -------------------------------------	
		ECHO ======WAIT TO BE REDIRECTED...======	
		timeout 4
		goto subMenu1

		:SubMenuOpc1_1
		cls
		ECHO Option - 1
		rem To choose if you want to modify the 'hostname' name of the SW.
		set verificar1_1=""
		set /P verificar1_1=Choose '1' to rename, '2' to cancel or 'Q' to exit:
		rem It asks you what you want to do and according to what you write it will save it in a variable that its value will check with a few 'IF' and will take you to another part where it will execute X or Y thing.
		
		IF "%verificar1_1%x"=="x" (goto SubMenuOpc1_1)
		IF "%verificar1_1%"=="Q" (goto subMenu1)
		IF "%verificar1_1%"=="q" (goto subMenu1)
		IF "%verificar1_1%"=="1" (goto subMenu1_1_SI)
		IF "%verificar1_1%"=="1" (goto subMenu1_1_SI)
		IF "%verificar1_1%"=="2" (goto subMenu1_1_NO)
		IF "%verificar1_1%"=="2" (goto subMenu1_1_NO)
		
		cls
		ECHO ============INCORRECT ENTRY============
		ECHO Please, choose '1' or '2' or 'Q'
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======		
		timeout 3
		goto subMenu1
		
			:subMenu1_1_SI
			cls
				set /P cambiar_nombre1_1=Type here the name you want "without tildes or rare characters":
				rem He asks you what name you want to give it, you write it and save it in the variable 'cambiar_nombre1_1'
				powershell -Command "(gc .\submenu1\hostname\hostname.txt) -replace '"hostname .*"', '"hostname %cambiar_nombre1_1%"' | Out-File -encoding ASCII .\submenu1\hostname\hostname.txt"
				rem Powershell function that is used in CMD, replaces what is in the text file '.txt' that we will send to the SW by Serial.
				echo The new name for your SW will be %cambiar_nombre1_1%
				rem It shows you which name you have chosen.
				plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\hostname\hostname.txt"
				
				timeout 3
				rem The 'pause' is used so that everything does not go away at once and you can read it.
				goto subMenu1
			:subMenu1_1_NO
			cls
				rem Not done...
				echo Understood ;)
				timeout 3
				goto subMenu1
			

		

		
		:SubMenuOpc1_2
		cls
		rem Change the location of the SW.
		ECHO Option - 2
		set /P elegir_sitio1_2=Write where this SW is going to be::
		powershell -Command "(gc .\submenu1\location\location.txt) -replace '"location .*"', '"location %elegir_sitio1_2%"' | Out-File -encoding ASCII .\submenu1\location\location.txt"
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\location\location.txt"
		timeout 3
		goto subMenu1
		
		:SubMenuOpc1_3
		cls
		rem Change the contact information for the SW.
		ECHO Option - 3
		set /P elegir_contc1_3=Escríbeme qué que quieres de información de contacto:
		powershell -Command "(gc .\submenu1\contc_info\contact.txt) -replace '"contact-info .*"', '"contact-info %elegir_contc1_3%"' | Out-File -encoding ASCII .\submenu1\contc_info\contact.txt"
		echo Your new contact details will be %elegir_contc1_3%
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\contc_info\contact.txt"
		timeout 3
		goto subMenu1
		
		:SubMenuOpc1_4
		cls
		rem To return the factory values to the SW.
		ECHO Option - 4
		set verificar1_4=""
		set /P verificar1_4= You are going to return to the SW the factory parameters it had, write "1" to confirm or "2" to cancel.
		IF "%verificar1_4%"=="2" (goto No1_4)
		IF "%verificar1_4%"=="2" (goto No1_4)
		IF "%verificar1_4%"=="1" (goto Si1_4)
		IF "%verificar1_4%"=="1" (goto Si1_4)
		IF "%verificar1_4%x"=="x" (goto SubMenuOpc1_4)
		
		cls
		ECHO ============INCORRECT ENTRY============
		ECHO Please, choose '1' or '2'
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======	
		timeout 3
		goto subMenu1
			:No1_4
			cls
			ECHO Undestood :)
			timeout 3
			goto subMenu1
			:Si1_4
			cls
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\reset\script_reset(factory).txt"
			timeout 3
			goto subMenu1
		
		:SubMenuOpc1_5
		cls
		rem Show '%' usage of CPU and MEM used.
		ECHO Option - 5
		
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
		rem Save the congifuración (Save)
		ECHO Option - 6
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\save\save.txt"
		timeout 3
		goto subMenu1
		:SubMenuOpc1_7
		cls
		rem Change NTP IP Server
		ECHO Option - 7

		set /P elegir_ip-ntp_2_7=Write me the IP of the NTP server:
		powershell -Command "(gc .\submenu1\ntp\ip-srv-ntp.txt) -replace '":00 .*"', '":00 %elegir_ip-ntp_2_7% %elegir_ip-ntp_2_7% 12"' | Out-File -encoding ASCII .\submenu1\ntp\ip-srv-ntp.txt"
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\ntp\ip-srv-ntp.txt"

		timeout 3
		goto subMenu1
		
		
		:SubMenuOpc1_8
		cls
		rem Change Static Routing
		ECHO Option - 8 
		
		set /P destino1_8=Enter the destination IP address:
		set /P subnet1_8=Type the netmask:
		set /P gateway1_8=Type the address for the next hop:
		set /P distance1_8=Type the distance in metric unit (from 1 to 256):
		
		powershell -Command "(gc .\submenu1\iproute\ip-route.txt) -replace '"route .*"', '"route %destino1_8% %subnet1_8% %gateway1_8% %distance1_8%"' | Out-File -encoding ASCII .\submenu1\iproute\ip-route.txt"
		plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu1\iproute\ip-route.txt"


		timeout 3
		goto subMenu1
		
		:SubMenuOpc1_9
		cls
		rem To return to the main menu.
		ECHO ==============THANK YOU!===============
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======
		timeout 0
		goto MENU0


:MenuOpc0_2
rem subMENÚ [2] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		:subMenu2
			
		cls
		ECHO. VLANES Configuration - SUBMENU 2
		ECHO.     
		ECHO.     
		ECHO.     1.- Create/Edit VLANs.
		ECHO.     2.- Add/Remove Ports to VLANs.
		ECHO.     3.- IP address of a SW VLAN.
		ECHO.     4.- Load generic VLANES template for sw.
		ECHO.     5.- Delete a VLAN.
		ECHO.     6.- Configure single-port PVID.
		ECHO.     7.- Display information from a VLAN. 
		ECHO.     8.- Summary of VLANes.
		ECHO.     9/Q.- Type "Q" to go back.
		set SubMenuOpc2=""
		set /P SubMenuOpc2=Your Choice is:
		
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
		ECHO ============INCORRECT ENTRY============
		ECHO -------------------------------------
		ECHO Please choose a number from the menu
		ECHO Menu [1-8] or choose '9 or Q' to exit.
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======		
		timeout 4
		goto subMenu2

			:SubMenuOpc2_1
			cls
			rem To create or edit the VLAN and define a name for it.
			ECHO Option - 1

			set /P elegir_vlan2_1=Write me the number of the VLAN you want to create or edit:
			powershell -Command "(gc .\submenu2\edit_vlan\edit_n_vlan.txt) -replace '"vlan .*"', '"vlan %elegir_vlan2_1%"' | Out-File -encoding ASCII .\submenu2\edit_vlan\edit_n_vlan.txt"
			set /P elegir_n2_1=Write me the name you want to give the VLAN %elegir_vlan1_2%:
			powershell -Command "(gc .\submenu2\edit_vlan\edit_n_vlan.txt) -replace '"name .*"', '"name %elegir_n2_1%"' | Out-File -encoding ASCII .\submenu2\edit_vlan\edit_n_vlan.txt"
			echo Edit/Create the VLAN %elegir_vlan2_1% y le darás el nombre de %elegir_n2_1%.
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\edit_vlan\edit_n_vlan.txt"
			timeout 3
			goto subMenu2
			
			:SubMenuOpc2_2
			cls
			rem Add a port or remove it from a VLAN.
			ECHO Option - 2
			set elegir_opc_2_2=""
			set /P elegir_opc_2_2=Type '1' to define VLANs on a port or '2' to remove VLANs from a port:
			IF "%elegir_opc_2_2%"== "1" (goto Opc_ElegirV_add_2_2)
			IF "%elegir_opc_2_2%"== "2" (goto Opc_ElegirV_delete_2_2)
			IF "%elegir_opc_2_2%x"== "x" (goto SubMenuOpc2_2)
			
			
			cls
			ECHO ============INCORRECT ENTRY============
			ECHO -------------------------------------
			ECHO Please type correctly...
			ECHO -------------------------------------
			ECHO ======WAIT TO BE REDIRECTED======
			timeout 3
			goto subMenu2
			
				:Opc_ElegirV_add_2_2
				cls
				set elegir_V_2_2=""
				set /P elegir_V_2_2=type '1' if it is the sw v1.0 version or type '2' if the sw version is v2.0
				IF "%elegir_V_2_2%"== "1" (goto Opc_2_2_add_1_v1-new)
				IF "%elegir_V_2_2%"== "2" (goto Opc_2_2_add_1_v2-new)
				IF "%elegir_V_2_2%x"== "x"  (goto Opc_ElegirV_add_2_2)
				
				cls
				ECHO ============INCORRECT ENTRY============
				ECHO -------------------------------------
				ECHO Please type correctly...
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======				
				timeout 3
				goto subMenu2
				
				:Opc_ElegirV_delete_2_2
				cls
				set elegir_V_2_2-sup=""
				set /P elegir_V_2_2-sup=Type '1' if it is the sw v1.0 version or type '2' if the SW version is v2.0:
				rem As I can't test this with a SW v1.0 I'm going to use the same command for both versions to see if it works properly.
				IF "%elegir_V_2_2-sup%"== "1" (goto Opc_2_2_sup_2_v1)
				IF "%elegir_V_2_2-sup%"== "2" (goto Opc_2_2_sup_2)
				IF "%elegir_V_2_2-sup%x"== "x"  (goto Opc_ElegirV_delete_2_2)
				
				cls
				ECHO ============INCORRECT ENTRY============
				ECHO -------------------------------------
				ECHO Please type correctly...
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======				
				timeout 3
				goto subMenu2
				
				
				
				:Opc_2_2_add_1_v1-new
				rem If the file exists, delete
				IF EXIST .\submenu2\port\2_NEW_add_port_to_vlan.txt DEL .\submenu2\port\2_NEW_add_port_to_vlan.txt
				rem If the file does not exist, create it
				IF NOT EXIST TYPE nul > .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo Code to add VLANES to certain ports.
				
				set /P elegir_puerto2_2=Write from which port you want to start:
				set /P elegir_puerto2_2-2=Write from which port you want to finish:
				set /P elegir_vlan2_2=Write me the number(s) of the VLANES to which you want it to belong to the ports %elegir_puerto2_2% to the %elegir_puerto2_2-2%, (p.e: 2,4-6):

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
					
				set /P elegir_modo2_2=Tell me in with the 1,2 or 3 with which mode you want the ports of the %elegir_puerto2_2% to the %elegir_puerto2_2-2% , access[1], trunk[2] o general[3]:
				IF "%elegir_modo2_2%"== "1" (goto vlan-cong_2_2_acces)
				IF "%elegir_modo2_2%"== "2" (goto vlan-cong_2_2_trunk)
				IF "%elegir_modo2_2%"== "3" (goto vlan-cong_2_2_general)
				
				cls
				ECHO ============INCORRECT ENTRY============
				ECHO -------------------------------------
				ECHO Please type correctly...
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======				
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
				set /P verificar2_2=[1m Type "1" to tag the port,"2" to leave it as an untagged: [0m
				IF "%verificar2_2%"== "1" (goto Si_2_2)
				IF "%verificar2_2%"== "2" (goto No_2_2)
				IF "%verificar2_2%x"== "x"  (goto Opc_2_2_add_1_v1-new)
				
				cls
				ECHO ============INCORRECT ENTRY============
				ECHO -------------------------------------
				ECHO Please type correctly...
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======				
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
				ECHO ============INCORRECT ENTRY============
				ECHO -------------------------------------
				ECHO Please type correctly...
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======				
				timeout 3
				goto subMenu2

rem -------------------------------------VERSION_CHANGE-------------------

				:Opc_2_2_add_1_v2-new
				rem If the file exists, delete
				IF EXIST .\submenu2\port\2_NEW_add_port_to_vlan.txt DEL .\submenu2\port\2_NEW_add_port_to_vlan.txt
				rem If the file does not exist, create it 
				IF NOT EXIST TYPE nul > .\submenu2\port\2_NEW_add_port_to_vlan.txt
				echo Code to add VLANES to certain ports.
				
				set /P elegir_puerto2_2=Write from which port you want to start:
				set /P elegir_puerto2_2-2=Write from which port you want to finish:
				set /P elegir_vlan2_2=Write me the number(s) of the VLANES to which you want it to belong to the ports %elegir_puerto2_2% to the %elegir_puerto2_2-2%, (p.e: 2,4-6):

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
				set /P verificar2_2=[1m Type "1" to tag the port,"2" to leave it as an untagged: [0m
				IF "%verificar2_2%"== "1" (goto Si_2_2)
				IF "%verificar2_2%"== "2" (goto No_2_2)
				IF "%verificar2_2%x"== "x"  (goto Opc_2_2_add_1_v2-new)
				
				cls
				ECHO ============INCORRECT ENTRY============
				ECHO -------------------------------------
				ECHO Please type correctly...
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======				
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
				ECHO ============INCORRECT ENTRY============
				ECHO -------------------------------------
				ECHO Please type correctly...
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======				
				timeout 3
				goto subMenu2

				
				:Opc_2_2_sup_2
				cls
				rem To delete ports from a VLAN.
				IF EXIST .\submenu2\port\sup_port_to_vlan.txt DEL .\submenu2\port\sup_port_to_vlan.txt
				rem If the file does not exist, create it 
				IF NOT EXIST TYPE nul > .\submenu2\port\sup_port_to_vlan.txt
				
				set /P elegir_puerto2_2_sup=Write me the number of the port you want to start from:
				set /P elegir_puerto2_2_sup-2=Write me the number of the port from which you want to terminate:
				set /P elegir_vlan2_2_sup=Write me the number(s) of the VLANES you want removed from the port %elegir_puerto2_2_sup% to the %elegir_puerto2_2_sup-2% , (p.e: 2,4-6):
				
				
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
				rem What I'm not sure is if this would work with version v1.0 of a SW tp-link, we would have to try it...
				cls
				rem To delete ports from a VLAN.
				IF EXIST .\submenu2\port\sup_port_to_vlan.txt DEL .\submenu2\port\sup_port_to_vlan.txt
				rem If the file does not exist, create it
				IF NOT EXIST TYPE nul > .\submenu2\port\sup_port_to_vlan.txt
				
				set /P elegir_puerto2_2_sup=Write me the number of the port you want to start from:
				set /P elegir_puerto2_2_sup-2=Write me the number of the port from which you want to terminate:
				set /P elegir_vlan2_2_sup=Write me the number(s) of the VLANES you want removed from the port %elegir_puerto2_2_sup% to the %elegir_puerto2_2_sup-2% , (p.e: 2,4-6):
				
				
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
			ECHO Option - 3 (Change the network interface of a VLAN)
			rem To change the IP address of the network interface of a VLAN.

			set /P elegir_vlan2_3=Write me the VLAN of which you want to modify the IP address:
			rem To save the value of a number to a variable
			powershell -Command "(gc .\submenu2\dir_IP\dirIP.txt) -replace '"interface vlan .*"', '"interface vlan %elegir_vlan2_3%"' | Out-File -encoding ASCII .\submenu2\dir_IP\dirIP.txt"
			rem With the value of the variable and using PowerShell, the value is replaced in a '.txt' file that will then be passed the SW through Serial.
			set /P elegir_ip2_3=Write me the IP address you want to the VLAN %elegir_vlan2_3%:
			rem It takes the value of the IP address you enter and saves it in the variable 'elegir_ip2_3'
			set /P elegir_mascara2_3=Write me the netmask you want to give the VLAN %elegir_vlan2_3%:
			rem It takes the value of the network mask you enter and saves it in the variable 'elegir_ip2_3'
			powershell -Command "(gc .\submenu2\dir_IP\dirIP.txt) -replace '"ip address .*"', '"ip address %elegir_ip2_3% %elegir_mascara2_3%"' | Out-File -encoding ASCII .\submenu2\dir_IP\dirIP.txt"
			set /P elegir_nombre2_3=Write me the name you want to give the VLAN %elegir_vlan2_3%:
			powershell -Command "(gc .\submenu2\dir_IP\dirIP.txt) -replace '"description .*"', '"description %elegir_nombre2_3%"' | Out-File -encoding ASCII .\submenu2\dir_IP\dirIP.txt"
			
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\dir_IP\dirIP.txt"
			echo The configuration has been %elegir_ip2_3% with %elegir_mascara2_3% and %elegir_nombre2_3% to the  VLAN %elegir_vlan2_3%
			timeout 3
			goto subMenu1
				

			:SubMenuOpc2_4
			rem Load a generic VLAN configuration.
			cls
			ECHO Option - 4
			
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\generic_vlanes\script_vlan.txt"
			
			timeout 3
			goto subMenu2
			
			:SubMenuOpc2_5
			rem To delete a VLAN.
			cls
			ECHO Option - 5
			
			set /P elegir_vlan2_5=Write me the number of the VLAN you want to delete:
			powershell -Command "(gc .\submenu2\edit_vlan\sup_edit_n_vlan.txt) -replace '"vlan .*"', '"vlan %elegir_vlan2_5%"' | Out-File -encoding ASCII .\submenu2\edit_vlan\sup_edit_n_vlan.txt"
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\edit_vlan\sup_edit_n_vlan.txt"

			
			timeout 5
			goto subMenu2
			
			:SubMenuOpc2_6
			rem Connfigure the PVID of a port.
			cls
			ECHO Option - 6 (Change PVID from a port)
			
			set /P elegir_port_2_6=Enter the port from where you want to start:
			set /P elegir_port_2_6_2=Type the port from where you want to end:
			set /P elegir_pvid_2_6=Type the port from where you want to end: %elegir_port_2_6% up to %elegir_port_2_6_2%:
			
				IF EXIST .\submenu2\port\change_pvid_port.txt DEL .\submenu2\port\change_pvid_port.txt
				rem If the file does not exist, create it
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
			rem Display the information for a VLAN.
			cls
			ECHO Opción - 7 (Display information from a VLAN)
			set vlan_id_2_7=""
			set /P vlan_id_2_7=Type the VLAN ID or 'T' to display all:
			
			IF "%vlan_id_2_7%"== "t" (goto vlanTodo2_7)
			IF "%vlan_id_2_7%"== "T" (goto vlanTodo2_7)
			IF "%vlan_id_2_7%x"== "x" (goto subMenu2) else (goto vlan2_7)
			
			echo.
			ECHO ==============NOP!===============
			ECHO -------------------------------------
			ECHO -------------------------------------
			ECHO ======WRITE CORRECTLY, PLEASE======
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
			rem VLANES Overview
			cls
			ECHO Option - 8 (VLANES Overview)
			plink -serial COM%pCOM% -sercfg %bRate%,%dBits%,%pArity%,%sBits% < ".\submenu2\vlanes\summary\summary.txt"
			
			
			
			
			timeout 3
			goto subMenu2
			
			:SubMenuOpc2_9
			rem Go back to the main menu, from where you are, which is submenu 2.
			cls
			ECHO ==============THANK YOU!===============
			ECHO -------------------------------------
			ECHO -------------------------------------
			ECHO ======WAIT TO BE REDIRECTED======
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
		ECHO. Modify ports - SUBMENU 4.	
		ECHO.     
		ECHO.     
		ECHO.     1.- Enable or Disable Spanning Tree.
		ECHO.     2.- Enable or Disable LoopBack Detection.
		ECHO.     3.- Activate or Descativar SSH.
		ECHO.     4.- ---------------------------------------------------------
		ECHO.     5.- ---------------------------------------------------------
		ECHO.     6/Q.- Type "Q" to go back.
		set SubMenuOpc4=""
		set /P SubMenuOpc4=Your Choice is:
		
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
		ECHO ============INCORRECT ENTRY============
		ECHO -------------------------------------
		ECHO Please choose a number from the menu
		ECHO Menu [1-5] or choose '6 or Q' to exit.
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======	
		timeout 4
		goto MENU0

		:SubMenuOpc4_1
		cls
		ECHO Option - 1 (Enable or Disable Spanning Tree)
		set elegir4_1=""
		set /P elegir4_1=Type "1" to activate Spanning Tree, "2" to deactivate it or "Q" to return to the previous menu:
		IF "%elegir4_1%"=="1" (goto activar4_1)
		IF "%elegir4_1%"=="2" (goto desactivar4_1)
		IF "%elegir4_1%"=="1" (goto activar4_1)
		IF "%elegir4_1%"=="2" (goto desactivar4_1)
		IF "%elegir4_1%"=="Q" (goto subMenu4)
		IF "%elegir4_1%"=="q" (goto subMenu4)
		IF "%elegir4_1%x"=="x" (goto SubMenuOpc4_1)
		
		cls
		ECHO ============INCORRECT ENTRY============
		ECHO Please type '1', '2' or 'Q'
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======
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
		ECHO Option - 2 (Enable or Disable LoopBack Detection)
		set elegir4_2=""
		set /P elegir4_2=Type "1" to enable LoopBack-Detection, "2" to disable it, or "Q" to return to the previous menu:
		IF "%elegir4_2%"=="1" (goto activar4_2)
		IF "%elegir4_2%"=="N2 (goto desactivar4_2)
		IF "%elegir4_2%"=="1" (goto activar4_2)
		IF "%elegir4_2%"=="2" (goto desactivar4_2)
		IF "%elegir4_2%"=="Q" (goto subMenu4)
		IF "%elegir4_2%"=="q" (goto subMenu4)
		IF "%elegir4_2%x"=="x"  (goto SubMenuOpc4_2)
			
		cls
		ECHO ============INCORRECT ENTRY============
		ECHO Please type '1', '2' or 'Q'
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======
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
		ECHO Option - 3 (Enable or Descativar SSH)
		set verificar4_3=""
		set /P verificar4_3=Tell me with a '1' if you want to enable SSH for sw or '2' if you want to disable it:
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
		ECHO ============INCORRECT ENTRY============
		ECHO Please type '1', '2'
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======
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
		ECHO ==============THANK YOU!===============
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======

		timeout 0
		goto MENU0	


:MenuOpc0_5
rem subMENÚ [5] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		:subMenu5
		rem Submenú 5
			
		cls
		ECHO. Modify Ports - SUBMENU 5.	
		ECHO.     
		ECHO.     
		ECHO.     1.- Choose ports to Enable/Disable LoopBack.
		ECHO.     2.- Choose JUMBO frame size.
		ECHO.     3.- ---------------------------------------------------------
		ECHO.     4.- ---------------------------------------------------------
		ECHO.     5.- ---------------------------------------------------------
		ECHO.     6/Q.- Type "Q" to go back.
		set SubMenuOpc5=""
		set /P SubMenuOpc5=Your Choice is:
		
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
		ECHO ============INCORRECT ENTRY============
		ECHO -------------------------------------
		ECHO Please choose a number from the menu
		ECHO Menu [1-5] or choose '6 or Q' to exit.
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======	
		timeout 4
		goto MENU0

			:SubMenuOpc5_1
			cls
			ECHO Option - 1 (Enable or Disable LoopBack on ports)
			set verificar5_1=""
			set /P numPuerto5_1=Write me the port from where you want to start:
			set /P numPuerto5_1_2=Write me the port where you want to end:
			set /P verificar5_1=Choose 1 to enable or 2 to disable on the ports of the %numPuerto5_1% up to %numPuerto5_1_2%:
			
			IF "%verificar5_1%"=="2" (goto desactivar5_1)
			IF "%verificar5_1%"=="1" (goto continuar5_1)
			IF "%verificar5_1%"=="2" (goto desactivar5_1)
			IF "%verificar5_1%"=="1" (goto continuar5_1)
			IF "%verificar5_1%x"=="x"  (goto SubMenuOpc5_1)
			
			cls
			ECHO ============INCORRECT ENTRY============
			ECHO Please type '1' or '2'
			ECHO -------------------------------------
			ECHO ======WAIT TO BE REDIRECTED======	
			timeout 3
			goto subMenu5
			
				:continuar5_1
					IF EXIST .\submenu5\LoopBack\Puertos\on.txt DEL .\submenu5\LoopBack\Puertos\on.txt
					rem If the file exists, it is deleted, if it does not exist a blank txt file is created.
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
					rem If the file exists, it is deleted, if it does not exist a blank txt file is created.
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
			ECHO Option - 2 (Resize JUMBO frame)
			
			set /P jumbo5_2=Tell me the size of the jumbo plot (from 1518 to 9216 bytes):
			IF EXIST .\submenu5\jumbo\jumbo.txt DEL .\submenu5\jumbo\jumbo.txt
			rem If the file does not exist, create it
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
			ECHO Option - 3
			
			rem For future.
			
			timeout 3
			goto subMenu5
			
			:SubMenuOpc5_4
			cls
			ECHO Opción - 4
			
			
			rem For future.
			
			
			timeout 3
			goto subMenu5
			
			:SubMenuOpc5_5
			cls
			ECHO Opción - 5
			rem For future.
			
			
			
			
			timeout 3
			goto subMenu5
		
			:SubMenuOpc5_6
			cls
			ECHO ==============THANKS!===============
			ECHO -------------------------------------
			ECHO -------------------------------------
			ECHO ======WAIT TO BE REDIRECTED======
			timeout 0
			goto MENU0			

:MenuOpc0_6
	IF EXIST .\submenu6\ultimate\ultimate.txt DEL .\submenu6\ultimate\ultimate.txt
	IF NOT EXIST TYPE nul > .\submenu6\ultimate\ultimate.txt

	echo Are you ready for the best tool ever?
	echo !! Press any key to continue!
	pause>nul
	
	
	
	set /P nombre6=Tell me the name for the SW:
	set /P location6=Tell me the location of the SW:
	set /P conct_info6=Tell me the contact information:
	
	set /P GTWdir6=Tell me the ADMINISTRATION gatewayN:
	
	set /P jumbo6=Tell me the size of the jumbo plot (from 1518 to 9216 bytes):
	rem Let's say VLAN2 it's for ADMINISTATION, VLAN3 for MODERATORS, VLAN4 FOR USERS and VLAN6 FOR PRINTERS, ESCANERS...
	set /P portVlan2_1_6=Tell me which port you want VLAN 2 to start from:
	set /P portVlan2_2_6=Tell me which port you want VLAN 2 to end from [97m(if you have no other ports to put, put the previous one and you're done)[0m:
	set /P portVlan3_1_6=Tell me which port you want VLAN 3 to start from:
	set /P portVlan3_2_6=Tell me which port you want VLAN 3 to end from [97m(if you have no other ports to put, put the previous one and you're done)[0m:
	set /P portVlan4_1_6=Tell me which port you want VLAN 4 to start from:
	set /P portVlan4_2_6=Tell me which port you want VLAN 4 to end from [97m(if you have no other ports to put, put the previous one and you're done)[0m:
	set /P portVlan6_1_6=Tell me which port you want VLAN 6 to start from:
	set /P portVlan6_2_6=Tell me which port you want VLAN 6 to end from [97m(if you have no other ports to put, put the previous one and you're done)[0m:
		
	set /P portTrunk_6=Tell me which port you want as a trunk:
	set /P portTrunk_6_2=Tell me what else you want as a trunk [97m(si no tienes otro puertos que poner, pon el anterior y listo)[0m:
	set /a portTrunk_6_2_1=%portTrunk_6_2%-%portTrunk_6%
	IF "%portTrunk_6_2_1%"=="0" (set /A portTrunk_6_2_1=%portTrunk_6_2%+%portTrunk_6%)
	
	set /P interface_dir_ADM_6=Tell me what IP address you want for the SW:
	set /P interface_mask_ADM_6=Tell me which netmask the ADMINISTRATION vlan uses:



	
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
	
	
	
	
	ECHO ==============THANK YOU!===============
	ECHO -------------------------------------
	ECHO -------------------------------------
	ECHO ======WAIT TO BE REDIRECTED======
	timeout 0
	goto MENU0
		
		
:MenuOpc0_7
cls
chgport | findstr "COM"
echo.
set pCOM=""
set /P pCOM=Tell me the COM port through which the SW connects:
IF "%pCOM%x"=="x" (goto MenuOpc0_7)
echo.[1mYour chosen port has been the COM%pCOM%[0m
echo.
ECHO ==============THANK YOU!===============
ECHO -------------------------------------
ECHO -------------------------------------
ECHO ======WAIT TO BE REDIRECTED======
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
		ECHO. Modify Ports - SUBMENU 8.	
		ECHO.     
		ECHO.     
		ECHO.     1.- 192.168.0.x
		ECHO.     2.- 192.168.1.x
		ECHO.     3.- Manual Net for 10.X.X.X
		ECHO.     4.- DHCP
		ECHO.    [93m 5.- IPCONFIG/ALL. [0m
		ECHO.     6.- Choose adapter
		ECHO.     7.- Manual Configuration.
		ECHO.     8/Q.- Type "Q" to go back.
		echo.
		echo.     ___________________________________
		echo.     ^|                                          
		echo.     ^|[1m%IPv4%[0m  [IPv4]
		echo.     ^|[1m%netMask%[0m [MASK]
		echo.     ^|[1m%GW%[0m   [GW]
		echo.     ^|[1m%dns%[0m       [DNS]
		Echo.     ^|__________________________________
		set SubMenuOpc8=""
		set /P SubMenuOpc8=Your Choice is:
		
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
		ECHO ============INCORRECT ENTRY============
		ECHO -------------------------------------
		ECHO Please choose a number from the menu
		ECHO Menu [1-5] or choose '6 or Q' to exit.
		ECHO -------------------------------------
		ECHO ======WAIT TO BE REDIRECTED======	
		timeout 4
		goto subMenu8		
			
			
			
			
			
			:SubMenuOpc8_1
				cls
				IF EXIST .\submenu8\configuraciones\192.168.0.x.bat DEL .\submenu8\configuraciones\192.168.0.x.bat
				IF NOT EXIST TYPE nul > .\submenu8\configuraciones\192.168.0.x.bat
				
				set ip8_1=""
				set /P ip8_1="Choose a range from 1 to 253 (if you leave it blank it will be 253): 192.168.0."
				
				
				IF "%ip8_1%x" EQU "x" (goto subMenu8)
				IF "%ip8_1%" GTR "0" (goto diferente8_1)
				IF NOT "%ip8_1%x" == "x" (goto 253_8_1) ELSE (goto diferente8_1)
				
				
				echo.
				ECHO ==============NOP!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======WRITE SOMETHING, PLEASE======
				timeout 3
				goto subMenu8
					
					:253_8_1
					echo netsh interface ipv4 set address %interfaceYou% static 192.168.0.253 255.255.255.0 192.168.0.1 >> .\submenu8\configuraciones\192.168.0.x.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 8.8.8.8  >> .\submenu8\configuraciones\192.168.0.x.bat
					.\submenu8\direct\192.168.0.x.bat.lnk
					
					echo.
					ECHO ==============THANKS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======WAIT TO BE REDIRECTED======
					timeout 3
					goto subMenu8
					
					:diferente8_1
					echo netsh interface ipv4 set address %interfaceYou% static 192.168.0.%ip8_1% 255.255.255.0 192.168.0.1 >> .\submenu8\configuraciones\192.168.0.x.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 8.8.8.8  >> .\submenu8\configuraciones\192.168.0.x.bat
					.\submenu8\direct\192.168.0.x.bat.lnk
					
					echo.
					ECHO ==============THANKS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======WAIT TO BE REDIRECTED======
					timeout 3
					goto subMenu8
				
			


			:SubMenuOpc8_2
				cls
				IF EXIST .\submenu8\configuraciones\192.168.1.x.bat DEL .\submenu8\configuraciones\192.168.1.x.bat
				IF NOT EXIST TYPE nul > .\submenu8\configuraciones\192.168.1.x.bat
				
				set ip8_2=""
				set /P ip8_2="Choose a range from 1 to 253 (if you leave it blank it will be 253): 192.168.1."
				
				
				IF "%ip8_2%x" EQU "x" (goto subMenu8)
				IF "%ip8_2%" GTR "0" (goto diferente8_2)
				IF NOT "%ip8_2%x" == "x" (goto 253_8_2) ELSE (goto diferente8_2)
				
				
				echo.
				ECHO ==============NOP!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======WRITE SOMETHING, PLEASE======
				timeout 3
				goto subMenu8
					
					:253_8_2
					echo netsh interface ipv4 set address %interfaceYou% static 192.168.1.253 255.255.255.0 192.168.1.1 >> .\submenu8\configuraciones\192.168.1.x.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 8.8.8.8 >> .\submenu8\configuraciones\192.168.1.x.bat
					.\submenu8\direct\192.168.1.x.bat.lnk
					
					echo.
					ECHO ==============THNAKS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======WAIT TO BE REDIRECTED======
					timeout 3
					goto subMenu8
					
					:diferente8_2
					echo netsh interface ipv4 set address %interfaceYou% static 192.168.1.%ip8_2% 255.255.255.0 192.168.1.1 >> .\submenu8\configuraciones\192.168.1.x.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 8.8.8.8 >> .\submenu8\configuraciones\192.168.1.x.bat
					.\submenu8\direct\192.168.1.x.bat.lnk
					
					echo.
					ECHO ==============THANKS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======WAIT TO BE REDIRECTED======
					timeout 3
					goto subMenu8	

			:SubMenuOpc8_3
			rem Manual Net for 10.X.X.X
				cls
				IF EXIST .\submenu8\configuraciones\redescuelas.bat DEL .\submenu8\configuraciones\redescuelas.bat
				IF NOT EXIST TYPE nul > .\submenu8\configuraciones\redescuelas.bat
				
				set ip8_3=""
				set mascara8_3=""
				set puerta8_3=""
				set /P ip8_3="Tell me the IP address: 10."
				set /P mascara8_3="Tell me the mask: 255.255.255."
				set /P puerta8_3="Tell me the GW: 10."
				
				
				IF "%ip8_3%x" EQU "x" (goto subMenu8)
				IF "%mascara8_3%x" EQU "x" (goto subMenu8)
				IF "%puerta8_3%x" EQU "x" (goto subMenu8)
				
				IF "%ip8_3%,%mascara8_3%,%puerta8_3%" GTR "0" (goto avanzar8_3)
				
				
				echo.
				ECHO ==============NOP!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======TYPE CORRECTLY, PLEASE======
				timeout 3
				goto subMenu8
					
					:avanzar8_3
					echo netsh interface ipv4 set address %interfaceYou% static 10.%ip8_3% 255.255.255.%mascara8_3% 10.%puerta8_3% >> .\submenu8\configuraciones\redescuelas.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static 10.151.126.17  >> .\submenu8\configuraciones\redescuelas.bat
					.\submenu8\direct\redescuelas.bat.lnk
					
					echo.
					ECHO ==============THANKS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======WAIT TO BE REDIRECTED======
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
				ECHO ==============THANKS!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======
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
				ECHO ==============PRESS ANY KEY TO EXIT!===============				
				pause>nul
				
				echo.
				ECHO ==============THANKS!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======
				timeout 3
				goto subMenu8

			:SubMenuOpc8_6
			rem Choose adapter
				cls
				
				netsh interface ipv4 show interfaces
				set /P interfaceYou=Tell me the number on the left of the network adapter you want to use:
				

				echo.
				ECHO ==============THANKS!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======WAIT TO BE REDIRECTED======
				timeout 3
				goto subMenu8	

			:SubMenuOpc8_7
			rem Manual Configuration
				cls
				IF EXIST .\submenu8\configuraciones\confmanual.bat DEL .\submenu8\configuraciones\confmanual.bat
				IF NOT EXIST TYPE nul > .\submenu8\configuraciones\confmanual.bat
				
				set ip8_7=""
				set mascara8_7=""
				set puerta8_7=""
				set dns8_7=""
				set /P ip8_7="Tell me the IP address: "
				set /P mascara8_7="Tell me the IP address: "
				set /P puerta8_7="Tell me the GW: "
				set /P dns8_7="Tell me the DNS: "
				
				
				IF "%ip8_7%x" EQU "x" (goto subMenu8)
				IF "%mascara8_7%x" EQU "x" (goto subMenu8)
				IF "%puerta8_7%x" EQU "x" (goto subMenu8)
				
				IF "%ip8_7%,%mascara8_7%,%puerta8_7%" GTR "0" (goto avanzar8_7)
				
				
				echo.
				ECHO ==============NOP!===============
				ECHO -------------------------------------
				ECHO -------------------------------------
				ECHO ======TYPE CORRECTLY, PLEASE======
				timeout 3
				goto subMenu8
					
					:avanzar8_7
					echo netsh interface ipv4 set address %interfaceYou% static %ip8_7% %mascara8_7% %puerta8_7% >> .\submenu8\configuraciones\confmanual.bat
					echo netsh interface ipv4 set dnsserver %interfaceYou% static %dns8_7%  >> .\submenu8\configuraciones\confmanual.bat
					.\submenu8\direct\confmanual.bat.lnk
					
					echo.
					ECHO ==============THANKS!===============
					ECHO -------------------------------------
					ECHO -------------------------------------
					ECHO ======WAIT TO BE REDIRECTED======
					timeout 3
					goto subMenu8			
			
			
			
			
			
			:SubMenuOpc8_8
			cls
			ECHO ==============THANKS!===============
			ECHO -------------------------------------
			ECHO -------------------------------------
			ECHO ======WAIT TO BE REDIRECTED======
			timeout 0
			goto MENU0
		
		
		
		
		
		
		
		
		
		
:MenuOpc0_9
rem subMENÚ [9] ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cls
ECHO Information about all submenus and options
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
	ECHO ==============THANKS!===============
 _._     _,-'""`-._
(,-.`._,'(       |\`-/|
    `-.-' \ )-`( , o o)
          `-    \`_`"'-
echo @Hylosium on StackOverflow and Github

	ECHO -------------------------------------
	ECHO ======WAIT TO BE REDIRECTED======
	timeout 3
	exit