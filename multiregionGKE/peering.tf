#############################################################################
# VPC Peering: region1 <--> region2
#############################################################################
resource "google_compute_network_peering" "region1_region2" {
  name         = "peering-region1-region2"
  network      = module.region1.vpc_network_self_link
  peer_network = module.region2.vpc_network_self_link

  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "region2_region1" {
  name         = "peering-region2-region1"
  network      = module.region2.vpc_network_self_link
  peer_network = module.region1.vpc_network_self_link

  export_custom_routes = true
  import_custom_routes = true
}

#############################################################################
# VPC Peering: region1 <--> region3
#############################################################################
resource "google_compute_network_peering" "region1_region3" {
  name         = "peering-region1-region3"
  network      = module.region1.vpc_network_self_link
  peer_network = module.region3.vpc_network_self_link

  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "region3_region1" {
  name         = "peering-region3-region1"
  network      = module.region3.vpc_network_self_link
  peer_network = module.region1.vpc_network_self_link

  export_custom_routes = true
  import_custom_routes = true
}

#############################################################################
# VPC Peering: region2 <--> region3
#############################################################################
resource "google_compute_network_peering" "region2_region3" {
  name         = "peering-region2-region3"
  network      = module.region2.vpc_network_self_link
  peer_network = module.region3.vpc_network_self_link

  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "region3_region2" {
  name         = "peering-region3-region2"
  network      = module.region3.vpc_network_self_link
  peer_network = module.region2.vpc_network_self_link

  export_custom_routes = true
  import_custom_routes = true
}

