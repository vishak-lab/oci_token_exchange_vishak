terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }

  required_version = ">= 1.2.0"
}


provider "oci" {
  auth                = "SecurityToken"
  config_file_profile = "DEFAULT"
}


resource "oci_core_instance" "lesson_03" {
  availability_domain = "kYXC:US-ASHBURN-AD-1"
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaapjdzahspbgldg4d7vwtty47hywkaqu3372jj2cytb7chlaiqmgha"

  display_name = var.instance_name
  #display_name = "Lesson-03-OCI-Instance"
  shape = "VM.Standard.E5.Flex"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 8
  }

  create_vnic_details {
    subnet_id        = "ocid1.subnet.oc1.iad.aaaaaaaammprrzdlfdc3wsz3q75mfmnep7lybcszpq5p6jqtu5ruaxyq3bpq"
    assign_public_ip = true
  }

  source_details {
    source_id   = "ocid1.image.oc1.iad.aaaaaaaahvwnjutyewvsr2nkjcfq6i7l5anlm6bslnoom2vaerhwbzc2wx4a"
    source_type = "image"
  }
}

output "public_ip" {
  description = "Public IP address of the OCI instance"
  value       = oci_core_instance.lesson_03.public_ip
}

output "display_name" {
  description = "display name of the OCI instance"
  value       = oci_core_instance.lesson_03.display_name
}
