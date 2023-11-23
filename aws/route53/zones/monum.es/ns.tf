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

resource "aws_route53_record" "api_monum_es_ns" {
  name    = "api.monum.es"
  ttl     = 172800
  type    = "NS"
  zone_id = aws_route53_zone.monum_es.zone_id

  records = [
    "ns-1127.awsdns-12.org.",
    "ns-1965.awsdns-53.co.uk.",
    "ns-757.awsdns-30.net.",
    "ns-126.awsdns-15.com.",
  ]
}
