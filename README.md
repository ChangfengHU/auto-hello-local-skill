# hello-local

将本地 HTTP 服务通过 auto-domain 暴露为公网能力，返回 Hello from Cloudflare Worker! 🚀。

---

## 1. 直接执行 CLI

不需要安装 skill，一条命令直接调用：

```bash
bash <(curl -fsSL https://skill.vyibc.com/hello-local.sh) --mode=hello --port=18091 --domain-name=hello-local
```

---

## 2. 安装为 Claude Code Skill

```bash
bash <(curl -fsSL 'https://skill.vyibc.com/install-hello-local.sh')
```

安装后 skill 会写入：

- `~/.claude/skills/hello-local/SKILL.md`
- `~/.claude/skills/hello-local/scripts/run.sh`

### 安装完成后如何使用

对 Claude 说以下任意一句，skill 会自动触发：

- `hello-local`
- `调用 hello-local`
- `使用 hello-local`

---

## 3. 支持的调用模式

| 模式 | 说明 |
|------|------|
| `hello` | 调用本地服务，返回问候语。 |

---

## 本地服务说明

本项目通过 auto-domain 将本地 HTTP 服务暴露为公网能力。调用时必须提供：

- `--port=PORT` 本地服务监听的端口
- `--domain-name=NAME` 分配的公网子域名（如 `myapp` → `myapp.chxyka.ccwu.cc`）
- `--auto-domain-token=TOKEN` auto-domain 认证 token

---

## 4. 调用示例

### 通过 auto-domain 暴露并调用

```bash
bash <(curl -fsSL https://skill.vyibc.com/hello-local.sh) --mode=hello --port=18091 --domain-name=hello-local
```

---

## 5. 发布

本地发布（需在仓库目录下）：

```bash
./scripts/publish-skill.sh
```

从 GitHub `main` 远程发布：

```bash
bash <(curl -fsSL https://skill.vyibc.com/publish-hello-local.sh)
```

---

## 6. 仓库结构

```text
README.md
scripts/
  hello-local.sh                    # CLI 直接执行入口
  publish-hello-local.sh             # 远程一键发布
  publish-skill.sh             # 本地发布
  upload-file.sh               # R2 上传工具
skills/
  hello-local/
    SKILL.md                   # Claude Code skill 定义
    scripts/run.sh             # 唯一核心执行逻辑
```

`scripts/hello-local.sh` 和安装后的 `skills/hello-local/scripts/run.sh` 来自同一份脚本。
