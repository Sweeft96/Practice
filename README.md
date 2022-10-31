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
## HW 6 (GCP)
```
testapp_IP = 35.204.254.156
testapp_port = 9292
```
Дополнительное задание: создание firewall rule через gcloud:
```
gcloud compute firewall-rules create default-puma-server --action=allow --rules tcp:9292 --direction=ingress --target-tags=puma-server
```
## HW 7 (Packer)
Установка Packer:
``` 
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install packer
```
Настройка Application Default Credentials (ADC), чтобы Packer мог обращаться к GCP через API:
```
gcloud auth application-default login
```
В файле ubuntu16.json были описаны инструкции для packer builder для подготовки образа Ubuntu с предустановленными Ruby и MongoDB.
Проверка .json файла на ошибки:
```
packer validate ./ubuntu16.json
```
Запуск создания образа:
```
packer build ubuntu16.json
```

## HW 8 (IaC - terraform-1)
# Самостоятельные задания
Определите input переменную для приватного ключа, использующегося в определении подключения для провижинеров (connection);
```
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
```
Определите input переменную для задания зоны в ресурсе "googlecomputeinstance" "app". У нее должно быть значение по умолчанию.

```
variable "zone" {
  description = "Zone"
  default = "europe-west1-b"
}
```

## HW 9 (terraform-2)
Создаём копию уже определённого в GCP правила, разрешающего подключение по ssh:
```
resource "google_compute_firewall" "firewall_ssh" {
  name        = "default-allow-ssh"
  description = "Allow SSH from anywhere"
  network     = "default"
  priority    = 65534

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
```



### Разбиение конфигурации по файлам / на модули

```
$ tree modules/app/
modules/app/
├── files
│   ├── deploy.sh
│   ├── puma.service
│   └── set_env.sh
├── main.tf
├── outputs.tf
└── variables.tf
```

### Структура модуля

```
module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}
```
## HW 10(ansible-1)
Примеры протестированных команд:
```
$ ansible app -m command -a 'ruby -v'
$ ansible app -m command -a 'ruby -v; bundler -v'
$ ansible db -m command -a 'systemctl status mongod'
$ ansible db -m systemd -a name=mongod
$ ansible db -m service -a name=mongod
$ ansible app -m git -a 'repo=https://github.com/express42/reddit.git dest=/home/appuser/reddit'
```
## HW 11(ansible-2)
В данной работе мы опробовали:

применение jinja2 templates;
пробный прогон через опцию --check;
ограничение группы хостов, к которым применяется плейбук, через --limit и --tags ;
разбиение одного плейбука на несколько с последующим их объединением в один плейбук через import;
механизм notify /handlers;
установка софта и деплой приложения через Ansible (на смену bash-скриптам), в т.ч. в Packer.

## HW 12 (ansible-3: Работа с ролями и окружениями)

В данной работе мы сделали:
разбили ранее созданные плейбуки на роли (app, db);
разделили окружения на prod и env;
установили комьюнити-роль nginx;
опробовали применения Ansible Vault;
добавили поддержку окружения в dynamic inventory;
задали дополнительные тесты в TravisCI.


