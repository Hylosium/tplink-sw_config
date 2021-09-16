	IF EXIST resultado2.txt DEL resultado2.txt
	IF NOT EXIST TYPE nul > resultado2.txt
	
	set /P portTrunk_6=Primer puerto:
	set /P portTrunk_6_2=[97mSegundo[0m puerto:
	set /A portTrunk_6_2_1=%portTrunk_6_2%-%portTrunk_6%
	IF "%portTrunk_6_2_1%"=="0" (set /A portTrunk_6_2_1=%portTrunk_6_2%+%portTrunk_6%)
	
	echo ! >> resultado2.txt
	echo %portTrunk_6_2-1% >> resultado2.txt

	FOR /L %%T IN (%portTrunk_6%,%portTrunk_6_2_1%,%portTrunk_6_2%) DO (
	
	echo interface gigabitEthernet 1/0/%%T >> resultado2.txt
	echo switchport general allowed vlan 2,3,4,6 tagged >> resultado2.txt
	echo loopback-detection config process-mode port-based recovery-mode auto >> resultado2.txt
	echo loopback-detection >> resultado2.txt
	
	)
	pause