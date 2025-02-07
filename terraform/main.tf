provider "google" {
    credentials = file(var.gcp_credentials_file)

    project = var.gcp_project
}

resource "random_id" "random_vpc_name" {
    byte_length = 8
    prefix = "${var.cluster_name_final}-"
}
