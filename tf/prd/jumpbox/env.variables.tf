/**
 *
 * Environment variables header definition
 *
 */

#locals {
#  env         = "sbx"
#  basename    = "clgx-jira-conf-${local.env}"
#}

variable "project_name" {
  description = "The GCP project name"
}
variable "project_id" {
  description = "The GCP project id"
}

variable "network_project_id" {
  description = "The GCP project id of where the VPC network resides"
}

variable "network" {
  description = "The name of the VPC network"
}

variable "subnetwork" {
  description = "The name of the subnetwork"
}

#variable "subnetwork_project" {
#  description = "The name of the subnetwork project"
#}

variable "region" {
  description = "The GCP region"
}

variable "zones" {
  description = "The GCP zone"
}

variable "terraform_service_account" {
  description = "The project specific terraform service account"
}

variable "environment" {
  description = "Environment: ie Dev, DR, Prod, QA, SA, SB, Test, UAT, Staging, Training, Sandbox, Other"
}
