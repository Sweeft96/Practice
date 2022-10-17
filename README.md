# Practice
## HW 5(VPN)
### Подключение к someinternalhost одной командой:
```
ssh -J 34.163.245.209 10.172.0.2
```
### Подключение по алиасу:
В файл ~/.ssh/config добавляем:
```
Hostname 10.172.*
	ProxyJump 34.163.245.209
```

### VPN server
```
bastion_IP = 34.163.245.209
someinternalhost_IP = 10.172.0.2
```
## HW 6
```
testapp_IP = 35.204.254.156
testapp_port = 9292
```

