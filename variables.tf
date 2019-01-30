variable "project_name" {
    description = "The project name (environment name)"
}
variable "stack_name" {
    description = "The name for the Elasticsearch stack"
}
variable "finish_upgrade" {
  description = "Automatically finish upgrade on Rancher when apply new plan"
}
variable "storage_driver" {
  description = "Storage driver to use for docker volume"
}

variable "label_global_scheduling" {
  description = "The label to use when schedule this stack as global scheduling"
}

variable "role" {
  description = "The Elasticsearch role (master, data, client or all)"
}
variable "cluster_name" {
  description = "The cluster name in Elasticsearch"
}
variable "image_version" {
  description = "The image version of Elasticsearch to use"
  default = "6.5.4-1"
}
variable "elastic_password" {
  description = "The elastic password"
  default = ""
}
variable "kibana_password" {
  description = "The kibana password"
  default = ""
}
variable "logstash_password" {
  description = "The logstash password"
  default = ""
}
variable "master_stack" {
  description = "The master stack name stack_name/service_name"
  default = ""
}

variable "xpack_volume" {
  description = "The volume name to store xpack persistent data"
  default = "elasticsearch_conf_xpack"
}

variable "enable_monitoring" {
  description = "Permit to enable/disable the monitoring"
}
variable "monitoring_url" {
  description = "The Elasticsearch target host to send monitoring data"
  default = ""
}
variable "monitoring_user" {
  description = "The user to use when call to monitoring cluster"
  default = ""
}
variable "monitoring_password" {
  description = "The password to use when call to monitoring cluster"
  default = ""
}

variable "ldap_primary_server" {
  description = "The first ldap server to use"
}
variable "ldap_secondary_server" {
  description = "The second ldap server to use"
}
variable "ldap_user_search" {
  description = "The container where to search user"
}
variable "ldap_group_search" {
  description = "The container where to search group"
}
variable "ldap_user" {
  description = "The ldap user to browse"
}
variable "ldap_password" {
  description = "The ldap password to browse"
}


variable "data_path" {
  description = "The data path for Elasticsearch"
}
variable "log_path" {
  description = "The log path for Elasticsearch"
}
variable "jvm_memory" {
  description = "The JVM memory affected to Elasticsearch"
}
variable "container_memory" {
  description = "The maximum of memory that Elasticsearch container can consume"
}
variable "cpu_shares" {
  description = "The maximum of CPU usage that Elasticsearch container can consume"
  default = "1024"
}

variable "recover_after_nodes" {
  description = "Recover as long as this many data or master nodes have joined the cluster."
  default = ""
}
variable "recover_after_master_nodes" {
  description = "Recover as long as this many master nodes have joined the cluster."
  default = ""
}
variable "recover_after_data_nodes" {
  description = "Recover as long as this many data nodes have joined the cluster."
  default = ""
}
variable "expected_nodes" {
  description = "The number of (data or master) nodes that are expected to be in the cluster. Recovery of local shards will start as soon as the expected number of nodes have joined the cluster"
  default = ""
}
variable "expected_master_nodes" {
  description = "The number of master nodes that are expected to be in the cluster. Recovery of local shards will start as soon as the expected number of master nodes have joined the cluster"
  default = ""
}
variable "expected_data_nodes" {
  description = "The number of data nodes that are expected to be in the cluster. Recovery of local shards will start as soon as the expected number of data nodes have joined the cluster"
  default = ""
}
variable "minimum_master_nodes" {
  description = "sets the minimum number of master eligible nodes that need to join a newly elected master in order for an election to complete and for the elected node to accept its mastership. The same setting controls the minimum number of active master eligible nodes that should be a part of any active cluster. If this requirement is not met the active master node will step down and a new master election will begin."
}
variable "master_hosts" {
  description = "sets the masters hostnames or IP to use when discover"
  type = "list"
}






