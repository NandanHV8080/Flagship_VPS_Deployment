# DNS

The domain is managed at GoDaddy. Web traffic points at the VPS; email is handled separately by Zoho and its records are unchanged.

| Type | Name | Value |
|------|------|-------|
| A | @ | 18.196.205.88  |
| A | www | 18.196.205.88  |

Previous hosting records were removed (Vercel CNAME for www, old A record for @).

Verified with `nslookup vedrion.com 8.8.8.8` (both names resolve to the VPS).
