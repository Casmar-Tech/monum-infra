resource "aws_route53_record" "monum_es_ns" {
  name    = "monum.es"
  ttl     = 172800
  type    = "NS"
  zone_id = aws_route53_zone.monum_es.zone_id

  records = [
    "${aws_route53_zone.monum_es.name_servers[0]}.",
    "${aws_route53_zone.monum_es.name_servers[1]}.",
    "${aws_route53_zone.monum_es.name_servers[2]}.",
    "${aws_route53_zone.monum_es.name_servers[3]}.",
  ]
}
