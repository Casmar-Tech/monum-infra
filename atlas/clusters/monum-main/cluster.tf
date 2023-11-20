resource "mongodbatlas_advanced_cluster" "cluster" {
  project_id             = local.atlas_project_id
  name                   = local.atlas_cluster_name
  cluster_type           = "REPLICASET"
  mongo_db_major_version = "6.0"
  replication_specs {
    region_configs {
      electable_specs {
        instance_size = "M0"
      }
      provider_name         = "TENANT"
      backing_provider_name = "AWS"
      region_name           = "EU_WEST_1"
      priority              = 7
    }
  }
}
