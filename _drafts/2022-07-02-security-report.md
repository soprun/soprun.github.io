---
permalink: /security-report
title: Domain Security Report soprun.com
categories: [security]
tags: [security, tools, http headers, owasp]
image: https://images.unsplash.com/photo-1618482914248-29272d021005
---

Небольшой анализ безопасности домена, сайта и email 🔐

Сайт soprun.com соответствует рекомендациям по безопасности OWASP.
От базовых [OWASP Secure Headers Project](https://owasp.org/www-project-secure-headers/#div-headers) до инфраструктурной
безопасности.

Рекомендую к изучению:
[Топ-10 OWASP. Десять самых критичных угроз безопасности веб-приложений](https://wiki.owasp.org/images/9/96/OWASP_Top_10-2017-ru.pdf)

[//]: # (<i class="fa-solid fa-file-pdf fs-4"></i>)

А также сервисы где вы можете проверить ваш проект на безопасность по OWASP Secure Headers!

<!--more-->

## Отчеты и сервисы для тестирования

<blockquote class="imgur-embed-pub" lang="en" data-id="a/stXwx0k" data-context="false" >
  <a href="//imgur.com/a/stXwx0k"></a>
</blockquote>

<script async src="//s.imgur.com/min/embed.js" charset="utf-8"></script>

- [ssllabs.com](https://www.ssllabs.com/ssltest/analyze.html?d=soprun.com) - Grade **A+** ✅
- [findsecuritycontacts.com](https://findsecuritycontacts.com/query/soprun.com) - Grade **A+** ✅
- [dnschecker.org](https://dnschecker.org/domain-health-checker.php?query=soprun.com) - Grade **A+** ✅
- [securityheaders.com](https://securityheaders.com/?q=https%3A%2F%2Fsoprun.com&followRedirects=on) - Grade **A+** ✅
- [hardenize.com](https://www.hardenize.com/report/soprun.com/1656790664) - Grade **A+** ✅

---

Сайт разработан с использованием [Jekyll](https://github.com/mojombo/jekyll), развертывание и хостинг
в [Cloudflare Pages](https://developers.cloudflare.com/pages/)

Для обеспечения безопасности, мониторинга,уведомлений использую:

- [sentry.io](https://sentry.io) - Error Reporting, Content Security Policy, XSS-Protection, Expect-CT, CROSS
- [report-uri.com](https://report-uri.com) - SMTP, DMARC, API, TLS-RPT Reporting & Network Error Logging
- ~~[slack.com](https://slack.com)~~

## Так же я использую инструменты

- Cloudflare Workers
- Cloudflare KV works
- Cloudflare SSL/TLS
- Cloudflare Page Rules
- Cloudflare DNS
- Cloudflare Analytics (Web, DNS, etc.)
- etc.

## Email

Решил попробовать [Custom Email Domain with iCloud Mail](https://support.apple.com/en-us/HT212514), не могу сказать что
удовлетворен сервисом, скорее всего в будущем буду менять.

### Конфиденциальность, высокая безопасность

- Все полученные письма и отправленные мною подписаны GPG ключами через физическую аппаратное устройство YubiKey.
- Подтвержденный DNSSEC - ✅
- Sender Policy Framework (SPF) - ✅
- Domain-based Message Authentication Reporting and Conformance (DMARC) - ✅
- DomainKeys Identified Mail (DKIM) - ✅
- Cloudflare Email Routing - ✅
- etc.

## Environments

| Environment | Domain and aliases                            | Privacy          |
|:------------|:----------------------------------------------|------------------|
| `production`  | <https://soprun.com>                          | `Public`           |
| `staging`     | <https://staging.soprun.com>                  | `Zero Trust (VPN)` |
| `preview`     | <https://{branch}.soprun-github-io.pages.dev> | `Zero Trust (VPN)` |
| `local`       | <http://localhost:4000>                       | `localhost`        |
