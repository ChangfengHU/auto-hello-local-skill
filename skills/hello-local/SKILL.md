---
name: hello-local
description: "当用户说"hello-local"、"调用 hello-local"、"使用 hello-local" 时自动触发。将本地 HTTP 服务通过 auto-domain 暴露为公网能力，返回 Hello from Cloudflare Worker! 🚀。"
---

# Hello Local

## 作用

将本地 HTTP 服务通过 auto-domain 暴露为公网能力，返回 Hello from Cloudflare Worker! 🚀。

## 执行

```bash
~/.claude/skills/hello-local/scripts/run.sh --mode=hello --port=18091 --domain-name=hello-local --auto-domain-token=atd-76631b52126234666e0a12c6f45ac6d8
```

## 直接执行

```bash
bash <(curl -fsSL https://skill.vyibc.com/hello-local.sh)
```

