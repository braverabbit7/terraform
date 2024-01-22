terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.104.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket                      = "elfteb1"
    region                      = "ru-central1"
    key                         = "issue1/terraform.tfstate"
    access_key                  = "access"
    secret_key                  = "secret"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

  }
}


provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = pathexpand("~/.ssh/authorized_key.json")
  zone                     = "ru-central1-a"
}




resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.7.0/24"]
}

resource "yandex_vpc_subnet" "subnet2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.8.0/24"]
}


module "ya_instance_1" {
  source                = "./modules"
  instance_family_image = "lemp"
  instance_zone         = "ru-central1-a"
  vpc_subnet_id         = yandex_vpc_subnet.subnet1.id
}

module "ya_instance_2" {
  source                = "./modules"
  instance_family_image = "lamp"
  instance_zone         = "ru-central1-b"
  vpc_subnet_id         = yandex_vpc_subnet.subnet2.id

}
