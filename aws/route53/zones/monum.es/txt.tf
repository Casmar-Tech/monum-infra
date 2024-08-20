resource "aws_route53_record" "_canva_domain_verify_monum_es_a" {
  name    = "_canva-domain-verify.monum.es"
  ttl     = 300
  type    = "TXT"
  zone_id = aws_route53_zone.monum_es.zone_id

  records = [
    "39d9ae15-c8de-40ec-b34d-e118bf808140"
  ]
}
