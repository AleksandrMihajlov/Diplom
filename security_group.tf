#Бастион - внешняя группа безопасности
resource "yandex_vpc_security_group" "bastion-external-sg" {
  name        = "bastion-external-sg"
  description = "Бастион - внешний"
  network_id  = yandex_vpc_network.net-main.id

  ingress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["10.128.10.0/24" , "10.128.20.0/24" , "10.128.30.0/24"]
    port           = 22
  }

  egress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["10.128.10.0/24" , "10.128.20.0/24" , "10.128.30.0/24"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#Бастион - локальная группа безопасности
resource "yandex_vpc_security_group" "bastion-internal-sg" {
  name        = "bastion-internal-sg"
  description = "Бастион - локальный"
  network_id  = yandex_vpc_network.net-main.id

  ingress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["10.128.10.0/24" , "10.128.20.0/24" , "10.128.30.0/24"]
    port           = 22
  }

  egress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["10.128.10.0/24" , "10.128.20.0/24" , "10.128.30.0/24"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#Веб сервер - группа безопасности
resource "yandex_vpc_security_group" "webs-sg" {
  name        = "webs-sg"
  description = "Веб сервер - группа безопасности"
  network_id  = yandex_vpc_network.net-main.id

  ingress {
    description    = "HTTP protocol"
    protocol       = "TCP"
    port           = "80"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "HTTPS protocol"
    protocol       = "TCP"
    port           = "443"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description       = "Health checks from NLB"
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }

  ingress {
    protocol       = "TCP"
    description    = "Забикс агент"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 10050
  }

  ingress {
    protocol       = "TCP"
    description    = "Забикс агент"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 10051
  }

  ingress {
    protocol       = "TCP"
    description    = "allow >5000 random for filebeat"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 5000
    to_port        = 65535
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#Забикс - группа безопасности
resource "yandex_vpc_security_group" "zabbix-sg" {
  name        = "zabbix-sg"
  description = "Забикс - группа безопасности"
  network_id  = yandex_vpc_network.net-main.id

  ingress {
    protocol       = "TCP"
    description    = "HTTP protocol"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Забикс агент"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 10050
  }

  ingress {
    protocol       = "TCP"
    description    = "Забикс агент"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 10051
  }

  ingress {
    protocol       = "TCP"
    description    = "allow 5432 psql"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5432
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#Еластик - группа безопасности
resource "yandex_vpc_security_group" "elasticsearch-sg" {
  name        = "elasticsearch-sg"
  description = "Еластик - группа безопасности"
  network_id  = yandex_vpc_network.net-main.id

  ingress {
    protocol       = "TCP"
    description    = "allow 9200"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 9200
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#Кибана - группа безопасности
resource "yandex_vpc_security_group" "kibana-sg" {
  name        = "kibana-sg"
  description = "Кибана - группа безопасности"
  network_id  = yandex_vpc_network.net-main.id

  ingress {
    protocol       = "TCP"
    description    = "allow 5601"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5601
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}