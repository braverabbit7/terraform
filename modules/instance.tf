terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.104.0"
    }
  }
}
data "yandex_compute_image" "my_image" {
  family = var.instance_family_image

}

resource "yandex_compute_instance" "vm" {
  name = "terraform-${var.instance_family_image}"
  #allow_stopping_for_update = true
  zone = var.instance_zone
  resources {

    core_fraction = 100
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }
  # metadata = {
  #   user-data = "${file("meta.txt")}"
  # }

  metadata = {
    user-data = <<-EOF
      #!/bin/bash

      echo "<h1>Hello from user-data script!</h1><h2>${var.instance_family_image}</h2> <br/> <h3> </h3>"  > /var/www/html/*.html
      EOF  
  }
  # scheduling_policy {
  #   preemptible = true
  # }


}

