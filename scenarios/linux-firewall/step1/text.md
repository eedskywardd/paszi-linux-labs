# Этап 1. Найдите ошибку маршрута

Проверьте `ip netns list`, `ip netns exec pc ip route` и `ip netns exec fw ip -br addr`. Исправьте маршрут клиента к сети 10.10.20.0/24 через 10.10.10.1. Затем нажмите Check.