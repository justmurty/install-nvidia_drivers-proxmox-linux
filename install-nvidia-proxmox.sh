#!/bin/bash

# Скрипт за инсталиране на NVIDIA драйвери и зависимостите им на Proxmox с Debian 12

# Добавяне на Proxmox no-subscription repository
echo "Adding Proxmox no-subscription repository..."
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-enterprise.list

# Добавяне на Debian репозиторита
echo "Configuring Debian repositories..."
cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
EOF

# Актуализиране на списъка с пакети
echo "Updating package lists..."
apt update

# Инсталиране на необходимите пакети
echo "Installing NVIDIA drivers, dkms, and Proxmox headers..."
apt install -y nvidia-detect nvidia-driver dkms pve-headers

# Проверка на състоянието на NVIDIA драйвера
echo "Checking NVIDIA driver status with nvidia-smi..."
nvidia-smi

echo "Installation complete. If you encounter any errors, please check the output above."
