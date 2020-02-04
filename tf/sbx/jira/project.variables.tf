/**
 * Copyright 2018 Google LLC
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
 */


#variable "application" {
#  description = "Primary App Name"
#}

#variable "purpose" {
#  description = "Purpose"
#}

variable "organization" {
  description = "organization"
}



#### 
#### CoreLogic
#### 
variable "primary_company_code" {
  description = "Primary CompanyCode: numeric, 4 digits"
}

variable "primary_cost_center" {
  description = "Primary CostCenter: numeric, 6 digits"
}

variable "chargeback_company_code" {
  description = "Chargeback CompanyCode: numeric, 4 digits"
}

variable "chargeback_cost_center" {
  description = "Chargeback CostCenter: numeric, 6 digits"
}

variable "case_wise_appid" {
  description = "CasewiseAppID: numeric, 10 digits"
}

variable "financial_owner" {
  description = "Financial Owner Email: Since GCP does not allow '@', don't include '@corelogic.com'. All email addresses are assumed to be '@corelogic.com'"
}

variable "tech_lead" {
  description = "Technical Lead Email: Since GCP does not allow '@', don't include '@corelogic.com'. All email addresses are assumed to be '@corelogic.com'"
  default     = "gfinnegan@corelogic.com"
}

variable "resolver_group" {
  description = "Support Owner/Group Email: Since GCP does not allow '@', don't include '@corelogic.com'. All email addresses are assumed to be '@corelogic.com'"
  default     = "gfinnegan@corelogic.com"
}


