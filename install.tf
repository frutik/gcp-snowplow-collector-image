data "google_compute_image" "collector_image" {
  family  = "collector-node"
  project = "<project name>"
}

resource "google_compute_instance_template" "default" {
  name        = "collector-template"
  description = "This template is used to create collector instances."

  tags = ["foo", "bar"]

  labels = {
    environment = "prod"
  }

  instance_description = "description assigned to instances"
  machine_type         = "f1-micro"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  // disk {
  //   source_image = "debian-cloud/debian-9"
  //   auto_delete  = true
  //  boot         = true
  //}
  disk {
//    initialize_params {
        source = "${data.google_compute_image.collector_image.self_link}"
	size  = 10
	type  = "pd-ssd"
	//zone  = "europe-west1-b"
//    }
  }


  // Use an existing disk resource
  //disk {
    // Instance Templates reference disks by name, not self link
//    source      = "${google_compute_disk.foobar.name}"
//    auto_delete = false
//    boot        = false
 // }

  network_interface {
    network = "default"
  }

  metadata = {
    foo = "bar"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

//data "google_compute_image" "my_image" {
//  family  = "debian-9"
//  project = "debian-cloud"
//}

//resource "google_compute_disk" "foobar" {
//  name  = "existing-disk"
//  image = "${data.google_compute_image.my_image.self_link}"
//  size  = 10
//  type  = "pd-ssd"
//  zone  = "us-central1-a"
//}

