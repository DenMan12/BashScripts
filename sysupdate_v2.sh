#!/bin/bash

# Настройки
LOG_FILE="/var/log/sysupdate.log"

{
    echo "==================== $(date) ===================="
    
    # Проверяем обновления
    updates_list=$(checkupdates 2>/dev/null)
    updates_count=$(echo "$updates_list" | grep -v '^$' | wc -l)
    
    if [ $updates_count -gt 0 ]; then
        echo "Найдено $updates_count обновлений:"
        echo "$updates_list"
        echo "---"
        echo "Начинаю обновление..."
        
        # Обновляем систему (без sudo!)
        pacman -Syu --noconfirm
        
        if [ $? -eq 0 ]; then
            echo "✅ Система успешно обновлена!"
        else
            echo "❌ ОШИБКА при обновлении!"
        fi
    else
        echo "ℹ️ Обновлений нет"
    fi
    
    echo "================================================"
} | tee -a "$LOG_FILE"
