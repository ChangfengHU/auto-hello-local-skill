#!/usr/bin/env bash
# local port source
set -euo pipefail

MODE=""
TOKEN="${HELLO_LOCAL_TOKEN:-}"
ENDPOINT_OVERRIDE=""
PORT=""
DOMAIN_NAME="hello-local"
AUTO_DOMAIN_TOKEN="${AUTO_DOMAIN_TOKEN:-}"

for arg in "$@"; do
  case "$arg" in
    --mode=*) MODE="${arg#--mode=}" ;;
    --token=*) TOKEN="${arg#--token=}" ;;
    --endpoint=*) ENDPOINT_OVERRIDE="${arg#--endpoint=}" ;;
    --port=*) PORT="${arg#--port=}" ;;
    --domain-name=*) DOMAIN_NAME="${arg#--domain-name=}" ;;
    --auto-domain-token=*) AUTO_DOMAIN_TOKEN="${arg#--auto-domain-token=}" ;;
    -h|--help)
      echo "Usage: $0 --mode=<mode> [--token=TOKEN] [--endpoint=URL]"
      exit 0
      ;;
  esac
done

if [[ -z "$MODE" ]]; then
  echo "Provide --mode or enough fields to infer one" >&2
  exit 1
fi

if [[ -z "$PORT" ]]; then
  echo "Provide --port=PORT (local service port to expose via auto-domain)" >&2
  exit 1
fi

AUTO_DOMAIN_CMD=(bash <(curl -fsSL https://skill.vyibc.com/auto-domain.sh) --port="$PORT" --name="$DOMAIN_NAME" --daemon)
if [[ -n "$AUTO_DOMAIN_TOKEN" ]]; then
  AUTO_DOMAIN_CMD+=(--token="$AUTO_DOMAIN_TOKEN")
fi
AUTO_DOMAIN_OUTPUT="$("${AUTO_DOMAIN_CMD[@]}")"
echo "$AUTO_DOMAIN_OUTPUT"
BASE_URL="$(printf '%s\n' "$AUTO_DOMAIN_OUTPUT" | sed -n 's/.*Public URL : //p' | tail -1)"
if [[ -z "$BASE_URL" ]]; then
  echo "Failed to allocate public URL through auto-domain" >&2
  exit 1
fi

TOKEN="${TOKEN#Bearer }"
TOKEN="${TOKEN#bearer }"

ENDPOINT="${BASE_URL}/"
if [[ -n "$ENDPOINT_OVERRIDE" ]]; then
  ENDPOINT="$ENDPOINT_OVERRIDE"
fi

COMMON_HEADERS=()
if [[ -n "$TOKEN" ]]; then
  COMMON_HEADERS+=(-H "Authorization: Bearer $TOKEN")
fi

echo "Calling hello-local..." >&2

case "$MODE" in
hello)
  PAYLOAD=$( python3 -c 'import json, os; keys = []; data = {}; [data.__setitem__(key, os.environ.get(key.upper().replace("-", "_").replace(".", "_")) or os.environ.get(key.upper().replace("-", "_"))) for key in keys if (os.environ.get(key.upper().replace("-", "_").replace(".", "_")) or os.environ.get(key.upper().replace("-", "_")))]; print(json.dumps(data))')
  curl --connect-timeout 10 --max-time 60 --fail-with-body -sS -L "$ENDPOINT" ${COMMON_HEADERS[@]+"${COMMON_HEADERS[@]}"} -H "Content-Type: application/json" -d "$PAYLOAD"
  ;;
  *)
    echo "Unsupported mode: $MODE" >&2
    exit 1
    ;;
esac
