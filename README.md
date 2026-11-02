# Test_task_Effective_Mobile
Выполненное тестовое задание от Effective Mobile за 2025 год. https://github.com/9868-08/Effective-Mobile 

Выполнены требования: 1, 2, 3, 5. Не выполненное требование: 4, причина описана в word файле

monitoring.sh — основной скрипт (комментарии внутри поясняют каждый блок)
monitoring.service — systemd-юнит, запускающий скрипт
monitoring.timer — таймер, дёргающий сервис каждую минуту

Проверка проводилась копированием бинарного файла test, его последующим запуском с помощью /tmp/test 300 & и проверкой что в лог файл записывается: Сервер мониторинга недоступен. HTTP code: 000

Всё отработало корректно в лог файле записано что сервер недоступен так как если физически перейдем по ссылке то сервер не найден

## Как запустить

bash
sudo cp monitoring.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/monitoring.sh
sudo cp monitoring.service monitoring.timer /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now monitoring.timer

## Команды проверки
cp /bin/sleep /tmp/test
chmod +x /tmp/test
/tmp/test 300 &
pgrep -x test
