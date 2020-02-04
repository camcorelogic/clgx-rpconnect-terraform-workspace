/**
 *
 * Variables for instances and resources within this directory
 *
 */

#### 
#### Instance settings
#### 
variable "name" {
  description = "The name to give the instances"
  default     = "kdvlin01-jump-jira-conf"
}

variable instance_count {
  description = "The target number of instances for each zone."
  default     = 1
}

variable "network_tags" {
  description = "Network access tags"
  default     = ["egress-nat-gce", "allow-ssh", "egress-nat-au-se1"]
}


variable "boot_image" {
  description = "The image from which to initialize this disk."
  default     = "projects/clgx-imgfact-repo-glb-prd-f2a0/global/images/cl-centos-7-v20190228-45"
}
variable "boot_image_ubuntu" {
  description = "The image from which to initialize this disk."
  default     = "projects/clgx-imgfact-repo-glb-prd-f2a0/global/images/cl-ubuntu-1604-xenial-v20191114-146"
}

variable "boot_disk_type" {
  description = "The GCE disk type. May be set to pd-standard or pd-ssd"
  default     = "pd-ssd"
}

variable "startup_script" {
  type        = "string"
  description = "startup script"
  default     = "files/startup.sh"
}


#### 
#### Labeling
#### 
variable "application" {
  type        = "string"
  default     = "jira-conf"
}

variable "purpose" {
  type        = "string"
  default     = "jira-conf media agent"
}


#### 
#### Optional for projects/accounts. Mandatory for resources
#### 
variable "tier" {
  type        = "string"
  description = "Tier: ie Web, App, or Data"
  default     = "app"
}

variable "backup" {
  type        = "string"
  description = "A value indicating whether the labeled resource should be included in the backup strategy."
  default     = "no"
}

variable "technology" {
  type        = "string"
  description = "A value indicating the tool/language that is running. Example: Sql/PostgreSQL."
  default     = "Atlassian"
}

##

##

