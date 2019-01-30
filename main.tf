terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "consul" {}
}

# Template provider
provider "template" {
  version = "~> 1.0"
}

# Get the project data
data "rancher_environment" "project" {
  name = "${var.project_name}"
}



# Deploy Elasticsearch master stack
data "template_file" "docker_compose_master" {
  count = "${var.role == "master" ? 1 : 0}"
  template = "${file("${path.module}/rancher/elasticsearch-master/docker-compose.yml")}"

  vars {
    logstash_password       = "${var.logstash_password}"
    kibana_password         = "${var.kibana_password}"
    elastic_password        = "${var.elastic_password}"
    enable_monitoring       = "${var.enable_monitoring}"
    monitoring_url          = "${var.monitoring_url}"
    monitoring_user         = "${var.monitoring_user}"
    monitoring_password     = "${var.monitoring_password}"
    ldap_primary_server     = "${var.ldap_primary_server}"
    ldap_secondary_server   = "${var.ldap_secondary_server}"
    ldap_user_search        = "${var.ldap_user_search}"
    ldap_group_search       = "${var.ldap_group_search}"
    ldap_password           = "${var.ldap_password}"
    ldap_user               = "${var.ldap_user}"
    label_global_scheduling = "${var.label_global_scheduling}"
    storage_driver          = "${var.storage_driver}"
    data_path               = "${var.data_path}"
    log_path                = "${var.log_path}"
    cluster_name            = "${var.cluster_name}"
    jvm_memory              = "${var.jvm_memory}"
    container_memory        = "${var.container_memory}"
    es_version              = "${var.image_version}"
    xpack_volume            = "${var.xpack_volume}"
    cpu_shares              = "${var.cpu_shares}"
  }
}
data "template_file" "rancher_compose_master" {
  count = "${var.role == "master" ? 1 : 0}"
  template = "${file("${path.module}/rancher/elasticsearch-master/rancher-compose.yml")}"

  vars {
  }
}
resource "rancher_stack" "this_master" {
  count = "${var.role == "master" ? 1 : 0}"
  name            = "${var.stack_name}"
  description     = "Elasticsearch - Master role"
  environment_id  = "${data.rancher_environment.project.id}"
  scope           = "user"
  start_on_create = true
  finish_upgrade  = "${var.finish_upgrade}"
  docker_compose  = "${data.template_file.docker_compose_master.rendered}"
  rancher_compose = "${data.template_file.rancher_compose_master.rendered}"
}



# Deploy Elasticsearch client stack
data "template_file" "docker_compose_client" {
  count = "${var.role == "client" ? 1 : 0}"
  template = "${file("${path.module}/rancher/elasticsearch-client/docker-compose.yml")}"

  vars {
    master_stack            = "${var.master_stack}"
    enable_monitoring       = "${var.enable_monitoring}"
    elastic_password        = "${var.elastic_password}"
    monitoring_url          = "${var.monitoring_url}"
    monitoring_user         = "${var.monitoring_user}"
    monitoring_password     = "${var.monitoring_password}"
    ldap_primary_server     = "${var.ldap_primary_server}"
    ldap_secondary_server   = "${var.ldap_secondary_server}"
    ldap_user_search        = "${var.ldap_user_search}"
    ldap_group_search       = "${var.ldap_group_search}"
    ldap_password           = "${var.ldap_password}"
    ldap_user               = "${var.ldap_user}"
    label_global_scheduling = "${var.label_global_scheduling}"
    storage_driver          = "${var.storage_driver}"
    data_path               = "${var.data_path}"
    log_path                = "${var.log_path}"
    cluster_name            = "${var.cluster_name}"
    jvm_memory              = "${var.jvm_memory}"
    container_memory        = "${var.container_memory}"
    es_version              = "${var.image_version}"
    xpack_volume            = "${var.xpack_volume}"
    cpu_shares              = "${var.cpu_shares}"
  }
}
data "template_file" "rancher_compose_client" {
  count = "${var.role == "client" ? 1 : 0}"
  template = "${file("${path.module}/rancher/elasticsearch-client/rancher-compose.yml")}"

  vars {
  }
}
resource "rancher_stack" "this_client" {
  count           = "${var.role == "client" ? 1 : 0}"
  name            = "${var.stack_name}"
  description     = "Elasticsearch - Client role"
  environment_id  = "${data.rancher_environment.project.id}"
  scope           = "user"
  start_on_create = true
  finish_upgrade  = "${var.finish_upgrade}"
  docker_compose  = "${data.template_file.docker_compose_client.rendered}"
  rancher_compose = "${data.template_file.rancher_compose_client.rendered}"
}

# Deploy Elasticsearch data stack
data "template_file" "docker_compose_data" {
  count = "${var.role == "data" ? 1 : 0}"
  template = "${file("${path.module}/rancher/elasticsearch-data/docker-compose.yml")}"

  vars {
    master_stack            = "${var.master_stack}"
    elastic_password        = "${var.elastic_password}"
    enable_monitoring       = "${var.enable_monitoring}"
    monitoring_url          = "${var.monitoring_url}"
    monitoring_user         = "${var.monitoring_user}"
    monitoring_password     = "${var.monitoring_password}"
    ldap_primary_server     = "${var.ldap_primary_server}"
    ldap_secondary_server   = "${var.ldap_secondary_server}"
    ldap_user_search        = "${var.ldap_user_search}"
    ldap_group_search       = "${var.ldap_group_search}"
    ldap_password           = "${var.ldap_password}"
    ldap_user               = "${var.ldap_user}"
    label_global_scheduling = "${var.label_global_scheduling}"
    storage_driver          = "${var.storage_driver}"
    data_path               = "${var.data_path}"
    log_path                = "${var.log_path}"
    cluster_name            = "${var.cluster_name}"
    jvm_memory              = "${var.jvm_memory}"
    container_memory        = "${var.container_memory}"
    es_version              = "${var.image_version}"
    xpack_volume            = "${var.xpack_volume}"
    cpu_shares              = "${var.cpu_shares}"
  }
}
data "template_file" "rancher_compose_data" {
  count = "${var.role == "data" ? 1 : 0}"
  template = "${file("${path.module}/rancher/elasticsearch-data/rancher-compose.yml")}"

  vars {
  }
}
resource "rancher_stack" "this_data" {
  count           = "${var.role == "data" ? 1 : 0}"
  name            = "${var.stack_name}"
  description     = "Elasticsearch - Data role"
  environment_id  = "${data.rancher_environment.project.id}"
  scope           = "user"
  start_on_create = true
  finish_upgrade  = "${var.finish_upgrade}"
  docker_compose  = "${data.template_file.docker_compose_data.rendered}"
  rancher_compose = "${data.template_file.rancher_compose_data.rendered}"
}
