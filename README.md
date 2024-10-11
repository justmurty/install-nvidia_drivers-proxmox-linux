# Proxmox NVIDIA Настройка

## Обща информация

Този репозиторий съдържа скрипт за инсталиране на NVIDIA драйвери и необходимите зависимости на Proxmox VE хост, работещ под Debian 12 (Bookworm). Скриптът автоматизира процеса на настройка на необходимите хранилища, инсталиране на NVIDIA драйвери, DKMS и Proxmox headers, за да активира поддръжката на GPU за виртуални машини или контейнери.

## Скрипт: `install-nvidia-proxmox.sh`

### Какво прави

- Добавя Proxmox no-subscription хранилище към системата.
- Конфигурира Debian хранилищата с `main`, `contrib`, `non-free` и `non-free-firmware`.
- Актуализира списъка с пакети.
- Инсталира `nvidia-detect`, `nvidia-driver`, `dkms` и `pve-headers`.
- Проверява инсталацията на NVIDIA драйвера с помощта на `nvidia-smi`.

### Как да използвате

1. Клонирайте репозитория на вашия Proxmox сървър:

   ```bash
   git clone https://github.com/justmurty/proxmox-nvidia-setup.git
   cd proxmox-nvidia-setup

2. Направете скрипта изпълним и го стартирайте:

   ```bash
   chmod +x install-nvidia-proxmox.sh
   ./install-nvidia-proxmox.sh
