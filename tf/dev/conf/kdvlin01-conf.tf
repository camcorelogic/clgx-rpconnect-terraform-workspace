
module "compute_conf" {
  source                  = "git::https://github.com/corelogic/terraform-gcp-instance?ref=v4.1.0"
  project_id              = "${var.project_id}"
  region                  = "${var.region}"
  zones                   = ["${var.zones}"]
  name                    = "kdvlin01-conf"
  use_random_id           = "false"
  machine_type            = "n1-standard-8"

  #### CHANGE HERE - APP FIREWALL RULES APPLIED VIA NETWORK TAG
  network_tags            = ["allow-ssh", "allow-int-http", "allow-dl-health-checks"]

  ip_forwarding           = true
  boot_image              = "${var.boot_image}"
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
  service_account_email   = "${var.conf_service_account}"
  service_account_scopes  = ["https://www.googleapis.com/auth/cloud-platform"]

  instance_count          = 1
#  instance_group          = "false"

 # Networking
#  network_ip              = ["10.38.184.30"]
  network_ip_reserve      = "false"

  # Additional disks
  additional_disks = [
    {
      type = "pd-ssd"
      size = "2048"
    },
  ]


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
