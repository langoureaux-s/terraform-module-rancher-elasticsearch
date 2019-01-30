# terraform-module-rancher-elasticsearch

This module permit to deploy Elasticsearch stack on Rancher 1.6.x.

```
terragrunt = {
  terraform {
    source = "git::https://github.com/langoureaux-s/terraform-module-rancher-elasticsearch.git"
  }
  
  
  project_name            = "test"
  stack_name              = "elasticsearch-data"
  finish_upgrade          = "true"
  storage_driver          = "rancher-nfs"
  label_global_scheduling = "elasticsearch.master"
  role                    = "master"
  cluster_name            = "version"
  elastic_password        = "y1546n02h482I1u"
  kibana_password         = "y1546n02h482I1u2"
  logstash_password       = "y1546n02h482I1u3"
  enable_monitoring       = "false"
  ldap_primary_server"    = "dc1.domain.com"
  ldap_secondary_server   = "dc2.domain.com"
  ldap_user_search        = "OU=Users,DC=DOMAIN,DC=COM"
  ldap_group_search       = "OU=Groups,DC=DOMAIN,DC=COM"
  ldap_user               = "CN=ldap-user,OU=Users,DC=DOMAIN,DC=COM"
  ldap_password           = "y1546n02h482I1u4"
  data_path               = "/data/elasticsearch"
  log_path                = "/var/log/elasticsearch"
  jvm_memory              = "2g"
  container_memory        = "4g"
}
```

There are some optionnal parameters, so read the file `variables.tf`.

> If you deploy Elasticsearch with client or data role, you need to use parameter `master_stack` to generate external link.