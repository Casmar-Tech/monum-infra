resource "aws_route53domains_registered_domain" "monum_es" {
  domain_name        = "monum.es"
  auto_renew         = true
  admin_privacy      = true
  registrant_privacy = true
  tech_privacy       = true
  transfer_lock      = false
  lifecycle {
    ignore_changes = [admin_contact, registrant_contact, tech_contact, name_server]
  }
}
