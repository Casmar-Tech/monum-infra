resource "aws_route53_record" "app_monum_es_cname" {
  name    = "app.monum.es"
  ttl     = 300
  type    = "CNAME"
  zone_id = aws_route53_zone.monum_es.zone_id

  records = [
    "cname.vercel-dns.com."
  ]
}
