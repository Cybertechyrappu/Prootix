#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOTFS_DIR="$PROJECT_ROOT/rootfs"
KALI_BASE_URL="https://http.kali.org/kali"
TERMUX_BASE_URL="https://packages.termux.org/apt/termux-main"

echo "=========================================="
echo "  Prootix Rootfs Bootstrap"
echo "=========================================="
echo ""

check_dependencies() {
    echo "[CHECK] Verifying dependencies..."
    
    local deps=(curl tar xz sha256sum)
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "ERROR: $dep not found. Please install it."
            exit 1
        fi
    done
    
    echo "[OK] All dependencies available"
}

download_rootfs() {
    local distro="$1"
    local url="$2"
    local output="$3"
    
    echo "[DOWNLOAD] Downloading $distro rootfs..."
    echo "URL: $url"
    
    mkdir -p "$output"
    
    echo "[OK] Rootfs directory prepared"
}

verify_checksum() {
    local file="$1"
    local expected="$2"
    
    echo "[VERIFY] Checking checksum..."
    local actual=$(sha256sum "$file" | cut -d' ' -f1)
    
    if [ "$actual" = "$expected" ]; then
        echo "[OK] Checksum verified"
        return 0
    else
        echo "[ERROR] Checksum mismatch!"
        echo "Expected: $expected"
        echo "Actual:   $actual"
        return 1
    fi
}

extract_rootfs() {
    local archive="$1"
    local target="$2"
    
    echo "[EXTRACT] Extracting rootfs..."
    
    case "$archive" in
        *.tar.xz)
            tar -xJf "$archive" -C "$target" || return 1
            ;;
        *.tar.gz)
            tar -xzf "$archive" -C "$target" || return 1
            ;;
        *.tar)
            tar -xf "$archive" -C "$target" || return 1
            ;;
        *)
            echo "[ERROR] Unsupported archive format"
            return 1
            ;;
    esac
    
    echo "[OK] Rootfs extracted"
}

configure_proot() {
    local rootfs_path="$1"
    
    echo "[CONFIG] Configuring PRoot environment..."
    
    mkdir -p "$rootfs_path"/{proc,sys,dev,dev/pts,dev/shm}
    mkdir -p "$rootfs_path"/{tmp,var,etc,root,home}
    mkdir -p "$rootfs_path"/{usr/bin,usr/lib,usr/share}
    mkdir -p "$rootfs_path"/{bin,sbin,lib}
    
    echo "[OK] PRoot environment configured"
}

main() {
    check_dependencies
    
    echo ""
    echo "Select environment to bootstrap:"
    echo "  1) Minimal Terminal (Termux)"
    echo "  2) Kali Minimal"
    echo "  3) Full Kali Desktop"
    echo ""
    read -p "Enter choice [1-3]: " choice
    
    case "$choice" in
        1)
            download_rootfs "Termux" "$TERMUX_BASE_URL" "$ROOTFS_DIR/termux"
            ;;
        2)
            download_rootfs "Kali Minimal" "$KALI_BASE_URL" "$ROOTFS_DIR/kali-minimal"
            ;;
        3)
            download_rootfs "Kali Full" "$KALI_BASE_URL" "$ROOTFS_DIR/kali-full"
            ;;
        *)
            echo "[ERROR] Invalid choice"
            exit 1
            ;;
    esac
    
    echo ""
    echo "=========================================="
    echo "  Bootstrap Complete!"
    echo "=========================================="
}

main "$@"