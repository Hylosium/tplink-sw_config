set /P vlan= Elige la vlan:
set /P elegir_modo2_2=Elegir modo (access, trunk o general):
powershell -Command "(gc add_port_to_vlan.txt) -replace '"vlan %vlan% .*"', '"vlan %vlan% untagged"' | Out-File -encoding ASCII add_port_to_vlan.txt"
powershell -Command "(gc .\add_port_to_vlan.txt) -replace '"vlan %vlan% .*"', '"vlan %vlan%  tagged"' | Out-File -encoding ASCII .\add_port_to_vlan.txt"
powershell -Command "(gc .\add_port_to_vlan.txt) -replace '"^.*allowed .*"', '"switchport %elegir_modo2_2% allowed vlan %vlan% untagged"' | Out-File -encoding ASCII .\add_port_to_vlan.txt"
pause>NUL
