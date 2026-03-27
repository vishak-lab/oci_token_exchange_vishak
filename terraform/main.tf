provider "oci" {
  config_file_profile = "DEFAULT"
}

resource "oci_core_instance" "test_instance" {
  availability_domain = var.ad
  compartment_id      = var.compartment_id
  shape               = "VM.Standard.E2.1.Micro"

  display_name = "github-oidc-instance"

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = var.image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}
