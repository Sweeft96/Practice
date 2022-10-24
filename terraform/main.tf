terraform {
  # Версия terraform
  required_version = "0.12.8"
}

provider "google" {
  # Версия провайдера
  version = "3.17.0"

  # ID проекта
  project = "infra-365211"
  region  = "europe-west-1"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags         = ["reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "reddit-base"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  metadata = {
    # путь до публичного ключа
    ssh-keys = "sweeft:${file("~/.ssh/appuser.pub")}"
  }

  connection {
    type  = "ssh"
    user  = "sweeft"
    agent = false
    host = "network_interface.0.access_config.0.nat_ip"
    # путь до приватного ключа
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
}

