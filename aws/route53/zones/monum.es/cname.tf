resource "aws_route53_record" "www_monum_es_cname" {
  name    = "www.monum.es"
  ttl     = 300
  type    = "CNAME"
  zone_id = aws_route53_zone.monum_es.zone_id

  records = [
    "cname.vercel-dns.com."
  ]
}
