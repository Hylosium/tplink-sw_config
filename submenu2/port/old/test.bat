
powershell -Command "(gc test.txt) -replace '"mode .*"', '"mode %elegir_modo2_2%"' | Out-File -encoding ASCII test.txt"
powershell -Command "(gc test.txt) -replace '"^.* allowed"', '"switchport %elegir_modo2_2% allowed"' | Out-File -encoding ASCII test.txt"
powershell -Command "(gc test.txt) -replace '"vlan .*"', '"vlan %elegir_vlan2_2%"' | Out-File -encoding ASCII test.txt"
rem  Ya funciona, al final lo he solucionado con '^'
pause
