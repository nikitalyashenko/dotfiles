#!/bin/bash
set -e

echo "=== 1. Создаём конфиг nvidia modprobe ==="
sudo tee /etc/modprobe.d/nvidia.conf << 'EOF'
options nvidia-drm modeset=1
options nvidia NVreg_UsePageAttributeTable=1
EOF

echo "=== 2. Добавляем параметр ядра в bootloader ==="
sudo sed -i 's/^options\t/options\tnvidia-drm.modeset=1 /' /boot/loader/entries/arch.conf
sudo sed -i 's/^options\t/options\tnvidia-drm.modeset=1 /' /boot/loader/entries/arch-lts.conf

echo "=== 3. Обновляем picom.conf ==="
cat > ~/.config/picom.conf << 'EOF'
backend = "glx";
vsync = true;
glx-no-stencil = true;
glx-no-rebind-pixmap = true;
use-damage = true;
unredir-if-possible = false;
xrender-sync-fence = true;
EOF

echo "=== 4. Применяем ForceCompositionPipeline (280Hz остаётся) ==="
nvidia-settings --assign CurrentMetaMode="DP-0: 1920x1080_280 +1920+0 {ForceCompositionPipeline=On}, HDMI-0: 1920x1080_60 +3840+0 {ForceCompositionPipeline=On}, HDMI-1: 1920x1080_60 +0+0 {ForceCompositionPipeline=On}"

echo "=== 5. Сохраняем конфиг nvidia в xorg ==="
sudo nvidia-settings --save /etc/X11/xorg.conf

echo "=== 6. Пересобираем initramfs ==="
sudo mkinitcpio -P

echo ""
echo "=== Готово! Перезагрузись командой: sudo reboot ==="
