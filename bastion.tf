#Кибана сервер
resource "yandex_compute_instance" "bastion" {
  name = "bastion"
  hostname = "bastion"
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
    subnet_id = yandex_vpc_subnet.bastion-public.id
    ip_address = "10.128.40.5"
    nat = true
    security_group_ids = [yandex_vpc_security_group.bastion-internal-sg.id, yandex_vpc_security_group.bastion-external-sg.id]
  }
  metadata = {
    user-data = file("./meta.yml")
  }
}