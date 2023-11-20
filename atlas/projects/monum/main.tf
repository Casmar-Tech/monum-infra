resource "mongodbatlas_project" "project" {
  name   = local.atlas_project_name
  org_id = local.atlas_org_id

  is_collect_database_specifics_statistics_enabled = true
  is_realtime_performance_panel_enabled            = true
  is_performance_advisor_enabled                   = true
  is_schema_advisor_enabled                        = true
}
