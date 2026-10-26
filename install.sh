#!/usr/bin/env sh
# 学习陪跑团（study-squad）一键安装脚本
# 用法：把本仓库克隆或解压到任意位置后，在仓库根目录执行 sh install.sh
set -e

NAME="study-squad"
SRC=$(cd "$(dirname "$0")" && pwd)
CONFIG_DIR="${WORKBUDDY_CONFIG_DIR:-$HOME/.workbuddy}"
DEST="$CONFIG_DIR/plugins/marketplaces/my-experts/plugins"

echo "==> 目标目录：$DEST/$NAME"
mkdir -p "$DEST/$NAME"

# 复制内容但排除 .git 与安装脚本自身
tar -C "$SRC" --exclude=.git --exclude=install.sh -cf - . | tar -C "$DEST/$NAME" -xf -
echo "==> 文件已复制"

# 尝试自动注册（需要 python3 且能找到 WorkBuddy 自带的注册脚本）
REG=$(find "$CONFIG_DIR/.." -name register_expert.py -path "*expert-manager*" 2>/dev/null | head -n 1)
if [ -z "$REG" ]; then
  REG=$(find /Applications "$HOME/AppData/Local/Programs" -name register_expert.py -path "*expert-manager*" 2>/dev/null | head -n 1)
fi

if [ -n "$REG" ] && command -v python3 >/dev/null 2>&1; then
  echo "==> 注册专家：$REG"
  python3 "$REG" "$DEST/$NAME"
else
  echo ""
  echo "已复制完成，但未能自动注册。请手动执行："
  echo "  python3 <WorkBuddy 安装目录>/resources/app.asar.unpacked/resources/plugins/workbuddy-builtin/skills/expert-manager/scripts/register_expert.py \"$DEST/$NAME\""
fi

echo ""
echo "✅ 安装完成。重启或刷新 WorkBuddy 后，在【专家中心 - 我的专家】启用「学习陪跑团」。"
