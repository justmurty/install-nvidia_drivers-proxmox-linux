#!/bin/bash

# Скрипт за инсталиране на NVIDIA драйвери и зависимостите им на Proxmox с Debian 12

# Функция за потвърждение на действие с избор по подразбиране Y
confirm() {
    read -p "$1 (Y/n): " choice
    choice=${choice:-Y}
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        return 0
    elif [[ "$choice" =~ ^[Nn]$ ]]; then
        return 1
    else
        confirm "$1"
    fi
}

# Добавяне на Debian и Proxmox репозиторита
if confirm "Добавяне на Debian и Proxmox репозиторита?"; then
    echo "Configuring repositories..."
    
    # Добавяне на Proxmox GPG ключ
    wget -qO - https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg | gpg --dearmor -o /usr/share/keyrings/proxmox-archive-keyring.gpg
    
    # Конфигуриране на Proxmox репозитория
    cat <<EOF > /etc/apt/sources.list.d/pve-no-subscription.list
deb [signed-by=/usr/share/keyrings/proxmox-archive-keyring.gpg] http://download.proxmox.com/debian/pve bookworm pve-no-subscription
EOF

    # Конфигуриране на Debian репозиториите
    cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
EOF

    # Актуализиране на списъка с пакети
    echo "Updating package lists..."
    apt update || { echo "Failed to update package lists"; exit 1; }
else
    echo "Пропускане на конфигурацията на Debian и Proxmox репозиторита."
fi

# Инсталиране на Proxmox headers за текущото ядро
if confirm "Инсталиране на Proxmox headers за текущото ядро?"; then
    echo "Installing Proxmox headers..."
    apt install -y pve-headers-$(uname -r) || { echo "Failed to install Proxmox headers"; exit 1; }
else
    echo "Пропускане на инсталацията на Proxmox headers."
fi

# Инсталиране на необходимите пакети
if confirm "Инсталиране на NVIDIA драйвери, dkms и linux headers?"; then
    echo "Installing NVIDIA drivers, dkms, and Proxmox headers..."
    apt install -y nvidia-detect nvidia-driver dkms build-essential linux-headers-$(uname -r) || { echo "Failed to install NVIDIA drivers and dependencies"; exit 1; }
    dkms autoinstall || { echo "Failed to run dkms autoinstall"; exit 1; }
else
    echo "Пропускане на инсталацията на NVIDIA драйвери и зависимости."
fi

# Проверка на състоянието на NVIDIA драйвера
if confirm "Проверка на състоянието на NVIDIA драйвера с nvidia-smi?"; then
    echo "Checking NVIDIA driver status with nvidia-smi..."
    nvidia-smi || { echo "Failed to run nvidia-smi. Check if the drivers are installed correctly."; exit 1; }
else
    echo "Пропускане на проверката на NVIDIA драйвера."
fi

echo "Инсталацията завършена. Ако има грешки, проверете съобщенията по-горе."
