#Забикс сервер
resource "yandex_compute_instance" "zabbix" {
  name = "zabbix"
  hostname = "zabbix"
  zone = "ru-central1-a"

  resources {
    cores = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8b46dbr7fe0gm2ninu"
      size = 10
    }
  }

  scheduling_policy {
    preemptible = true
    }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-public.id
    ip_address = "10.128.30.10"
    nat = true
    security_group_ids = [yandex_vpc_security_group.bastion-internal-sg.id, yandex_vpc_security_group.zabbix-sg.id]
  }
  metadata = {
    user-data = file("./meta.yml")
  }
}