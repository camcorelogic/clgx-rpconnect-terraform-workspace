
# module "compute_kdvlin01-confpostg" {
module "instance" {
  source                  = "git::https://github.com/corelogic/terraform-gcp-instance?ref=v4.1.0"
  project_id              = "${var.project_id}"
  region                  = "${var.region}"
  zones                   = ["${var.zones}"]
  name                    = "kdvlin01-confpostg"
  use_random_id           = "false"
  machine_type            = "n1-standard-4"
  network_tags            = ["${var.network_tags}"]
  ip_forwarding           = true
  boot_image              = "${var.boot_image_ubuntu}"
  boot_disk_type          = "${var.boot_disk_type}"
  boot_disk_size          = 30
  boot_disk_auto_delete   = true
  metadata                = {}
  metadata_startup_script = "${file("${path.module}/files/startup.sh")}"
  network                 = "${var.network}"
  subnetwork_project      = "${var.network_project_id}"
  subnetwork              = "${var.subnetwork}"

  ### CHANGE BELOW FROM DEFAULT IF NOT JUMP SERVER
  # service_account_email   = "ans-${var.project_name}@${var.project_id}.iam.gserviceaccount.com"
  service_account_email   = "${var.pgres_service_account}"
  service_account_scopes  = ["https://www.googleapis.com/auth/cloud-platform"]


  instance_count          = 1
#  instance_group          = "false"

 # Networking
#  network_ip              = ["10.38.184.30"]
  network_ip_reserve      = "false"

  # Additional disks
#  additional_disks = [
#    {
#      type = "pd-ssd"
#      size = "2048"
#    },
#    {
#      type = "pd-ssd"
#      size = "1024"
#    },
#  ]


  # Labels
  application  = "${var.application}"
  purpose      = "${var.purpose}"
  organization = "${var.organization}"

  primary_company_code    = "${var.primary_company_code}"
  primary_cost_center     = "${var.primary_cost_center}"
  chargeback_company_code = "${var.chargeback_company_code}"
  chargeback_cost_center  = "${var.chargeback_cost_center}"
  case_wise_appid         = "${var.case_wise_appid}"
  environment             = "${var.environment}"
  financial_owner         = "${var.financial_owner}"
  tech_lead               = "${var.tech_lead}"
  resolver_group          = "${var.resolver_group}"

  tier       = "${var.tier}"
  backup     = "${var.backup}"
  technology = "${var.technology}"
}


module "data_disk_labels" {
  source = "git::https://github.com/corelogic/terraform-null-label?ref=v3.0.0"

  # CoreLogic
  application  = "${var.application}"
  purpose      = "${var.purpose}"
  organization = "${var.organization}"

  primary_company_code    = "${var.primary_company_code}"
  primary_cost_center     = "${var.primary_cost_center}"
  chargeback_company_code = "${var.chargeback_company_code}"
  chargeback_cost_center  = "${var.chargeback_cost_center}"
  case_wise_appid         = "${var.case_wise_appid}"
  environment             = "${var.environment}"
  financial_owner         = "${var.financial_owner}"
  tech_lead               = "${var.tech_lead}"
  resolver_group          = "${var.resolver_group}"
  tier                    = "${var.tier}"
  backup                  = "${var.backup}"
  technology              = "${var.technology}"
}

## Add additional disks for hosting data, logs and backups.

resource "google_compute_disk" "data_disk" {
#  count = "${var.enable_data_disk}"
  count = "1"

  name   = "${basename("${module.instance.self_link[0]}")}-data-disk"
  zone   = "${var.zones}"
#  type   = "${var.data_disk_type}"
#  size   = "${var.data_disk_size}"
  type   = "pd-ssd"
  size   = "2048"
  labels = "${module.data_disk_labels.labels}"
}

resource "google_compute_attached_disk" "data_disk" {
  count       = "${google_compute_disk.data_disk.count}"
  disk        = "${google_compute_disk.data_disk.self_link}"
  device_name = "${google_compute_disk.data_disk.name}"
  instance    = "${module.instance.self_link[0]}"
}

resource "google_compute_disk" "log_disk" {
#  count = "${var.enable_log_disk}"
  count = "1"

  name   = "${basename("${module.instance.self_link[0]}")}-log-disk"
  zone   = "${var.zones}"
#  type   = "${var.log_disk_type}"
#  size   = "${var.log_disk_size}"
  type   = "pd-ssd"
  size   = "1024"
  labels = "${module.data_disk_labels.labels}"
}

resource "google_compute_attached_disk" "log_disk" {
  count       = "${google_compute_disk.log_disk.count}"
  disk        = "${google_compute_disk.log_disk.self_link}"
  device_name = "${google_compute_disk.log_disk.name}"
  instance    = "${module.instance.self_link[0]}"
}


