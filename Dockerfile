# Базовый образ с поддержкой C++ и Boost
FROM ubuntu:22.04

# Устанавливаем основные инструменты для сборки
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    wget \
    git \
    libboost-all-dev \
    libsqlite3-dev \
    sqlite3 \
    libpq-dev \          # Библиотеки для работы с PostgreSQL
    libssl-dev \         # Библиотеки OpenSSL для хеширования паролей
    postgresql \         # Сервер PostgreSQL
    postgresql-contrib \ # Дополнительные инструменты для PostgreSQL
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем библиотеку Boost.Beast
# Boost.Beast входит в состав Boost, поэтому устанавливать его отдельно не нужно

# Скачиваем json.hpp и создаем правильную структуру папок
RUN mkdir -p /usr/local/include/nlohmann && \
    wget -q https://github.com/nlohmann/json/releases/download/v3.11.2/json.hpp -O /usr/local/include/nlohmann/json.hpp

# Создаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта в контейнер
COPY . .

# Собираем проект
RUN mkdir build && cd build && cmake .. && make

# Указываем порт, на котором будет работать сервер
EXPOSE 8080

# Команда для запуска приложения
CMD ["./build/boost_api_server"]