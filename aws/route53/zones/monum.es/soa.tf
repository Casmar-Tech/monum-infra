resource "aws_route53_record" "monum_es_soa" {
  zone_id = aws_route53_zone.monum_es.zone_id
  name    = "monum.es"
  type    = "SOA"
  ttl     = 900
  records = ["ns-522.awsdns-01.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
}
