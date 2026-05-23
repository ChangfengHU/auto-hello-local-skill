---
name: hello-local
description: "当用户说"hello-local"、"调用 hello-local"、"hello local 服务" 时自动触发。调用本地 hello 服务（通过 auto-domain 隧道暴露到公网）"
---

# Hello Local

## 作用

调用本地 hello 服务（通过 auto-domain 隧道暴露到公网）

## 执行

```bash
~/.claude/skills/hello-local/scripts/run.sh 
```

## 直接执行

```bash
bash <(curl -fsSL https://skill.vyibc.com/hello-local.sh)
```

