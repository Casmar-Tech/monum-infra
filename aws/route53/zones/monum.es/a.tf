resource "aws_route53_record" "monum_es_a" {
  name    = "monum.es"
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone.monum_es.zone_id

  records = [
    "103.169.142.0"
  ]
}

resource "aws_route53_record" "www_monum_es_a" {
  name    = "www.monum.es"
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone.monum_es.zone_id

  records = [
    "103.169.142.0"
  ]
}
