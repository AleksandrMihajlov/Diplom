#Веб сервер 1
resource "yandex_compute_instance" "vm1" {
  name = "web1"
  hostname = "web1"
  zone = "ru-central1-a"

  resources {
    cores = 2
    memory = 2
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
    ip_address = "10.128.10.5"
#    nat = false
    security_group_ids = [yandex_vpc_security_group.bastion-internal-sg.id, yandex_vpc_security_group.webs-sg.id]
  }
  metadata = {
    user-data = file("./meta.yml")
  }
}

#Веб сервер 2
resource "yandex_compute_instance" "vm2" {
  name = "web2"
  hostname = "web2"
  zone = "ru-central1-b"

  resources {
    cores = 2
    memory = 2
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
    subnet_id = yandex_vpc_subnet.private-vm2.id
    ip_address = "10.128.20.5"
#    nat = false
    security_group_ids = [yandex_vpc_security_group.bastion-internal-sg.id, yandex_vpc_security_group.webs-sg.id]
  }
  metadata = {
    user-data = file("./meta.yml")
  }
}