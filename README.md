# hello-local

调用本地 hello 服务（通过 auto-domain 隧道暴露到公网）

---

## 1. 直接执行 CLI

不需要安装 skill，一条命令直接调用：

```bash
bash <(curl -fsSL https://skill.vyibc.com/hello-local.sh) 
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
- `hello local 服务`

---

## 3. 支持的调用模式

| 模式 | 说明 |
|------|------|
| `hello` | 调用 hello 接口 |

---

## 本地服务说明

本 skill 通过 auto-domain 隧道调用本地服务，公网地址固定为：

```
https://hello-local.chxyka.ccwu.cc
```

调用前请先在本地启动服务，并运行 auto-domain 将端口打洞到公网：

```bash
bash <(curl -fsSL https://skill.vyibc.com/auto-domain.sh) --port=PORT --name=hello-local --daemon
```

Skill 本身不需要任何 `--port` 或 `--domain-name` 参数，直接 `--mode=...` 调用即可。

---

## 4. 调用示例

### 调用 hello

```bash
bash <(curl -fsSL https://skill.vyibc.com/hello-local.sh) --mode=hello
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
