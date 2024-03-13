resource "aws_route53_record" "monum_es_a" {
  name    = "monum.es"
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone.monum_es.zone_id

  records = [
    "76.76.21.21"
  ]
}
