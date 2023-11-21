resource "aws_ses_domain_identity" "monum_es" {
  domain = "monum.es"
}

resource "aws_route53_record" "monum_es_amazonses_verification_record" {
  zone_id = local.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.monum_es.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.monum_es.verification_token]
}

resource "aws_ses_domain_dkim" "monum_es_dkim" {
  domain = aws_ses_domain_identity.monum_es.domain
}

resource "aws_route53_record" "monum_es_amazonses_dkim_record" {
  count   = 3
  zone_id = local.zone_id
  name    = "${aws_ses_domain_dkim.monum_es_dkim.dkim_tokens[count.index]}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${aws_ses_domain_dkim.monum_es_dkim.dkim_tokens[count.index]}.dkim.amazonses.com"]
}

resource "aws_ses_domain_identity_verification" "monum_es_verification" {
  domain = aws_ses_domain_identity.monum_es.id

  depends_on = [
    aws_route53_record.monum_es_amazonses_verification_record,
    aws_ses_domain_dkim.monum_es_dkim,
    aws_route53_record.monum_es_amazonses_dkim_record
  ]
}

resource "aws_ses_domain_mail_from" "monum_es_mail_from" {
  domain           = aws_ses_domain_identity.monum_es.domain
  mail_from_domain = "hostmaster.${aws_ses_domain_identity.monum_es.domain}"
}

resource "aws_route53_record" "monum_es_ses_domain_mail_from_mx" {
  zone_id = local.zone_id
  name    = aws_ses_domain_mail_from.monum_es_mail_from.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.eu-west-1.amazonses.com"]
}

resource "aws_route53_record" "monum_es_ses_domain_mail_from_txt" {
  zone_id = local.zone_id
  name    = aws_ses_domain_mail_from.monum_es_mail_from.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}
