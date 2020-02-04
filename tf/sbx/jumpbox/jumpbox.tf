
module "compute_jumpbox" {
  source                  = "git::https://github.com/corelogic/terraform-gcp-instance?ref=v4.1.0"
  project_id              = "${var.project_id}"
  region                  = "${var.region}"
  zones                   = ["${var.zones}"]
  name                    = "ksvlin01-jiraconf-jump"
  use_random_id           = "false"
  machine_type            = "n1-standard-1"
  network_tags            = ["${var.network_tags}"]
  ip_forwarding           = true
  boot_image              = "${var.boot_image}"
  boot_disk_type          = "${var.boot_disk_type}"
  boot_disk_size          = 10
  boot_disk_auto_delete   = true
  metadata                = {}
  metadata_startup_script = "${file("${path.module}/files/startup.sh")}"
  network                 = "${var.network}"
  subnetwork_project      = "${var.network_project_id}"
  subnetwork              = "${var.subnetwork}"
  service_account_email   = "ans-${var.project_name}@${var.project_id}.iam.gserviceaccount.com"                           # change to desired service account
  service_account_scopes  = ["https://www.googleapis.com/auth/cloud-platform"]

  instance_count          = "${var.instance_count}"
#  instance_group          = "false"
#  network_ip              = ["10.38.184.30"]
#  network_ip_reserve      = "false"

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
