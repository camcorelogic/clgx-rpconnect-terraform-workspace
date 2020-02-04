environment = "uat"
project_name = "clgx-clasia-jira-conf-uat"
project_id = "clgx-clasia-jira-conf-uat-c313"

network_project_id = "clgx-network-nonprd-4dd3"
network = "projects/clgx-network-nonprd-4dd3/global/networks/clgx-vpc-au-nonprd"
subnetwork = "clgx-mgt-general-au-se1-stg-subnet"

# network_tags_web = '"allow-ssh", "allow-int-http", "allow-dl-health-checks"'
# network_tags_web = "allow-ssh, allow-int-http, allow-dl-health-checks"

region = "australia-southeast1"
zones = "australia-southeast1-a"

terraform_service_account = "tf-clgx-clasia-jira-conf-uat@clgx-clasia-jira-conf-uat-c313.iam.gserviceaccount.com"
jumpbox_service_account = "ans-clgx-clasia-jira-conf-uat@clgx-clasia-jira-conf-uat-c313.iam.gserviceaccount.com"
jira_service_account = "jira-conf-jira-sa@clgx-clasia-jira-conf-uat-c313.iam.gserviceaccount.com"
conf_service_account = "jira-conf-conf-sa@clgx-clasia-jira-conf-uat-c313.iam.gserviceaccount.com"
pgres_service_account = "jira-conf-pgres-sa@clgx-clasia-jira-conf-uat-c313.iam.gserviceaccount.com"

boot_image = "projects/clgx-imgfact-repo-glb-prd-f2a0/global/images/cl-centos-7-v20190228-45"
boot_image_ubuntu = "projects/clgx-imgfact-repo-glb-prd-f2a0/global/images/cl-ubuntu-1604-xenial-v20191114-146"
