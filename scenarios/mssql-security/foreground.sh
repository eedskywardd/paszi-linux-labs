#!/usr/bin/env bash
echo 'ПАСЗИ №17: подготавливается Microsoft SQL Server.'
echo 'Это облачная лаборатория: ничего устанавливать на компьютер не нужно.'
for i in $(seq 1 90); do
  if [ -f /root/PASZI17_READY ]; then
    echo '✓ Готово. Команда для начала: sql17'
    exit 0
  fi
  if [ -f /root/PASZI17_ERROR ]; then
    echo '✗ Ошибка настройки стенда; это НЕ ошибка студента.'
    echo 'Сообщите преподавателю, он проверит диагностический журнал.'
    exit 1
  fi
  if [ "$(( i % 6 ))" -eq 1 ]; then
    printf 'Подготовка: '
    cat /root/PASZI17_STATUS 2>/dev/null || echo STARTING
  fi
  sleep 5
done
echo 'Сервер долго подготавливается. Команда проверки: paszi17-status'
echo 'Если вы не видите приглашение терминала, возможно, Killercoda ограничила запуск среды.'
