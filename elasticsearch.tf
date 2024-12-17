#Еластик сервер
resource "yandex_compute_instance" "elastic" {
  name = "elastic"
  hostname = "elastic"
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
    subnet_id = yandex_vpc_subnet.private-vm1.id
    ip_address = "10.128.10.10"
#    nat = false
    security_group_ids = [yandex_vpc_security_group.bastion-internal-sg.id, yandex_vpc_security_group.elasticsearch-sg.id]
  }
  metadata = {
    user-data = file("./meta.yml")
  }
}