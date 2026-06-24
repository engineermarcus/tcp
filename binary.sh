#!/data/data/com.termux/files/usr/bin/bash
# binary.sh — plug-and-play Tailscale installer for Termux
# Run this on a fresh phone: ./binary.sh
set -e

echo "=== Tailscale Termux: plug-and-play install ==="

echo "[1/5] Updating package lists..."
pkg update -y

echo "[2/5] Fixing any broken dependencies (covers the runit/termux-services gap)..."
apt --fix-broken install -y || true

echo "[3/5] Ensuring termux-services is present..."
pkg install -y termux-services

echo "[4/5] Running official tailscale-termux remote installer..."
curl -fsSL https://raw.githubusercontent.com/bropines/tailscale-termux-cli/main/remote-install.sh | bash

echo "[5/5] Finalizing package configuration..."
dpkg --configure -a || true

# Sanity check it's actually installed
if dpkg -l 2>/dev/null | grep -q "^ii.*tailscale-termux"; then
  echo ""
  echo "Tailscale-termux installed successfully."
else
  echo ""
  echo "WARNING: tailscale-termux does not show as fully installed (ii)."
  echo "Run 'dpkg -l | grep tailscale' manually to check."
  exit 1
fi

echo ""
echo "Starting tailscaled..."
tailscaled-start || echo "Could not auto-start — run 'tailscaled-start' manually."

echo ""
echo "Next step (one-time, manual): authenticate with"
echo "  tailscale-cli up"
echo ""
echo "It will print a login URL — open it in any browser to authorize this device."
echo ""
echo "After that, get your permanent Tailscale IP with:"
echo "  tailscale-cli ip -4"
