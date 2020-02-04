/******
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******/

locals {
  credentials_file_path = "../sa-key.json"
  startup_script        = "${path.module}/files/startup.sh"
}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  credentials = "${file(local.credentials_file_path)}"
  project     = "${var.project_id}"
}

/******************************************
   Provider backend store
  *****************************************/
terraform {
  backend "gcs" {
    bucket      = "clgx-clasia-jira-conf-dev-terraform-state"
    prefix      = "jira"
    credentials = "../sa-key.json"
  }
}

