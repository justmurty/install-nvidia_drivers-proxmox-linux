# Proxmox NVIDIA Настройка

## Обща информация

Този репозиторий съдържа скрипт за инсталиране на NVIDIA драйвери и необходимите зависимости на Proxmox VE хост, работещ под Debian 12 (Bookworm). Скриптът автоматизира процеса на настройка на необходимите хранилища, инсталиране на NVIDIA драйвери, DKMS и Proxmox headers, за да активира поддръжката на GPU за виртуални машини или контейнери.

## Скрипт: `install-nvidia-proxmox.sh`

### Какво прави

- Добавя Proxmox no-subscription хранилище към системата и инсталира `pve-headers`
- Конфигурира Debian хранилищата с `main`, `contrib`, `non-free` и `non-free-firmware`.
- Актуализира списъка с пакети.
- Инсталира `nvidia-detect`, `nvidia-driver`, `dkms` и `linux-headers`.
- Проверява инсталацията на NVIDIA драйвера с помощта на `nvidia-smi`.

### Как да използвате

1. Изтеглете скрипта:

   ```bash
   wget https://raw.githubusercontent.com/justmurty/install-nvidia_drivers-proxmox-linux/refs/heads/main/install-nvidia-drivers.sh

2. Направете скрипта изпълним и го стартирайте:

   ```bash
   chmod +x install-nvidia-drivers.sh
   ./install-nvidia-drivers.sh
