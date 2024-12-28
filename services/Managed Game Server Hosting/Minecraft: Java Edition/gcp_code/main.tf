# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "minecraft-java-edition-instance" {
  boot_disk {
    auto_delete = false
    device_name = "minecraft-java-edition-instance"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20241210"
      size  = 25
      type  = "pd-ssd"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = true
  deletion_protection = true
  enable_display      = false

  labels = {
    goog-ec-src           = "vm_add-tf"
    goog-ops-agent-policy = "v2-x86-template-1-4-0"
  }

  machine_type = "e2-medium"

  metadata = {
    enable-osconfig    = "TRUE"
    enable-oslogin     = "true"
    enable-oslogin-2fa = "true"
  }

  name = "minecraft-java-edition-instance"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/zuedev-catchall-2024/regions/europe-west2/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "211474278397-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = true
    enable_vtpm                 = true
  }

  zone = "europe-west2-c"
}

module "ops_agent_policy" {
  source        = "github.com/terraform-google-modules/terraform-google-cloud-operations/modules/ops-agent-policy"
  project       = "zuedev-catchall-2024"
  zone          = "europe-west2-c"
  assignment_id = "goog-ops-agent-v2-x86-template-1-4-0-europe-west2-c"
  agents_rule = {
    package_state = "installed"
    version       = "latest"
  }
  instance_filter = {
    all = false
    inclusion_labels = [{
      labels = {
        goog-ops-agent-policy = "v2-x86-template-1-4-0"
      }
    }]
  }
}
